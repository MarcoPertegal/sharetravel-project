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
