package com.salesianostriana.dam.sharetravelBackend.user.dto;

import lombok.Builder;

import java.time.LocalDateTime;
import java.util.UUID;
@Builder
public record UserDataDto(
        UUID id,
        String avatar,
        String username,
        String fullName,
        String email,
        String phoneNumber,
        String personalDescription,
        String roles,
        LocalDateTime createdAt
) {
}
