package com.salesianostriana.dam.sharetravelBackend.trip.exception;

import jakarta.persistence.EntityNotFoundException;

public class TripNotFoundException extends EntityNotFoundException {

    public TripNotFoundException(String message) {
        super(message);
    }
}
