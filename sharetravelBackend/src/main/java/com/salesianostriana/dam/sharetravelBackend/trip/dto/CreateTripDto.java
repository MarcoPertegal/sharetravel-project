package com.salesianostriana.dam.sharetravelBackend.trip.dto;


import lombok.Builder;

import java.time.LocalDateTime;
@Builder
public record CreateTripDto(
        String departurePlace,
        String arrivalPlace,
        LocalDateTime departureTime,
        int estimatedDuration,
        double price,
        String tripDescription
) {

}
