package com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh;

import com.salesianostriana.dam.sharetravelBackend.security.errorhandling.JwtTokenException;

public class RefreshTokenException extends JwtTokenException {
    public RefreshTokenException(String msg) {
        super((msg));
    }
}
