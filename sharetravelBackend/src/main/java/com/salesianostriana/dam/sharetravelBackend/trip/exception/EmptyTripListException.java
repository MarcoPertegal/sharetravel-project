package com.salesianostriana.dam.sharetravelBackend.trip.exception;

import jakarta.persistence.EntityNotFoundException;

public class EmptyTripListException extends EntityNotFoundException {

    public EmptyTripListException(Exception cause) {
        super(cause);
    }

    public EmptyTripListException(String message) {
        super(message);
    }

    public EmptyTripListException(String message, Exception cause) {
        super(message, cause);
    }

}
