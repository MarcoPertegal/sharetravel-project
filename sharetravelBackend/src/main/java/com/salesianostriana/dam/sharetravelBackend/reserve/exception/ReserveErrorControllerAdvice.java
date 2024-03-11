package com.salesianostriana.dam.sharetravelBackend.reserve.exception;

import com.salesianostriana.dam.sharetravelBackend.exception.ExceptionMessage;
import com.salesianostriana.dam.sharetravelBackend.trip.exception.EmptyTripListException;
import com.salesianostriana.dam.sharetravelBackend.trip.exception.TripNotFoundException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ReserveErrorControllerAdvice {

    @ExceptionHandler({DuplicateReserveException.class})
    public ResponseEntity<?> handleReserveExceptions(Exception ex, HttpServletRequest request){
        return ResponseEntity.status(HttpStatus.CONFLICT)
                .body(ExceptionMessage.of(HttpStatus.CONFLICT, ex.getMessage(), request.getRequestURI()));
    }
}
