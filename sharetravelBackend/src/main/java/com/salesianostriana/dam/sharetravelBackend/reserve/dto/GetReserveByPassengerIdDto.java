package com.salesianostriana.dam.sharetravelBackend.reserve.dto;

import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDto;

import java.time.LocalDateTime;

public record GetReserveByPassengerIdDto(
        LocalDateTime reserveDate,
        GetTripDto trip
) {
}
