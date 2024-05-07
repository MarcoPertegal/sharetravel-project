package com.salesianostriana.dam.sharetravelBackend.user.dto;

import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Builder;

@Builder
public record EditUserDto (

        String avatar,

        @NotBlank(message = "Name cannot be empty")
        String fullName,

        @NotBlank(message = "Email cannot be empty")
        @Email(message = "Email format not valid")
        String email,

        @NotBlank(message = "Phone number cannot be empty")
        @Digits(integer = 15, fraction = 0, message = "Phone number must contain only numeric characters")
        @Size(max = 9, message = "The phone number cant contain more than 9 digits")
        String phoneNumber,

        @NotBlank(message = "Personal description cannot be empty")
        String personalDescription
){
}
