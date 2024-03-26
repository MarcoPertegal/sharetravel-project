package com.salesianostriana.dam.sharetravelBackend.rating.dto;

import java.util.UUID;

public record NewRatingDto(
        double ratingValue,
        String feedback,
        UUID driverId
) {
}
