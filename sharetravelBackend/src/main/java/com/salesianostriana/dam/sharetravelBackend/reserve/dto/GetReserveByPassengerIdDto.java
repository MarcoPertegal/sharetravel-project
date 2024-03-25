package com.salesianostriana.dam.sharetravelBackend.reserve.dto;

import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDto;

import java.time.LocalDateTime;
import java.util.UUID;

public record GetReserveByPassengerIdDto(
        UUID id,
        LocalDateTime reserveDate,
        GetTripDto trip
) {
}
