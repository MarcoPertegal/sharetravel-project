package com.salesianostriana.dam.sharetravelBackend.rating.dto;

import com.salesianostriana.dam.sharetravelBackend.user.dto.GetDriverByTripDto;
import com.salesianostriana.dam.sharetravelBackend.user.dto.GetPassengerByTripDto;

import java.time.LocalDateTime;
import java.util.UUID;

public record GetRatingDto(
        UUID id,
        LocalDateTime ratingDate,
        double ratingValue,
        String feedback,
        GetDriverByTripDto driver,
        GetPassengerByTripDto passenger
) {
}
