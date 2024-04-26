package com.salesianostriana.dam.sharetravelBackend.rating.exception;

import jakarta.persistence.EntityNotFoundException;

public class RatingNotFoundException extends EntityNotFoundException {
    public RatingNotFoundException(String message) {
        super(message);
    }
}
