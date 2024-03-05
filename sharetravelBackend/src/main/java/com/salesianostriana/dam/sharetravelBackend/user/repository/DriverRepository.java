package com.salesianostriana.dam.sharetravelBackend.user.repository;

import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;
import com.salesianostriana.dam.sharetravelBackend.user.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;
import java.util.UUID;

public interface DriverRepository extends JpaRepository<Driver, UUID> {
    boolean existsByUsernameIgnoreCase(String username);

    Optional<Driver> findFirstByUsername(String username);

    @Query("SELECT d FROM Driver d LEFT JOIN FETCH d.ratings WHERE d.id = :id")
    Optional<Driver> findByIdWithRatings(@Param("id") UUID id);

}
