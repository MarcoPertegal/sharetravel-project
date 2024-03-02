package com.salesianostriana.dam.sharetravelBackend.trip.exception;

import com.salesianostriana.dam.sharetravelBackend.exception.ExceptionMessage;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class TripErrorControllerAdvice {

    @ExceptionHandler({EmptyTripListException.class})
    public ResponseEntity<?> handleSpecieNotFoundException(EmptyTripListException ex, HttpServletRequest request){
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(ExceptionMessage.of(HttpStatus.NOT_FOUND, ex.getMessage(), request.getRequestURI()));
    }
}
