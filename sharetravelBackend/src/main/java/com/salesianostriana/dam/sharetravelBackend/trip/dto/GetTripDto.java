package com.salesianostriana.dam.sharetravelBackend.trip.dto;

import com.salesianostriana.dam.sharetravelBackend.user.dto.GetDriverByTripDto;
import lombok.Builder;

import java.time.LocalDateTime;
import java.util.UUID;
@Builder
public record GetTripDto(
        UUID id,
        String departurePlace,
        String arrivalPlace,
        LocalDateTime departureTime,
        int estimatedDuration,
        LocalDateTime arrivalTime,
        double price,
        String tripDescription,
        GetDriverByTripDto driver
) {
}
