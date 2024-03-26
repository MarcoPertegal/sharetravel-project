package com.salesianostriana.dam.sharetravelBackend.rating.repository;

import com.salesianostriana.dam.sharetravelBackend.rating.model.Rating;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface RatingRepository extends JpaRepository<Rating, UUID> {
}
