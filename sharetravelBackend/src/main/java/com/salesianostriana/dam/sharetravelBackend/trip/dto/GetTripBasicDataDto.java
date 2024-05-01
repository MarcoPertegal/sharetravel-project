package com.salesianostriana.dam.sharetravelBackend.trip.dto;

import java.util.UUID;

public record GetTripBasicDataDto(
        UUID id,
        String departurePlace,
        String arrivalPlace,
        double price
) {

}
