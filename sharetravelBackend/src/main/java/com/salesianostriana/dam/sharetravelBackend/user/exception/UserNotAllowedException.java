package com.salesianostriana.dam.sharetravelBackend.user.exception;


public class UserNotAllowedException extends RuntimeException {
    public UserNotAllowedException(String message) {
        super(message);
    }
}
