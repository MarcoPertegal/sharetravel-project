package com.salesianostriana.dam.sharetravelBackend.trip.dto;

import com.salesianostriana.dam.sharetravelBackend.user.dto.GetDriverByTripDto;
import lombok.Builder;

import java.time.LocalDateTime;

public record CreateTripDto(
        String departurePlace,
        String arrivalPlace,
        LocalDateTime departureTime,
        int estimatedDuration,
        double price,
        String tripDescription
) {

}
