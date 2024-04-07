package com.salesianostriana.dam.sharetravelBackend.user.dto;

import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;

import java.util.UUID;

public record GetDriverByTripDto (
        UUID id,
        String avatar,
        String fullName
){
    public static GetDriverByTripDto of(Driver d){
        return new GetDriverByTripDto(
                d.getId(),
                d.getAvatar(),
                d.getFullName()
        );
    }

}
