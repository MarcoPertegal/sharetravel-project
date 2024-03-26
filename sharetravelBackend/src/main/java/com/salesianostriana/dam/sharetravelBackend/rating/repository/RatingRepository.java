package com.salesianostriana.dam.sharetravelBackend.rating.repository;

import com.salesianostriana.dam.sharetravelBackend.rating.dto.GetRatingDto;
import com.salesianostriana.dam.sharetravelBackend.rating.model.Rating;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetAllTripsDto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.UUID;

public interface RatingRepository extends JpaRepository<Rating, UUID> {
    @Query("""
            SELECT new com.salesianostriana.dam.sharetravelBackend.rating.dto.GetRatingDto(
            r.id,
            r.ratingDate,
            r.ratingValue,
            r.feedback
            )
            FROM Rating r
            """)
    Page<GetRatingDto> findAllRatings(Pageable pageable);
}
