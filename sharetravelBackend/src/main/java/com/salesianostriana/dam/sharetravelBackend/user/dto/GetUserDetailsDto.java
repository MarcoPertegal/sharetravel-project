package com.salesianostriana.dam.sharetravelBackend.user.dto;

import lombok.Builder;


@Builder
public record GetUserDetailsDto(
        String id,
        String email,
        String phoneNumber,
        String personalDescription,
        String avatar,
        String fullName,
        String averageRating
) {

}
