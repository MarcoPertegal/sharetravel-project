package com.salesianostriana.dam.sharetravelBackend.trip.dto;

import java.time.LocalDateTime;
import java.util.UUID;

public record GetAllTripsDto(
        UUID id,
        String departurePlace,
        String arrivalPlace,
        LocalDateTime departureTime,
        int estimatedDuration,
        LocalDateTime arrivalTime,
        double price
) {
}
