package com.salesianostriana.dam.sharetravelBackend.user.controller;

import com.salesianostriana.dam.sharetravelBackend.security.jwt.access.JwtProvider;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh.RefreshToken;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh.RefreshTokenService;
import com.salesianostriana.dam.sharetravelBackend.user.dto.CreateUserRequest;
import com.salesianostriana.dam.sharetravelBackend.user.dto.JwtUserResponse;
import com.salesianostriana.dam.sharetravelBackend.user.dto.UserResponse;
import com.salesianostriana.dam.sharetravelBackend.user.model.Passenger;
import com.salesianostriana.dam.sharetravelBackend.user.service.PassengerService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.validation.Valid;
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
public class PassengerController {

    private final PassengerService passengerService;
    private final AuthenticationManager authManager;
    private final JwtProvider jwtProvider;
    private final RefreshTokenService refreshTokenService;

    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Register as passenger", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = UserResponse.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": "bbd04afb-5159-40e0-bae3-f6d647ddb0d7",
                                                "username": "passenger2",
                                                "avatar": "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                                "fullName": "passenger passenger",
                                                "userRol": "[PASSENGER]",
                                                "createdAt": "12/03/2024 00:48:44",
                                                "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJiYmQwNGFmYi01MTU5LTQwZTAtYmFlMy1mNmQ2NDdkZGIwZDciLCJpYXQiOjE3MTAyMDA5MjUsImV4cCI6MTcxMDIwNjkyNX0.k_4VwZsWxfuFbpioBg2sn-MU1JyY5nSFdJkovDrwykuCV-DX5Z1E6k0P-YZeVBIZcj-9jBik7__fVv5-de9m-w",
                                                "refreshToken": "89b6ff15-014c-4e4a-8052-976e1f95e836"
                                            }                                 
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400", description = "Introduced data not valid", content = @Content)
    })
    @Operation(summary = "createUserWithPassengerRole", description = "Register as passenger")
    @PostMapping("/auth/register/passenger")
    public ResponseEntity<UserResponse> createUserWithPassengerRole(@Valid @RequestBody CreateUserRequest createPassengerRequest) {
        Passenger passenger = passengerService.createUserWithPassengerRole(createPassengerRequest);
        Authentication authentication =
                authManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                createPassengerRequest.getUsername(),
                                createPassengerRequest.getPassword()
                        )
                );
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String token = jwtProvider.generateToken(authentication);
        refreshTokenService.deleteByUser(passenger);
        RefreshToken refreshToken = refreshTokenService.createRefreshToken(passenger.getId());


        return ResponseEntity.status(HttpStatus.CREATED).body(JwtUserResponse.of(passenger, token, refreshToken.getToken()));
    }
}
