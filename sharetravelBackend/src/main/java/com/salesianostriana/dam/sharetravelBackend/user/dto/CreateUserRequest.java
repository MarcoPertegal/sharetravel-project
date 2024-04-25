package com.salesianostriana.dam.sharetravelBackend.user.dto;

import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateUserRequest {

    @NotBlank(message = "Username cannot be empty")
    private String username;

    @NotBlank(message = "Password cannot be empty")
    //@Size(min = 8, message = "Password must be at least 8 characters long")
    private String password;

    //@NotBlank(message = "Confirm your password")
    //@Size(min = 8, message = "Password must be at least 8 characters long")
    private String verifyPassword;

    private String avatar;

    @NotBlank(message = "Name cannot be empty")
    private String fullName;

    @NotBlank(message = "Email cannot be empty")
    @Email(message = "Email format not valid")
    private String email;

    @NotBlank(message = "Phone number cannot be empty")
    @Digits(integer = 15, fraction = 0, message = "Phone number must contain only numeric characters")
    private String phoneNumber;

    @NotBlank(message = "Personal description cannot be empty")
    private String personalDescription;


}
