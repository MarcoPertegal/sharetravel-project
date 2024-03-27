package com.salesianostriana.dam.sharetravelBackend.rating.repository;

import com.salesianostriana.dam.sharetravelBackend.rating.dto.GetRatingByDriverIdDto;
import com.salesianostriana.dam.sharetravelBackend.rating.dto.GetRatingDto;
import com.salesianostriana.dam.sharetravelBackend.rating.model.Rating;
import com.salesianostriana.dam.sharetravelBackend.reserve.dto.GetReserveByPassengerIdDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetAllTripsDto;
import com.salesianostriana.dam.sharetravelBackend.trip.model.Trip;
import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;
import com.salesianostriana.dam.sharetravelBackend.user.model.Passenger;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

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

    boolean existsByPassengerAndDriver(Passenger passenger, Driver driver);

    @Query("""
            SELECT new com.salesianostriana.dam.sharetravelBackend.rating.dto.GetRatingByDriverIdDto(
            r.id,
            r.ratingValue,
            r.feedback,
                new com.salesianostriana.dam.sharetravelBackend.user.dto.GetPassengerByTripDto(
                    p.avatar,
                    p.fullName
                )
            )
            FROM Rating r
            JOIN r.passenger p
            WHERE r.driver.id = :id
            """)
    Page<GetRatingByDriverIdDto> findRatingsWithPassengerByDriverId(@Param("id") UUID id, Pageable pageable);
}
