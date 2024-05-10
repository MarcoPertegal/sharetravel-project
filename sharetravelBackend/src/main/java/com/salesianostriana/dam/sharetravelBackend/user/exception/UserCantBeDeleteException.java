package com.salesianostriana.dam.sharetravelBackend.user.exception;

public class UserCantBeDeleteException extends RuntimeException{

    public UserCantBeDeleteException(String message) {
        super(message);
    }
}
