package com.salesianostriana.dam.sharetravelBackend.rating.dto;

import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.UUID;

public record NewRatingDto(
        @NotNull(message = "Rating value cannot be null")
        @Min(value = 1, message = "The rating value must be at least 1")
        @Digits(integer=10, fraction=1, message = "Rating value must not have more than one decimal")
        double ratingValue,
        @NotBlank(message = "Feedback cannot be empty")
        String feedback,
        UUID driverId
) {
}
