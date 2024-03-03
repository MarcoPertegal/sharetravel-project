package com.salesianostriana.dam.sharetravelBackend.trip.dto;

import com.salesianostriana.dam.sharetravelBackend.reserve.dto.GetReserveByTripDto;
import com.salesianostriana.dam.sharetravelBackend.user.dto.GetDriverByTripDto;
import com.salesianostriana.dam.sharetravelBackend.user.dto.GetPassengerByTripDto;
import lombok.Builder;

import java.time.LocalDateTime;
import java.util.List;

@Builder
public record GetTripDetailsDto(
        String departurePlace,
        String arrivalPlace,
        LocalDateTime departureTime,
        int estimatedDuration,
        LocalDateTime arrivalTime,
        double price,
        String tripDescription,
        GetDriverByTripDto driver,
        List<GetReserveByTripDto> reserves
) {
}
