package com.salesianostriana.dam.sharetravelBackend.user.dto;

import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;
import com.salesianostriana.dam.sharetravelBackend.user.model.Passenger;

public record GetPassengerByTripDto(
        String avatar,
        String fullName
) {
    public static GetPassengerByTripDto of(Passenger p){
        return new GetPassengerByTripDto(
                p.getAvatar(),
                p.getFullName()
        );
    }

}
