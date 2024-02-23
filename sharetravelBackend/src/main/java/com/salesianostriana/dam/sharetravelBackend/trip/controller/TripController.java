package com.salesianostriana.dam.sharetravelBackend.trip.controller;

import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDto;
import com.salesianostriana.dam.sharetravelBackend.trip.service.TripService;
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
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

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
                            array = @ArraySchema(schema = @Schema(implementation = GetTripDto.class)),
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
    public ResponseEntity<Page<GetTripDto>> getAllTrips(@PageableDefault(page = 0, size = 8)Pageable p){
        return ResponseEntity.ok(tripService.getAllTrips(p));
        //FALTARIA EN EL EXAMPLE RESPONSE DE DOCUMENTACION AÑADIR AL DRIVER CUANDO HAGA LAS ASOCIACIONES
    }


    @Operation(summary = "Get filter trips")
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
                    description = "no trips match your credentials",
                    content = @Content),
    })
    @GetMapping("/filter")
    public ResponseEntity<Page<GetTripDto>> findTripsByDeparturePlaceArrivalPlaceAndDepartureTime(@PageableDefault(page = 0, size = 8)Pageable p, @PathVariable String departurePlace,@PathVariable String arrivalPlace,@PathVariable LocalDateTime departureTime){
        return ResponseEntity.ok(tripService.getTripsByDeparturePlaceArrivalPlaceAndDepartureTime(p, departurePlace, arrivalPlace, departureTime));
        //FALTARIA EN EL EXAMPLE RESPONSE DE DOCUMENTACION AÑADIR AL DRIVER CUANDO HAGA LAS ASOCIACIONES
    }
}
