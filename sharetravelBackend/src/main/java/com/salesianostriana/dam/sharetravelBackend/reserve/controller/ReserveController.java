package com.salesianostriana.dam.sharetravelBackend.reserve.controller;

import com.salesianostriana.dam.sharetravelBackend.reserve.dto.CreateReserveDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.dto.NewReserveDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.service.ReserveService;
import com.salesianostriana.dam.sharetravelBackend.user.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/reserve")
public class ReserveController {

    private final ReserveService reserveService;

    @PostMapping("/new")
    public ResponseEntity<CreateReserveDto> createReserve (@AuthenticationPrincipal User loggedPassenger, @RequestBody NewReserveDto newReserveDto){
        return ResponseEntity.status(HttpStatus.CREATED).body(reserveService.createReserve(loggedPassenger.getId(), newReserveDto.tripId()));
    }
}
