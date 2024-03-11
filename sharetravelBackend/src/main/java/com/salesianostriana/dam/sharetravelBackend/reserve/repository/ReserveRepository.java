package com.salesianostriana.dam.sharetravelBackend.reserve.repository;

import com.salesianostriana.dam.sharetravelBackend.reserve.model.Reserve;
import com.salesianostriana.dam.sharetravelBackend.trip.model.Trip;
import com.salesianostriana.dam.sharetravelBackend.user.model.Passenger;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface ReserveRepository extends JpaRepository<Reserve, UUID> {

    boolean existsByPassengerAndTrip(Passenger passenger, Trip trip);

}
