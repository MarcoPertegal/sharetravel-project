package com.salesianostriana.dam.sharetravelBackend.rating.exception;

import jakarta.persistence.EntityNotFoundException;

public class EmptyRatingListException  extends EntityNotFoundException {
    public EmptyRatingListException(String message) {
        super(message);
    }
}
