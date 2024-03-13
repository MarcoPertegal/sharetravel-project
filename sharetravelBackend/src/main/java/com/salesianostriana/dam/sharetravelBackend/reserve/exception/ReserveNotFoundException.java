package com.salesianostriana.dam.sharetravelBackend.reserve.exception;

import jakarta.persistence.EntityNotFoundException;

public class ReserveNotFoundException extends EntityNotFoundException {

    public ReserveNotFoundException(String message) {
        super(message);
    }
}
