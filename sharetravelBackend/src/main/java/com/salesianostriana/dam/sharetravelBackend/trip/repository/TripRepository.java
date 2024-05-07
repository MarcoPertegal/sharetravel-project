package com.salesianostriana.dam.sharetravelBackend.trip.repository;

import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetAllTripsDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDto;
import com.salesianostriana.dam.sharetravelBackend.trip.model.Trip;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Optional;
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
            t.price,
            t.tripDescription
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
        t.tripDescription,
            new com.salesianostriana.dam.sharetravelBackend.user.dto.GetDriverByTripDto(
                t.driver.id,
                t.driver.avatar,
                t.driver.fullName
            )
    )
    FROM Trip t
    WHERE (:departurePlace IS NULL OR t.departurePlace = :departurePlace)
        AND (:arrivalPlace IS NULL OR t.arrivalPlace = :arrivalPlace)
        AND (cast(:departureTime as date) IS NULL OR CAST(t.departureTime AS date) = :departureTime)
    """)
    Page<GetTripDto> filterTripsByDeparturePlaceArrivalPlaceAndDepartureTime(
            Pageable pageable,
            String departurePlace,
            String arrivalPlace,
            LocalDate departureTime
    );


    @Query("""
    SELECT new com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDto(
        t.id,
        t.departurePlace,
        t.arrivalPlace,
        t.departureTime,
        t.estimatedDuration,
        t.arrivalTime,
        t.price,
        t.tripDescription,
        new com.salesianostriana.dam.sharetravelBackend.user.dto.GetDriverByTripDto(
            t.driver.id,
            t.driver.avatar,
            t.driver.fullName
        )
    )
    FROM Trip t
    LEFT JOIN t.driver d
    WHERE d.id = :id
    """)
    Page<GetTripDto> findTripsByDriverId(@Param("id") UUID id, Pageable pageable);

    @Query("""
            SELECT t 
            FROM Trip t 
            LEFT JOIN FETCH t.driver 
            LEFT JOIN FETCH t.reserves 
            WHERE t.id = :id
            """)
    Optional<Trip> findByIdWithDriverAndReserves(@Param("id") UUID id);
}



