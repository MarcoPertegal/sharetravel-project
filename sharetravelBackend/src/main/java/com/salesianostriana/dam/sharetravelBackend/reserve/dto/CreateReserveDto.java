package com.salesianostriana.dam.sharetravelBackend.reserve.dto;

import com.salesianostriana.dam.sharetravelBackend.trip.model.Trip;
import com.salesianostriana.dam.sharetravelBackend.user.model.Passenger;
import lombok.Builder;

import java.time.LocalDateTime;
import java.util.UUID;

@Builder
public record CreateReserveDto(
        UUID id,
        LocalDateTime reserveDate,
        UUID passengerId,
        UUID tripId
) {
}
