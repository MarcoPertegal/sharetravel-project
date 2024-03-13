package com.salesianostriana.dam.sharetravelBackend.user.repository;

import com.salesianostriana.dam.sharetravelBackend.user.model.Passenger;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface PassengerRepository extends JpaRepository<Passenger, UUID> {
    boolean existsByUsernameIgnoreCase(String username);

    Optional<Passenger> findFirstByUsername(String username);
}
