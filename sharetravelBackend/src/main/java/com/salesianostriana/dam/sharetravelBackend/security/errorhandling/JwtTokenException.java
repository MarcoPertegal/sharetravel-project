package com.salesianostriana.dam.sharetravelBackend.security.errorhandling;

public class JwtTokenException extends RuntimeException{
    public JwtTokenException(String msg) {
        super(msg);
    }
}
