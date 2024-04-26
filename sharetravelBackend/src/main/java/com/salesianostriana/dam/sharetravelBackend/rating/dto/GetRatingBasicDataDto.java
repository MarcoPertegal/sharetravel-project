package com.salesianostriana.dam.sharetravelBackend.rating.dto;

import lombok.Builder;

import java.time.LocalDateTime;
import java.util.UUID;
@Builder
public record GetRatingBasicDataDto(
        UUID id,
        LocalDateTime ratingDate,
        double ratingValue,
        String feedback
) {
}
