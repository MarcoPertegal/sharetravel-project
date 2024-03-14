package com.salesianostriana.dam.sharetravelBackend.reserve.dto;

import lombok.Builder;

import java.time.LocalDateTime;
import java.util.UUID;

@Builder
public record CreateReserveDto(
        UUID id,
        LocalDateTime reserveDate,
        UUID passengerId,
        UUID tripId
) {
}
