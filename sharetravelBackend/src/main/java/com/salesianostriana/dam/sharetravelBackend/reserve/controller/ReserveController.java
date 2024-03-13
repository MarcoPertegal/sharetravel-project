package com.salesianostriana.dam.sharetravelBackend.reserve.controller;

import com.salesianostriana.dam.sharetravelBackend.reserve.dto.CreateReserveDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.dto.NewReserveDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.service.ReserveService;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDetailsDto;
import com.salesianostriana.dam.sharetravelBackend.user.model.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
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

    @Operation(summary = "Create new reserve")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Reserve has been created",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = CreateReserveDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "ef972080-8bba-4d70-ac16-398e2b7b1913",
                                                    "reserveDate": "2024-03-12T01:04:53.1263959",
                                                    "passengerId": "74304312-5bd7-4973-a272-69596b557f65",
                                                    "tripId": "6f9458e8-7834-4df8-ba48-79aadfaa42d4"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "409",
                    description = "A passenger cannot reserve the same trip twice",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "A access denied, driver cannot create a reserve",
                    content = @Content)
    })
    @PostMapping("/new")
    public ResponseEntity<CreateReserveDto> createReserve (@AuthenticationPrincipal User loggedPassenger, @RequestBody NewReserveDto newReserveDto){
        return ResponseEntity.status(HttpStatus.CREATED).body(reserveService.createReserve(loggedPassenger.getId(), newReserveDto.tripId()));
    }
}
