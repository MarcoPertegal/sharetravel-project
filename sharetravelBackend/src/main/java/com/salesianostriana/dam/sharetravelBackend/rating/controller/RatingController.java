package com.salesianostriana.dam.sharetravelBackend.rating.controller;

import com.salesianostriana.dam.sharetravelBackend.rating.dto.CreateRatingDto;
import com.salesianostriana.dam.sharetravelBackend.rating.dto.GetRatingDto;
import com.salesianostriana.dam.sharetravelBackend.rating.dto.NewRatingDto;
import com.salesianostriana.dam.sharetravelBackend.rating.service.RatingService;
import com.salesianostriana.dam.sharetravelBackend.reserve.dto.NewReserveDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetAllTripsDto;
import com.salesianostriana.dam.sharetravelBackend.user.model.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/rating")
public class RatingController {

    private final RatingService ratingService;

    @Operation(summary = "Get all ratings")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Ratings have been found",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetRatingDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "content": [
                                                    {
                                                        "id": "d42504ee-dc7f-4025-beff-6ec4af0f567d",
                                                        "ratingDate": "2024-05-01T22:22:00",
                                                        "ratingValue": 4.6,
                                                        "feedback": "An enjoyable and pleasant trip, I recommend it"
                                                    },
                                                    {
                                                        "id": "846fb48c-fe49-4e53-bb5a-50cf08691bfc",
                                                        "ratingDate": "2024-06-01T14:00:00",
                                                        "ratingValue": 5.0,
                                                        "feedback": "A very comfortable and enjoyable trip"
                                                    },
                                                    {
                                                        "id": "8007b140-753e-40a9-8912-877e36058e99",
                                                        "ratingDate": "2024-07-01T16:00:00",
                                                        "ratingValue": 3.8,
                                                        "feedback": "Good driving skills"
                                                    }
                                                ],
                                                "pageable": {
                                                    "pageNumber": 0,
                                                    "pageSize": 8,
                                                    "sort": {
                                                        "empty": true,
                                                        "sorted": false,
                                                        "unsorted": true
                                                    },
                                                    "offset": 0,
                                                    "unpaged": false,
                                                    "paged": true
                                                },
                                                "last": true,
                                                "totalPages": 1,
                                                "totalElements": 3,
                                                "size": 8,
                                                "number": 0,
                                                "sort": {
                                                    "empty": true,
                                                    "sorted": false,
                                                    "unsorted": true
                                                },
                                                "first": true,
                                                "numberOfElements": 3,
                                                "empty": false
                                            }
                                            
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "no ratings has been found",
                    content = @Content),
    })
    @GetMapping("/")
    public ResponseEntity<Page<GetRatingDto>> getAllRatings(@PageableDefault(page = 0, size = 8) Pageable p){
        return ResponseEntity.ok(ratingService.getAllRatings(p));
    }

    @Operation(summary = "Create new rating")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Rating has been created",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = CreateRatingDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               {
                                                   "id": "7b41624a-a07d-4bc1-b348-ba65f9649181",
                                                   "ratingDate": "2024-03-26T18:14:19.426655",
                                                   "ratingValue": 3.0,
                                                   "feedback": "very good driver",
                                                   "driver": {
                                                       "id": "09fe7587-487a-49ba-8188-ec1a9ddc7b3f",
                                                       "avatar": "https://previews.123rf.com/images/rawpixel/rawpixel1704/rawpixel170441704/76561515-retrato-de-personas-estudio-disparar-con-expresi%C3%B3n-de-cara-sonriente.jpg",
                                                       "fullName": "Marco Pertegal Prieto"
                                                   },
                                                   "passenger": {
                                                       "avatar": "https://f.rpp-noticias.io/2019/02/15/753300descarga-11jpg.jpg",
                                                       "fullName": "Fran Ruíz Prieto"
                                                   }
                                               }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "409",
                    description = "You have already rated this driver",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "A access denied, driver cannot create a rating",
                    content = @Content)
    })
    @PostMapping("/new")
    public ResponseEntity<CreateRatingDto> createRating (@AuthenticationPrincipal User loggedPassenger, @RequestBody NewRatingDto newRatingDto){
        return ResponseEntity.status(HttpStatus.CREATED).body(ratingService.createRating(loggedPassenger.getId(), newRatingDto));
    }
}
