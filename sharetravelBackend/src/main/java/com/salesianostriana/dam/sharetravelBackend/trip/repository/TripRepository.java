package com.salesianostriana.dam.sharetravelBackend.trip.repository;

import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetAllTripsDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDto;
import com.salesianostriana.dam.sharetravelBackend.trip.model.Trip;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.UUID;

public interface  TripRepository extends JpaRepository<Trip, UUID> {
    @Query("""
            SELECT new com.salesianostriana.dam.sharetravelBackend.trip.dto.GetAllTripsDto(
            t.id,
            t.departurePlace,
            t.arrivalPlace,
            t.departureTime,
            t.estimatedDuration,
            t.arrivalTime,
            t.price
            )
            FROM Trip t
            """)
    Page<GetAllTripsDto> findAllTrips(Pageable pageable);

    @Query("""
    SELECT new com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDto(
        t.id,
        t.departurePlace,
        t.arrivalPlace,
        t.departureTime,
        t.estimatedDuration,
        t.arrivalTime,
        t.price,
            new com.salesianostriana.dam.sharetravelBackend.user.dto.GetDriverByTripDto(
                t.driver.avatar,
                t.driver.fullName
            )
    )
    FROM Trip t
    WHERE (:departurePlace IS NULL OR t.departurePlace = :departurePlace)
        AND (:arrivalPlace IS NULL OR t.arrivalPlace = :arrivalPlace)
        AND (:departureTime IS NULL OR CAST(t.departureTime AS date) = :departureTime)
    """)
    Page<GetTripDto> filterTripsByDeparturePlaceArrivalPlaceAndDepartureTime(
            Pageable pageable,
            String departurePlace,
            String arrivalPlace,
            LocalDate departureTime
    );

}

