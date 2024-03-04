package com.salesianostriana.dam.sharetravelBackend.user.dto;

import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;

public record GetDriverByTripDto (
        String avatar,
        String fullName
){
    public static GetDriverByTripDto of(Driver d){
        return new GetDriverByTripDto(
                d.getAvatar(),
                d.getFullName()
        );
    }

}
