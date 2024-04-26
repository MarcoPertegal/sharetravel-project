package com.salesianostriana.dam.sharetravelBackend.rating.exception;

import com.salesianostriana.dam.sharetravelBackend.exception.ExceptionMessage;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class RatingErrorControllerAdvice {
    @ExceptionHandler({EmptyRatingListException.class, RatingNotFoundException.class})
    public ResponseEntity<?> handleRatingNotFoundExceptions(Exception ex, HttpServletRequest request){
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(ExceptionMessage.of(HttpStatus.NOT_FOUND, ex.getMessage(), request.getRequestURI()));
    }

    @ExceptionHandler({DuplicateRatingException.class})
    public ResponseEntity<?> handleDuplicateRatingException(Exception ex, HttpServletRequest request){
        return ResponseEntity.status(HttpStatus.CONFLICT)
                .body(ExceptionMessage.of(HttpStatus.CONFLICT, ex.getMessage(), request.getRequestURI()));
    }
}
