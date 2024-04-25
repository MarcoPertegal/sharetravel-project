package com.salesianostriana.dam.sharetravelBackend.reserve.repository;

import com.salesianostriana.dam.sharetravelBackend.reserve.dto.GetReserveByPassengerIdDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.model.Reserve;
import com.salesianostriana.dam.sharetravelBackend.trip.model.Trip;
import com.salesianostriana.dam.sharetravelBackend.user.model.Passenger;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface ReserveRepository extends JpaRepository<Reserve, UUID> {

    boolean existsByPassengerAndTrip(Passenger passenger, Trip trip);

    @Query("""
            SELECT new com.salesianostriana.dam.sharetravelBackend.reserve.dto.GetReserveByPassengerIdDto(
            r.id,
            r.reserveDate,
                new com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDto(
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
            )
            FROM Reserve r
            JOIN r.trip t
            WHERE r.passenger.id = :id
            """)
    Page<GetReserveByPassengerIdDto> findReservesWithTripByPassengerId(@Param("id") UUID id, Pageable pageable);

    @Query("SELECT r FROM Reserve r WHERE r.trip.id = :tripId")
    List<Reserve> findByTripId(UUID tripId);
}
