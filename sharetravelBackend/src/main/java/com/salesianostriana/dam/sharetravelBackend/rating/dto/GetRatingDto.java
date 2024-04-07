package com.salesianostriana.dam.sharetravelBackend.rating.dto;

import java.time.LocalDateTime;
import java.util.UUID;

public record GetRatingDto(
        UUID id,
        LocalDateTime ratingDate,
        double ratingValue,
        String feedback
) {
}
