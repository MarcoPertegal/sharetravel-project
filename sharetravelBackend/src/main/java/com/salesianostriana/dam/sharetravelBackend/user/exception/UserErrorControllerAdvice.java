package com.salesianostriana.dam.sharetravelBackend.user.exception;

import com.salesianostriana.dam.sharetravelBackend.exception.ExceptionMessage;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class UserErrorControllerAdvice {

    @ExceptionHandler({UserNotFoundException.class})
    public ResponseEntity<?> handleUserNotFoundException(UserNotFoundException ex, HttpServletRequest request){
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(ExceptionMessage.of(HttpStatus.NOT_FOUND, ex.getMessage(), request.getRequestURI()));
    }

    @ExceptionHandler({UserNotAllowedException.class, UserCantBeDeleteException.class})
    public ResponseEntity<?> handleUserNotAllowedException(Exception ex, HttpServletRequest request){
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(ExceptionMessage.of(HttpStatus.FORBIDDEN, ex.getMessage(), request.getRequestURI()));
    }
    @ExceptionHandler({UsernameAlreadyExistsException.class})
    public ResponseEntity<?> handleUserBadRequestException(Exception ex, HttpServletRequest request){
        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(ExceptionMessage.of(HttpStatus.BAD_REQUEST, ex.getMessage(), request.getRequestURI()));
    }
}
