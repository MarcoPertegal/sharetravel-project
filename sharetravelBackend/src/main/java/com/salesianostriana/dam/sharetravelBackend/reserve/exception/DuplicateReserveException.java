package com.salesianostriana.dam.sharetravelBackend.reserve.exception;

import jakarta.persistence.EntityNotFoundException;

public class DuplicateReserveException extends EntityNotFoundException {

    public DuplicateReserveException(String message) {
        super(message);
    }
}
