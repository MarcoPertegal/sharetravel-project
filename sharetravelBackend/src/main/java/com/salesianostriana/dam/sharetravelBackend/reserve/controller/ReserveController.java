package com.salesianostriana.dam.sharetravelBackend.reserve.controller;

import com.salesianostriana.dam.sharetravelBackend.reserve.dto.CreateReserveDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.service.ReserveService;
import com.salesianostriana.dam.sharetravelBackend.user.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/reserve")
public class ReserveController {

    private final ReserveService reserveService;

    @PostMapping("/new/{tripId}")
    public ResponseEntity<CreateReserveDto> createReserve (@AuthenticationPrincipal User loggedPassenger, @PathVariable String tripId){
        return ResponseEntity.status(HttpStatus.CREATED).body(reserveService.createReserve(loggedPassenger.getId(), tripId));
    }
    //parece que peta el controller?
}
