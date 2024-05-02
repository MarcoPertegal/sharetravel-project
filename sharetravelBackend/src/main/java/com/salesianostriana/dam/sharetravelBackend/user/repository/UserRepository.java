package com.salesianostriana.dam.sharetravelBackend.user.repository;

import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetAllTripsDto;
import com.salesianostriana.dam.sharetravelBackend.user.dto.UserDataDto;
import com.salesianostriana.dam.sharetravelBackend.user.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.UUID;

public interface UserRepository extends JpaRepository<User, UUID> {
    boolean existsByUsernameIgnoreCase(String username);

    Optional<User> findFirstByUsername(String username);
    /*
    @Query("""
            SELECT new com.salesianostriana.dam.sharetravelBackend.user.dto.UserDataDto(
            u.id,
            u.avatar,
            u.fullName,
            u.email,
            u.phoneNumber,
            u.personalDescription,
            CAST(u.roles AS string),
            u.createdAt
            )
            FROM User u
            """)
    Page<UserDataDto> findAllUsers(Pageable pageable)*/

}
