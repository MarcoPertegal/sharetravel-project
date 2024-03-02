package com.salesianostriana.dam.sharetravelBackend.user.service;

import com.salesianostriana.dam.sharetravelBackend.user.dto.CreateUserRequest;
import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;
import com.salesianostriana.dam.sharetravelBackend.user.model.UserRole;
import com.salesianostriana.dam.sharetravelBackend.user.repository.DriverRepository;
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
    private final PasswordEncoder passwordEncoder;

   /*
   public Passenger createPassenger(CreateUserRequest createUserRequest, EnumSet<UserRole> roles){
        if (passengerRepository.existsByUsernameIgnoreCase(createUserRequest.getUsername()))
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Passenger name alredy exists");
        Passenger passenger = new Passenger();
        passenger.setUsername(createUserRequest.getUsername());
        passenger.setPassword(passwordEncoder.encode(createUserRequest.getPassword()));
        passenger.setAvatar(createUserRequest.getAvatar());
        passenger.setFullName(createUserRequest.getFullName());
        passenger.setEmail(createUserRequest.getEmail());
        passenger.setPhoneNumber(createUserRequest.getPhoneNumber());
        passenger.setPersonalDescription(createUserRequest.getPersonalDescription());
        passenger.setRoles(roles);

        return passengerRepository.save(passenger);
    }

    public Passenger createUserWithPassengerRole(CreateUserRequest createUserRequest) {
        return createPassenger(createUserRequest, EnumSet.of(UserRole.PASSENGER));
    }
    */

    public Driver createDriver(CreateUserRequest createUserRequest, EnumSet<UserRole> roles){
        if (driverRepository.existsByUsernameIgnoreCase(createUserRequest.getUsername()))
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Driver name alredy exists");
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
