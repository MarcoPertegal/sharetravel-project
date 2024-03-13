package com.salesianostriana.dam.sharetravelBackend.user.controller;

import com.salesianostriana.dam.sharetravelBackend.security.jwt.access.JwtProvider;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh.RefreshToken;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh.RefreshTokenService;
import com.salesianostriana.dam.sharetravelBackend.user.dto.CreateUserRequest;
import com.salesianostriana.dam.sharetravelBackend.user.dto.JwtUserResponse;
import com.salesianostriana.dam.sharetravelBackend.user.dto.UserResponse;
import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;
import com.salesianostriana.dam.sharetravelBackend.user.service.DriverService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class DriverController {

    private final DriverService driverService;
    private final AuthenticationManager authManager;
    private final JwtProvider jwtProvider;
    private final RefreshTokenService refreshTokenService;

    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Register as driver", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = UserResponse.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": "ac3a7991-0c5f-4f5c-9fb1-aa2434d8236b",
                                                "username": "driver2",
                                                "avatar": "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                                "fullName": "driver driver",
                                                "userRol": "[DRIVER]",
                                                "createdAt": "12/03/2024 00:48:49",
                                                "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhYzNhNzk5MS0wYzVmLTRmNWMtOWZiMS1hYTI0MzRkODIzNmIiLCJpYXQiOjE3MTAyMDA5MzAsImV4cCI6MTcxMDIwNjkzMH0.oFDrcZoeDvzzcavL-Dr1mtGkw465uc0u4ZgfFaMHtcaMpBTZBz1GFaYdT0VYISWGbrOBJo1ivb37cTtE1l_rKw",
                                                "refreshToken": "99aac849-be46-47b0-aef0-9323ee468f83"
                                            }                                
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400", description = "Introduced data not valid", content = @Content)
    })
    @Operation(summary = "createUserWithDriverRole", description = "Register as driver")
    @PostMapping("/auth/register/driver")
    public ResponseEntity<UserResponse> createUserWithDriverRole(@RequestBody CreateUserRequest createPassengerRequest) {
        Driver driver = driverService.createUserWithDriverRole(createPassengerRequest);
        Authentication authentication =
                authManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                createPassengerRequest.getUsername(),
                                createPassengerRequest.getPassword()
                        )
                );
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String token = jwtProvider.generateToken(authentication);
        refreshTokenService.deleteByUser(driver);
        RefreshToken refreshToken = refreshTokenService.createRefreshToken(driver);

        return ResponseEntity.status(HttpStatus.CREATED).body(JwtUserResponse.of(driver, token, refreshToken.getToken()));
    }
}
