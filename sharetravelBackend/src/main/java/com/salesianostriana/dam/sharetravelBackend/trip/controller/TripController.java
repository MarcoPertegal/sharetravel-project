package com.salesianostriana.dam.sharetravelBackend.trip.controller;

import com.salesianostriana.dam.sharetravelBackend.trip.dto.*;
import com.salesianostriana.dam.sharetravelBackend.trip.service.TripService;
import com.salesianostriana.dam.sharetravelBackend.user.model.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/trip")
public class TripController {

    private final TripService tripService;

    @Operation(summary = "Get all trips")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Trips have been found",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetAllTripsDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                 "content": [
                                                     {
                                                         "id": "5d9458e8-7834-4df8-ba48-79aadfaa42d3",
                                                         "departurePlace": "Seville",
                                                         "arrivalPlace": "Sanlúcar de Barrameda",
                                                         "departureTime": "2024-02-22T10:00:00",
                                                         "estimatedDuration": 120,
                                                         "arrivalTime": "2024-02-22T12:00:00",
                                                         "price": 7.99
                                                     },
                                                     {
                                                         "id": "6f9458e8-7834-4df8-ba48-79aadfaa42d3",
                                                         "departurePlace": "Madrid",
                                                         "arrivalPlace": "Barcelona",
                                                         "departureTime": "2024-02-23T08:30:00",
                                                         "estimatedDuration": 180,
                                                         "arrivalTime": "2024-02-23T11:30:00",
                                                         "price": 15.5
                                                     },
                                                     {
                                                         "id": "7a9458e8-7834-4df8-ba48-79aadfaa42d3",
                                                         "departurePlace": "Valencia",
                                                         "arrivalPlace": "Alicante",
                                                         "departureTime": "2024-02-24T14:45:00",
                                                         "estimatedDuration": 90,
                                                         "arrivalTime": "2024-02-24T16:15:00",
                                                         "price": 9.99
                                                     },
                                                     {
                                                         "id": "8b9458e8-7834-4df8-ba48-79aadfaa42d3",
                                                         "departurePlace": "Barcelona",
                                                         "arrivalPlace": "Madrid",
                                                         "departureTime": "2024-02-25T11:00:00",
                                                         "estimatedDuration": 150,
                                                         "arrivalTime": "2024-02-25T13:30:00",
                                                         "price": 12.75
                                                     },
                                                     {
                                                         "id": "9a9458e8-7834-4df8-ba48-79aadfaa42d3",
                                                         "departurePlace": "Granada",
                                                         "arrivalPlace": "Málaga",
                                                         "departureTime": "2024-02-26T12:30:00",
                                                         "estimatedDuration": 120,
                                                         "arrivalTime": "2024-02-26T14:30:00",
                                                         "price": 12.75
                                                     },
                                                     {
                                                         "id": "ab9458e8-7834-4df8-ba48-79aadfaa42d3",
                                                         "departurePlace": "Seville",
                                                         "arrivalPlace": "Cordoba",
                                                         "departureTime": "2024-02-27T09:15:00",
                                                         "estimatedDuration": 60,
                                                         "arrivalTime": "2024-02-27T10:15:00",
                                                         "price": 5.99
                                                     },
                                                     {
                                                         "id": "bc9458e8-7834-4df8-ba48-79aadfaa42d3",
                                                         "departurePlace": "Valencia",
                                                         "arrivalPlace": "Barcelona",
                                                         "departureTime": "2024-02-28T16:30:00",
                                                         "estimatedDuration": 120,
                                                         "arrivalTime": "2024-02-28T18:30:00",
                                                         "price": 11.5
                                                     },
                                                     {
                                                         "id": "cd9458e8-7834-4df8-ba48-79aadfaa42d3",
                                                         "departurePlace": "Seville",
                                                         "arrivalPlace": "Granada",
                                                         "departureTime": "2024-03-01T14:00:00",
                                                         "estimatedDuration": 90,
                                                         "arrivalTime": "2024-03-01T15:30:00",
                                                         "price": 8.5
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
                                                     "paged": true,
                                                     "unpaged": false
                                                 },
                                                 "last": false,
                                                 "totalPages": 2,
                                                 "totalElements": 10,
                                                 "first": true,
                                                 "size": 8,
                                                 "number": 0,
                                                 "sort": {
                                                     "empty": true,
                                                     "sorted": false,
                                                     "unsorted": true
                                                 },
                                                 "numberOfElements": 8,
                                                 "empty": false
                                             }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "no trips has been found",
                    content = @Content),
    })
    @GetMapping("/")
    public ResponseEntity<Page<GetAllTripsDto>> getAllTrips(@PageableDefault(page = 0, size = 8)Pageable p){
        return ResponseEntity.ok(tripService.getAllTrips(p));
    }


    @Operation(summary = "Get filtered trips")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Trips matchers the credentials",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetTripDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                  "content": [
                                                          {
                                                              "id": "5d9458e8-7834-4df8-ba48-79aadfaa42d3",
                                                              "departurePlace": "Seville",
                                                              "arrivalPlace": "Sanlúcar de Barrameda",
                                                              "departureTime": "2024-05-01T10:00:00",
                                                              "estimatedDuration": 120,
                                                              "arrivalTime": "2024-05-01T12:00:00",
                                                              "price": 7.99,
                                                              "driver": {
                                                                  "avatar": null,
                                                                  "fullName": "Marco Pertegal Prieto"
                                                              }
                                                          },
                                                          {
                                                              "id": "6f9458e8-7834-4df8-ba48-79aadfaa42d4",
                                                              "departurePlace": "Seville",
                                                              "arrivalPlace": "Sanlúcar de Barrameda",
                                                              "departureTime": "2024-05-01T17:15:00",
                                                              "estimatedDuration": 120,
                                                              "arrivalTime": "2024-05-01T18:30:00",
                                                              "price": 8.5,
                                                              "driver": {
                                                                  "avatar": null,
                                                                  "fullName": "Miguel Campos González"
                                                              }
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
                                                      "paged": true,
                                                      "unpaged": false
                                                  },
                                                  "last": true,
                                                  "totalPages": 1,
                                                  "totalElements": 2,
                                                  "size": 8,
                                                  "number": 0,
                                                  "sort": {
                                                      "empty": true,
                                                      "sorted": false,
                                                      "unsorted": true
                                                  },
                                                  "first": true,
                                                  "numberOfElements": 2,
                                                  "empty": false
                                              }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "no trips match your credentials",
                    content = @Content),
    })
    @GetMapping("/filter")
    public ResponseEntity<Page<GetTripDto>> findTripsByDeparturePlaceArrivalPlaceAndDepartureTime(@PageableDefault(page = 0, size = 8)Pageable p, @RequestParam String departurePlace, @RequestParam String arrivalPlace, @RequestParam LocalDate departureDate){
        return ResponseEntity.ok(tripService.getTripsByDeparturePlaceArrivalPlaceAndDepartureTime(p, departurePlace, arrivalPlace, departureDate));
    }

    @Operation(summary = "Get trip by id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Trip has been found",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetTripDetailsDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "6f9458e8-7834-4df8-ba48-79aadfaa42d4",
                                                    "departurePlace": "Seville",
                                                    "arrivalPlace": "Sanlúcar de Barrameda",
                                                    "departureTime": "2024-05-01T17:15:00",
                                                    "estimatedDuration": 110,
                                                    "arrivalTime": "2024-05-01T18:30:00",
                                                    "price": 8.99,
                                                    "tripDescription": "I can drop off in nearby places in Sanlúcar, two passengers with hand luggage only",
                                                    "driver": {
                                                        "avatar": "https://www.redaccionmedica.com/images/destacados/las-personas-con-un-riesgo-genetico-bajo-de-tdah-son-mas-afortunadas--2868.jpg",
                                                        "fullName": "Miguel Campos González"
                                                    },
                                                    "reserves": [
                                                        {
                                                            "reserveDate": "2024-05-01T17:19:00",
                                                            "passenger": {
                                                                "avatar": "https://f.rpp-noticias.io/2019/02/15/753300descarga-11jpg.jpg",
                                                                "fullName": "Fran Ruíz Prieto"
                                                            }
                                                        },
                                                        {
                                                            "reserveDate": "2024-04-29T10:30:00",
                                                            "passenger": {
                                                                "avatar": "https://www.laguiadelvaron.com/wp-content/uploads/2018/12/ai-image-generation-fake-faces-people-nvidia-5c18b20b472c2__700.jpg",
                                                                "fullName": "Fernando Pérez Gil"
                                                            }
                                                        }
                                                    ]
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Trip hasn't been found",
                    content = @Content)
    })
    @GetMapping("/{id}")
    public ResponseEntity<GetTripDetailsDto> findTripById(@PathVariable String id){
        return ResponseEntity.ok(tripService.getTripById(UUID.fromString(id)));
    }

    @Operation(summary = "Create new trip")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Trip has been created",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = CreateTripDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "c300ae8e-777f-4c5d-af20-61a0e90e2026",
                                                    "departurePlace": "Cádiz",
                                                    "arrivalPlace": "Jeréz",
                                                    "departureTime": "2022-03-15T10:30:00",
                                                    "estimatedDuration": 10,
                                                    "arrivalTime": "2022-03-15T10:40:00",
                                                    "price": 8.99,
                                                    "tripDescription": "El coche es un Seat León Azul, tengo flexibilidad en el lugar de recogida",
                                                    "driver": {
                                                        "avatar": "https://previews.123rf.com/images/rawpixel/rawpixel1704/rawpixel170441704/76561515-retrato-de-personas-estudio-disparar-con-expresi%C3%B3n-de-cara-sonriente.jpg",
                                                        "fullName": "Marco Pertegal Prieto"
                                                    },
                                                    "reserves": null
                                                }
                                            """
                            )}
                    )})
    })
    @PostMapping("/new")
    public ResponseEntity<GetTripDetailsDto> createTrip (@AuthenticationPrincipal User loggedDriver, @Valid @RequestBody CreateTripDto createTripDto){
        return ResponseEntity.status(HttpStatus.CREATED).body(tripService.createtrip(loggedDriver.getId(), createTripDto));
    }

    @Operation(summary = "Get trips by driver id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Reserves has been found",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetTripDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "content": [
                                                    {
                                                        "id": "5d9458e8-7834-4df8-ba48-79aadfaa42d3",
                                                        "departurePlace": "Seville",
                                                        "arrivalPlace": "Sanlúcar de Barrameda",
                                                        "departureTime": "2024-05-01T10:00:00",
                                                        "estimatedDuration": 120,
                                                        "arrivalTime": "2024-05-01T12:00:00",
                                                        "price": 7.99,
                                                        "driver": {
                                                            "avatar": "https://previews.123rf.com/images/rawpixel/rawpixel1704/rawpixel170441704/76561515-retrato-de-personas-estudio-disparar-con-expresi%C3%B3n-de-cara-sonriente.jpg",
                                                            "fullName": "Marco Pertegal Prieto"
                                                        }
                                                    },
                                                    {
                                                        "id": "df9458e8-7834-4df8-ba48-79aadfaa42d6",
                                                        "departurePlace": "Seville",
                                                        "arrivalPlace": "Sanlúcar de Barrameda",
                                                        "departureTime": "2024-05-01T15:00:00",
                                                        "estimatedDuration": 90,
                                                        "arrivalTime": "2024-05-01T16:15:00",
                                                        "price": 5.99,
                                                        "driver": {
                                                            "avatar": "https://previews.123rf.com/images/rawpixel/rawpixel1704/rawpixel170441704/76561515-retrato-de-personas-estudio-disparar-con-expresi%C3%B3n-de-cara-sonriente.jpg",
                                                            "fullName": "Marco Pertegal Prieto"
                                                        }
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
                                                    "paged": true,
                                                    "unpaged": false
                                                },
                                                "last": true,
                                                "totalPages": 1,
                                                "totalElements": 2,
                                                "size": 8,
                                                "number": 0,
                                                "sort": {
                                                    "empty": true,
                                                    "sorted": false,
                                                    "unsorted": true
                                                },
                                                "first": true,
                                                "numberOfElements": 2,
                                                "empty": false
                                            }  
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "No trips have been found",
                    content = @Content)
    })
    @GetMapping("/driver")
    public ResponseEntity<Page<GetTripDto>> findTripByDriverId(@PageableDefault(page = 0, size = 8) Pageable p, @AuthenticationPrincipal User user){
        return ResponseEntity.ok(tripService.getTripsByDriverId(p, user));
    }


  @Operation(summary = "Edit trip by id")
    @ApiResponses(value = {
            @ApiResponse(responseCode ="201",
                    description = "Trips has been edited",
                    content = { @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = CreateTripDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": "6f9458e8-7834-4df8-ba48-79aadfaa42d4",
                                                "departurePlace": "Madrid",
                                                "arrivalPlace": "Barcelona",
                                                "departureTime": "2024-04-03T18:30:00",
                                                "estimatedDuration": 100,
                                                "arrivalTime": "2024-04-03T20:10:00",
                                                "price": 9.0,
                                                "tripDescription": "El coche es un Seat León Azul, tengo flexibilidad en el lugar de recogida",
                                                "driver": {
                                                    "avatar": "https://www.redaccionmedica.com/images/destacados/las-personas-con-un-riesgo-genetico-bajo-de-tdah-son-mas-afortunadas--2868.jpg",
                                                    "fullName": "Miguel Campos González"
                                                }
                                            }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Trip not found",
                    content = @Content),
    })
    @CrossOrigin
    @PutMapping("/{id}")
    public ResponseEntity<GetTripDto> editTrip(@AuthenticationPrincipal User user, @PathVariable String id, @Valid @RequestBody CreateTripDto createTripDto) {
        return ResponseEntity.status(HttpStatus.CREATED).body(tripService.editTrip(user,UUID.fromString(id), createTripDto));
    }

    @Operation(summary = "Delete trip by id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Trip delete successfully",
                    content = @Content
            ),
            @ApiResponse(
                    responseCode = "404",
                    description = "Trip not found",
                    content = @Content
            ),
            @ApiResponse(
                    responseCode = "403",
                    description = "Passenger cant delete trips",
                    content = @Content
            )
    })
    @CrossOrigin
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteTrip(@AuthenticationPrincipal User user,@PathVariable String id){
        tripService.deleteByTripId(user, UUID.fromString(id));
        return ResponseEntity.noContent().build();
    }


}
