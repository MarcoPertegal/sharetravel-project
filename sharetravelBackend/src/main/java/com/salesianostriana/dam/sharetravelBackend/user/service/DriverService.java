package com.salesianostriana.dam.sharetravelBackend.user.service;

import com.salesianostriana.dam.sharetravelBackend.user.dto.CreateUserRequest;
import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;
import com.salesianostriana.dam.sharetravelBackend.user.model.UserRole;
import com.salesianostriana.dam.sharetravelBackend.user.repository.DriverRepository;
import com.salesianostriana.dam.sharetravelBackend.user.repository.PassengerRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.EnumSet;

@Service
@RequiredArgsConstructor
public class DriverService {
    private final DriverRepository driverRepository;
    private final PassengerRepository passengerRepository;
    private final PasswordEncoder passwordEncoder;

    public Driver createDriver(CreateUserRequest createUserRequest, EnumSet<UserRole> roles){
        if (driverRepository.existsByUsernameIgnoreCase(createUserRequest.getUsername()) || passengerRepository.existsByUsernameIgnoreCase(createUserRequest.getUsername()))
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Username already exists");

        Driver driver = new Driver();
        driver.setUsername(createUserRequest.getUsername());
        driver.setPassword(passwordEncoder.encode(createUserRequest.getPassword()));
        driver.setAvatar(createUserRequest.getAvatar());
        driver.setFullName(createUserRequest.getFullName());
        driver.setEmail(createUserRequest.getEmail());
        driver.setPhoneNumber(createUserRequest.getPhoneNumber());
        driver.setPersonalDescription(createUserRequest.getPersonalDescription());
        driver.setRoles(roles);

        return driverRepository.save(driver);
    }

    public Driver createUserWithDriverRole(CreateUserRequest createUserRequest) {
        return createDriver(createUserRequest, EnumSet.of(UserRole.DRIVER));
    }

}
