package com.salesianostriana.dam.sharetravelBackend.user.controller;

import com.salesianostriana.dam.sharetravelBackend.security.jwt.access.JwtProvider;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh.RefreshToken;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh.RefreshTokenService;
import com.salesianostriana.dam.sharetravelBackend.user.dto.CreateUserRequest;
import com.salesianostriana.dam.sharetravelBackend.user.dto.JwtUserResponse;
import com.salesianostriana.dam.sharetravelBackend.user.dto.UserResponse;
import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;
import com.salesianostriana.dam.sharetravelBackend.user.model.Passenger;
import com.salesianostriana.dam.sharetravelBackend.user.service.DriverService;
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
                                                "id": "aa22bf2f-eaa3-454f-8d7e-8bb478a16cb7",
                                                "username": "driver2",
                                                "avatar": "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                                "fullName": "driver driver",
                                                "createdAt": "02/03/2024 15:28:53",
                                                "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhYTIyYmYyZi1lYWEzLTQ1NGYtOGQ3ZS04YmI0NzhhMTZjYjciLCJpYXQiOjE3MDkzODk3MzMsImV4cCI6MTcwOTM5MDMzM30.zJ44O5zNgZ-0QlZmh3wDtSOMK3h-r8xWZy5w_kj0zQHgIvXJR5z4lG0sz2oGMpxaBJ-n_veUV3SYT1suKBFP5g",
                                                "refreshToken": "b5063ee9-a1dd-46f8-9b42-0aed77614aec"
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
