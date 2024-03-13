package com.salesianostriana.dam.sharetravelBackend.user.service;

import com.salesianostriana.dam.sharetravelBackend.user.dto.CreateUserRequest;
import com.salesianostriana.dam.sharetravelBackend.user.model.Passenger;
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
public class PassengerService {
    private final PassengerRepository passengerRepository;
    private final PasswordEncoder passwordEncoder;
    private final DriverRepository driverRepository;


    public Passenger createPassenger(CreateUserRequest createUserRequest, EnumSet<UserRole> roles){
        if (passengerRepository.existsByUsernameIgnoreCase(createUserRequest.getUsername()) || driverRepository.existsByUsernameIgnoreCase(createUserRequest.getUsername()))
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Username already exists");
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

}
