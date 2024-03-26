package com.salesianostriana.dam.sharetravelBackend.rating.controller;

import com.salesianostriana.dam.sharetravelBackend.rating.dto.CreateRatingDto;
import com.salesianostriana.dam.sharetravelBackend.rating.service.RatingService;
import com.salesianostriana.dam.sharetravelBackend.reserve.dto.CreateReserveDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.dto.NewReserveDto;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/rating")
public class RatingController {

    private final RatingService ratingService;
    /*
    @Operation(summary = "Create new rating")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Rating has been created",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = CreateRatingDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "403",
                    description = "A access denied, driver cannot create a rating",
                    content = @Content)
    })
    @PostMapping("/")
    public ResponseEntity<CreateRatingDto> createReserve (@AuthenticationPrincipal User loggedPassenger, @RequestBody NewReserveDto newReserveDto){
        return ResponseEntity.status(HttpStatus.CREATED).body(ratingService.createReserve(loggedPassenger.getId(), newReserveDto.tripId()));
    }*/
}
