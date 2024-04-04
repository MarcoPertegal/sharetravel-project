package com.salesianostriana.dam.sharetravelBackend.trip.dto;


import jakarta.validation.constraints.*;
import lombok.Builder;

import java.time.LocalDateTime;
@Builder
public record CreateTripDto(
        @NotBlank(message = "Departure place cannot be empty")
        @Pattern(regexp = "^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ ]+$", message = "Departure place can only contain letters, spaces, and accents")
        String departurePlace,
        @NotBlank(message = "Arrival place cannot be empty")
        @Pattern(regexp = "^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ ]+$", message = "Arrival place can only contain letters, spaces, and accents")
        String arrivalPlace,
        @NotNull(message = "The estimated duration cannot be null")
        LocalDateTime departureTime,
        @NotNull(message = "The estimated duration cannot be null")
        @Min(value = 1, message = "The estimated duration must be at least 1")
        int estimatedDuration,
        @NotNull(message = "Price cannot be null")
        @Min(value = 1, message = "The price must be at least 1")
        @Digits(integer=10, fraction=2, message = "Price must not have more than two decimals")
        double price,
        @NotBlank(message = "Trip description cant be empty")
        String tripDescription
) {

}
