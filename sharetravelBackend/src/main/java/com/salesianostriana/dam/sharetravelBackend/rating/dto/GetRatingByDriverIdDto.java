package com.salesianostriana.dam.sharetravelBackend.rating.dto;

import com.salesianostriana.dam.sharetravelBackend.user.dto.GetPassengerByTripDto;

import java.util.UUID;

public record GetRatingByDriverIdDto(
        UUID id,
        double ratingValue,
        String feedback,
        GetPassengerByTripDto passenger
) {
}
