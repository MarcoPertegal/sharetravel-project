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
                                                "id": "cd5c0c8f-7f0a-4116-b988-df9848a94642",
                                                "username": "passenger2",
                                                "avatar": "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                                "fullName": "passenger passenger",
                                                "createdAt": "02/03/2024 15:30:25",
                                                "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjZDVjMGM4Zi03ZjBhLTQxMTYtYjk4OC1kZjk4NDhhOTQ2NDIiLCJpYXQiOjE3MDkzODk4MjUsImV4cCI6MTcwOTM5MDQyNX0.8EUKgvxczCC83M2yDK9JB3MMGAW5RncglD3NMuQcwztjTSrPbga7k5WsmcoptXmk4NBIkxPbUyRURTPCFS4ZEQ",
                                                "refreshToken": "ac10b000-bf33-4aef-8d3e-2c01de5e2d21"
                                            }                                  
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400", description = "Introduced data not valid", content = @Content)
    })
    @Operation(summary = "createUserWithPassengerRole", description = "Register as passenger")
    @PostMapping("/auth/register/passenger")
    public ResponseEntity<UserResponse> createUserWithPassengerRole(@RequestBody CreateUserRequest createPassengerRequest) {
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
        RefreshToken refreshToken = refreshTokenService.createRefreshToken(passenger);


        return ResponseEntity.status(HttpStatus.CREATED).body(JwtUserResponse.of(passenger, token, refreshToken.getToken()));
    }
}
