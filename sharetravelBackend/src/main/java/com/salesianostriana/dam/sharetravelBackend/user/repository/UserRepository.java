package com.salesianostriana.dam.sharetravelBackend.user.repository;

import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetAllTripsDto;
import com.salesianostriana.dam.sharetravelBackend.user.dto.UserDataDto;
import com.salesianostriana.dam.sharetravelBackend.user.model.User;
import com.salesianostriana.dam.sharetravelBackend.user.model.UserRole;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserRepository extends JpaRepository<User, UUID> {
    boolean existsByUsernameIgnoreCase(String username);
    Optional<User> findFirstByUsername(String username);
    Page<User> findByRoles(UserRole role, Pageable pageable);
}
