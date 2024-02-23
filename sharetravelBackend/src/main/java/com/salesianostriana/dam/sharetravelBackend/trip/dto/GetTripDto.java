package com.salesianostriana.dam.sharetravelBackend.trip.dto;

import java.time.LocalDateTime;
import java.util.UUID;

public record GetTripDto(
        UUID id,
        String departurePlace,
        String arrivalPlace,
        LocalDateTime departureTime,
        int estimatedDuration,
        LocalDateTime arrivalTime,
        double price
        //faltaria meterle el conductor con su nombre
) {
}
