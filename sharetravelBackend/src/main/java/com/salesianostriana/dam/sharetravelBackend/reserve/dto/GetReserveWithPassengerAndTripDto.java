package com.salesianostriana.dam.sharetravelBackend.reserve.dto;

import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripBasicDataDto;
import com.salesianostriana.dam.sharetravelBackend.user.dto.GetPassengerByTripDto;

import java.time.LocalDateTime;
import java.util.UUID;

public record GetReserveWithPassengerAndTripDto(
        UUID id,
        LocalDateTime reserveDate,
        GetTripBasicDataDto trip,
        GetPassengerByTripDto passenger

) {
}
