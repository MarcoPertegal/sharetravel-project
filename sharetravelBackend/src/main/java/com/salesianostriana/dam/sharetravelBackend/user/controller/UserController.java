package com.salesianostriana.dam.sharetravelBackend.user.controller;

import com.salesianostriana.dam.sharetravelBackend.rating.dto.GetRatingBasicDataDto;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.access.JwtProvider;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh.RefreshToken;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh.RefreshTokenException;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh.RefreshTokenRequest;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh.RefreshTokenService;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.CreateTripDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetAllTripsDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDto;
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
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.Optional;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final AuthenticationManager authManager;
    private final JwtProvider jwtProvider;
    private final RefreshTokenService refreshTokenService;


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


        User authenticatedUser = (User) authentication.getPrincipal();


        String token = jwtProvider.generateToken(authenticatedUser);


        refreshTokenService.deleteByUser(authenticatedUser);

        RefreshToken refreshToken = refreshTokenService.createRefreshToken(authenticatedUser.getId());

        JwtUserResponse jwtUserResponse = JwtUserResponse.of(authenticatedUser, token, refreshToken.getToken());
        return ResponseEntity.status(HttpStatus.CREATED).body(jwtUserResponse);
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
                    RefreshToken refreshToken2 = refreshTokenService.createRefreshToken(user.getId());
                    return ResponseEntity.status(HttpStatus.CREATED)
                            .body(JwtUserResponse.builder()
                                    .token(token)
                                    .refreshToken(refreshToken2.getToken())
                                    .build()
                            );
                }).orElseThrow(() -> new RefreshTokenException("Refresh token not found"));
    }


    @Operation(summary = "Get logged user details")
    @ApiResponses(value = {
            @ApiResponse(responseCode ="200",
                    description = "Get logged user details",
                    content = { @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetUserDetailsDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": "744ae11c-3332-42ec-bb45-f2839eb06e21",
                                                "name": "Maria",
                                                "lastName": "Rodriguez",
                                                "birthDate": "1985-08-22",
                                                "dni": "987654321",
                                                "email": "maria@gmail.com"
                                            }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "the user has not been found",
                    content = @Content),
    })
    @GetMapping("/user/details")
    public ResponseEntity<GetUserDetailsDto> getLoggedUserDetails(@AuthenticationPrincipal User loggedUser) {
        return ResponseEntity.ok(userService.findLoggedById(loggedUser));
    }

    @Operation(summary = "Get all users")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Users have been found",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = UserDataDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "content": [
                                                    {
                                                        "id": "09fe7587-487a-49ba-8188-ec1a9ddc7b3f",
                                                        "avatar": "https://previews.123rf.com/images/rawpixel/rawpixel1704/rawpixel170441704/76561515-retrato-de-personas-estudio-disparar-con-expresi%C3%B3n-de-cara-sonriente.jpg",
                                                        "username": "marco123",
                                                        "fullName": "Marco Pertegal Prieto",
                                                        "email": "marco@gmail.com",
                                                        "phoneNumber": "408452322",
                                                        "personalDescription": "Reliable driver who values punctuality and silence during the journey. Efficient and uncomplicated routes, no room for unnecessary chatter.",
                                                        "roles": "[DRIVER]",
                                                        "createdAt": "2024-05-01T21:00:00"
                                                    },
                                                    {
                                                        "id": "d85d42e8-5950-4b7a-9a1d-06716fa8ef47",
                                                        "avatar": "https://www.redaccionmedica.com/images/destacados/las-personas-con-un-riesgo-genetico-bajo-de-tdah-son-mas-afortunadas--2868.jpg",
                                                        "username": "miguel123",
                                                        "fullName": "Miguel Campos González",
                                                        "email": "miguel@gmail.com",
                                                        "phoneNumber": "706424242",
                                                        "personalDescription": "Road trip enthusiast who loves exploring new destinations. Offering a relaxed and friendly atmosphere. Ready to share road trip stories and interesting discoveries.",
                                                        "roles": "[DRIVER]",
                                                        "createdAt": "2024-05-01T21:00:00"
                                                    },
                                                    {
                                                        "id": "0c0e22b3-92b0-413b-90bc-1fd837ba5fba",
                                                        "avatar": "https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg",
                                                        "username": "admin123",
                                                        "fullName": null,
                                                        "email": null,
                                                        "phoneNumber": null,
                                                        "personalDescription": null,
                                                        "roles": "[ADMIN]",
                                                        "createdAt": "2024-05-01T21:00:00"
                                                    },
                                                    {
                                                        "id": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
                                                        "avatar": "https://f.rpp-noticias.io/2019/02/15/753300descarga-11jpg.jpg",
                                                        "username": "fran123",
                                                        "fullName": "Fran Ruíz Prieto",
                                                        "email": "fran@gmail.com",
                                                        "phoneNumber": "604234567",
                                                        "personalDescription": "Relaxed traveler seeking peaceful experiences. Enjoying the scenery and soft music. A pleasant and calm companion for the journey.",
                                                        "roles": "[PASSENGER]",
                                                        "createdAt": "2024-05-01T21:00:00"
                                                    },
                                                    {
                                                        "id": "ef9458e8-7834-4df8-ba48-79aadfaa42d3",
                                                        "avatar": "https://www.laguiadelvaron.com/wp-content/uploads/2018/12/ai-image-generation-fake-faces-people-nvidia-5c18b20b472c2__700.jpg",
                                                        "username": "fernando123",
                                                        "fullName": "Fernando Pérez Gil",
                                                        "email": "fernando@gmail.com",
                                                        "phoneNumber": "606040205",
                                                        "personalDescription": "Passionate about reading, always carrying a good book to immerse myself during the journey. Not much of a talker, but always ready to share literary recommendations.",
                                                        "roles": "[PASSENGER]",
                                                        "createdAt": "2024-05-01T21:00:00"
                                                    }
                                                ],
                                                "pageable": {
                                                    "pageNumber": 0,
                                                    "pageSize": 8,
                                                    "sort": {
                                                        "empty": true,
                                                        "unsorted": true,
                                                        "sorted": false
                                                    },
                                                    "offset": 0,
                                                    "paged": true,
                                                    "unpaged": false
                                                },
                                                "last": true,
                                                "totalPages": 1,
                                                "totalElements": 5,
                                                "size": 8,
                                                "number": 0,
                                                "sort": {
                                                    "empty": true,
                                                    "unsorted": true,
                                                    "sorted": false
                                                },
                                                "first": true,
                                                "numberOfElements": 5,
                                                "empty": false
                                            }
                                            
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "no users has been found",
                    content = @Content),
    })
    @GetMapping("/user/")
    public ResponseEntity<Page<UserDataDto>> getAllUsers(@PageableDefault(page = 0, size = 8) Pageable p){
        return ResponseEntity.ok(userService.getAllUsers(p));
    }

    @Operation(summary = "Edit user by id")
    @ApiResponses(value = {
            @ApiResponse(responseCode ="201",
                    description = "User has been edited",
                    content = { @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = UserDataDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "User not found",
                    content = @Content),
    })
    @CrossOrigin
    @PutMapping("/user/{id}")
    public ResponseEntity<UserDataDto> editUser(@PathVariable String id, @Valid @RequestBody EditUserDto editUserDto) {
        return ResponseEntity.status(HttpStatus.CREATED).body(userService.editUser(UUID.fromString(id), editUserDto));
    }

    @Operation(summary = "Get user by id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "User has been found",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = UserDataDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                              {
                                                  "id": "09fe7587-487a-49ba-8188-ec1a9ddc7b3f",
                                                  "avatar": "https://previews.123rf.com/images/rawpixel/rawpixel1704/rawpixel170441704/76561515-retrato-de-personas-estudio-disparar-con-expresi%C3%B3n-de-cara-sonriente.jpg",
                                                  "username": "marco123",
                                                  "fullName": "Marco Pertegal Prieto",
                                                  "email": "marco@gmail.com",
                                                  "phoneNumber": "408452322",
                                                  "personalDescription": "Reliable driver who values punctuality and silence during the journey. Efficient and uncomplicated routes, no room for unnecessary chatter.",
                                                  "roles": "[DRIVER]",
                                                  "createdAt": "2024-05-01T21:00:00"
                                              }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "User dont found",
                    content = @Content)
    })
    @GetMapping("/user/{id}")
    public ResponseEntity<UserDataDto> findUserById(@PathVariable String id){
        return ResponseEntity.ok(userService.getUserById(UUID.fromString(id)));
    }


    @Operation(summary = "Delete user by id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "User delete successfully",
                    content = @Content
            ),
            @ApiResponse(
                    responseCode = "404",
                    description = "User not found",
                    content = @Content
            )
    })
    @CrossOrigin
    @DeleteMapping("/user/{id}")
    public ResponseEntity<?> deleteUser(@PathVariable String id){
        userService.deleteByUserId(UUID.fromString(id));
        return ResponseEntity.noContent().build();
    }

}
