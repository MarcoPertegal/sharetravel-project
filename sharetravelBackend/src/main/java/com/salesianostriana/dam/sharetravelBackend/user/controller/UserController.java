package com.salesianostriana.dam.sharetravelBackend.user.controller;

import com.salesianostriana.dam.sharetravelBackend.security.jwt.access.JwtProvider;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh.RefreshToken;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh.RefreshTokenException;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh.RefreshTokenRequest;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh.RefreshTokenService;
import com.salesianostriana.dam.sharetravelBackend.user.dto.*;
import com.salesianostriana.dam.sharetravelBackend.user.model.User;
import com.salesianostriana.dam.sharetravelBackend.user.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.Optional;

@RestController
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final AuthenticationManager authManager;
    private final JwtProvider jwtProvider;
    private final RefreshTokenService refreshTokenService;


    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Register as user", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = UserResponse.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": "2901482f-de20-4259-986f-8c48cbc37c96",
                                                "username": "user1",
                                                "avatar": "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                                "fullName": "user user",
                                                "createdAt": "22/02/2024 09:19:05",
                                                "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyOTAxNDgyZi1kZTIwLTQyNTktOTg2Zi04YzQ4Y2JjMzdjOTYiLCJpYXQiOjE3MDg1ODk5NDUsImV4cCI6MTcwODU5MDAwNX0._3SxZe-6FtHBTOcgyCWpkMFGWCLZrQByeRum96ArWXEisTxenETU2J17j2gSx_D09ZkD58aqjVDn9hgIJdzEUQ",
                                                "refreshToken": "1c4d734a-f52e-4a6e-9de2-67cb604c105f"
                                            }                                  
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400", description = "Introduced data not valid", content = @Content)
    })
    @Operation(summary = "createUserWithUserRole", description = "Register as user")
    @PostMapping("/auth/register")
    public ResponseEntity<UserResponse> createUserWithUserRole(@RequestBody CreateUserRequest createUserRequest) {
        User user = userService.createUserWithUserRole(createUserRequest);
        Authentication authentication =
                authManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                createUserRequest.getUsername(),
                                createUserRequest.getPassword()
                        )
                );
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String token = jwtProvider.generateToken(authentication);
        refreshTokenService.deleteByUser(user);
        RefreshToken refreshToken = refreshTokenService.createRefreshToken(user);


        return ResponseEntity.status(HttpStatus.CREATED).body(JwtUserResponse.of(user, token, refreshToken.getToken()));
    }


    @PostMapping("/auth/register/admin")
    public ResponseEntity<UserResponse> createUserWithAdminRole(@RequestBody CreateUserRequest createUserRequest) {
        User user = userService.createUserWithAdminRole(createUserRequest);

        return ResponseEntity.status(HttpStatus.CREATED).body(UserResponse.fromUser(user));
    }


    @PostMapping("/auth/login")
    public ResponseEntity<JwtUserResponse> login(@RequestBody LoginRequest loginRequest) {

        Authentication authentication =
                authManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                loginRequest.getUsername(),
                                loginRequest.getPassword()
                        )
                );

        // Una vez realizada, la guardamos en el contexto de seguridad
        //lo almacenamos en e contexto de seguridad
        SecurityContextHolder.getContext().setAuthentication(authentication);

        //generamos el token
        String token = jwtProvider.generateToken(authentication);

        //obtenemos el usuario del principal
        User user = (User) authentication.getPrincipal();

        //eliminamos algun toquen de acceso caducado de usuario que se está loggeando si lo tuviese
        refreshTokenService.deleteByUser(user);

        //creamos el refresh token
        RefreshToken refreshToken = refreshTokenService.createRefreshToken(user);

        //añadimos el tokem de refresco como string llamando al atributo token de la clase
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(JwtUserResponse.of(user, token, refreshToken.getToken()));


    }

    @PutMapping("/user/changePassword")
    public ResponseEntity<UserResponse> changePassword(@RequestBody ChangePasswordRequest changePasswordRequest,
                                                       @AuthenticationPrincipal User loggedUser) {

        // Este código es mejorable.
        // La validación de la contraseña nueva se puede hacer con un validador.
        // La gestión de errores se puede hacer con excepciones propias
        try {
            if (userService.passwordMatch(loggedUser, changePasswordRequest.getOldPassword())) {
                Optional<User> modified = userService.editPassword(loggedUser.getId(), changePasswordRequest.getNewPassword());
                if (modified.isPresent())
                    return ResponseEntity.ok(UserResponse.fromUser(modified.get()));
            } else {
                // Lo ideal es que esto se gestionara de forma centralizada
                // Se puede ver cómo hacerlo en la formación sobre Validación con Spring Boot
                // y la formación sobre Gestión de Errores con Spring Boot
                throw new RuntimeException();
            }
        } catch (RuntimeException ex) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Password Data Error");
        }

        return null;
    }


    @PreAuthorize("isAuthenticated()")
    @GetMapping("/me")
    public ResponseEntity<UserResponse> getLoggedUser(@AuthenticationPrincipal User user) {
        return ResponseEntity.ok(UserResponse.fromUser(user));
    }

    @PostMapping("/refreshtoken")
    public ResponseEntity<?> refreshToken(@RequestBody RefreshTokenRequest refreshTokenRequest){
        //recibimos token de refresco
        String refreshToken = refreshTokenRequest.getRefreshToken();

        //buscar entidad a partir del string verificarla si la conseguimos verificar obtener el usuario
        //y generar nueva pareja de token y devolverlos
        //buscamos el token de refresco, si no lo encontramos devolvemos excepcion
        //si lo encontramos lo verificamos del token verificado obtenemos el usuario a partir
        //del user generamos el token de acceso, eliminamos token de refresco antiguo, generamos uno nuevo
        //y devolvemos la nueva pareja
        return refreshTokenService.findByToken(refreshToken)
                .map(refreshTokenService::verify)
                .map(RefreshToken::getUser)
                .map(user -> {
                    //vamos a devolver la respuesta de la pareja de token
                    String token = jwtProvider.generateToken(user);
                    refreshTokenService.deleteByUser(user);
                    RefreshToken refreshToken2 = refreshTokenService.createRefreshToken(user);
                    return ResponseEntity.status(HttpStatus.CREATED)
                            .body(JwtUserResponse.builder()
                                    .token(token)
                                    .refreshToken(refreshToken2.getToken())
                                    .build()
                            );
                }).orElseThrow(() -> new RefreshTokenException("Refresh token not found"));
    }





}
