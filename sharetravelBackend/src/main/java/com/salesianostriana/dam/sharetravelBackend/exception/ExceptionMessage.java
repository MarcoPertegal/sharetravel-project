package com.salesianostriana.dam.sharetravelBackend.exception;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

import java.time.LocalDateTime;

@Builder
@AllArgsConstructor
@Getter
@Setter
public class ExceptionMessage {
    private HttpStatus status;
    private String message, path;

    @Builder.Default
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy HH:mm:ss")
    private LocalDateTime dateTime = LocalDateTime.now();

    public static ExceptionMessage of (HttpStatus status, String message, String path) {
        return ExceptionMessage.builder()
                .status(status)
                .message(message)
                .path(path)
                .build();
    }
}
