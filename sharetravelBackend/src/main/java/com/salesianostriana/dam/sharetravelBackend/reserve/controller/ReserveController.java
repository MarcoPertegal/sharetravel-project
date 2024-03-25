package com.salesianostriana.dam.sharetravelBackend.reserve.controller;

import com.salesianostriana.dam.sharetravelBackend.reserve.dto.CreateReserveDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.dto.GetReserveByPassengerIdDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.dto.NewReserveDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.service.ReserveService;
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

import java.util.UUID;

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


    @Operation(summary = "Get reserves by passenger id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Reserves has been found",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetReserveByPassengerIdDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               {
                                                     "content": [
                                                         {
                                                             "id": "100a570a-3b5f-4b51-ace0-44c8dd7580db",
                                                             "reserveDate": "2024-04-29T17:15:00",
                                                             "trip": {
                                                                 "id": "5d9458e8-7834-4df8-ba48-79aadfaa42d3",
                                                                 "departurePlace": "Seville",
                                                                 "arrivalPlace": "Sanlúcar de Barrameda",
                                                                 "departureTime": "2024-05-01T10:00:00",
                                                                 "estimatedDuration": 120,
                                                                 "arrivalTime": "2024-05-01T12:00:00",
                                                                 "price": 7.0,
                                                                 "tripDescription": "I have space for three passengers, no flexibility in the arrival place, and hand luggage only",
                                                                 "driver": {
                                                                     "avatar": "https://previews.123rf.com/images/rawpixel/rawpixel1704/rawpixel170441704/76561515-retrato-de-personas-estudio-disparar-con-expresi%C3%B3n-de-cara-sonriente.jpg",
                                                                     "fullName": "Marco Pertegal Prieto"
                                                                 }
                                                             }
                                                         },
                                                         {
                                                             "id": "9fedff98-d9f4-46b7-809c-cce716ed6699",
                                                             "reserveDate": "2024-05-01T17:19:00",
                                                             "trip": {
                                                                 "id": "6f9458e8-7834-4df8-ba48-79aadfaa42d4",
                                                                 "departurePlace": "Seville",
                                                                 "arrivalPlace": "Sanlúcar de Barrameda",
                                                                 "departureTime": "2024-05-01T17:15:00",
                                                                 "estimatedDuration": 110,
                                                                 "arrivalTime": "2024-05-01T18:30:00",
                                                                 "price": 8.0,
                                                                 "tripDescription": "I can drop off in nearby places in Sanlúcar, two passengers with hand luggage only",
                                                                 "driver": {
                                                                     "avatar": "https://www.redaccionmedica.com/images/destacados/las-personas-con-un-riesgo-genetico-bajo-de-tdah-son-mas-afortunadas--2868.jpg",
                                                                     "fullName": "Miguel Campos González"
                                                                 }
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
                                                     "totalPages": 1,
                                                     "totalElements": 2,
                                                     "last": true,
                                                     "size": 8,
                                                     "number": 0,
                                                     "sort": {
                                                         "empty": true,
                                                         "sorted": false,
                                                         "unsorted": true
                                                     },
                                                     "numberOfElements": 2,
                                                     "first": true,
                                                     "empty": false
                                                 }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "No reserves have been found",
                    content = @Content)
    })
    @GetMapping("/passenger")
    public ResponseEntity<Page<GetReserveByPassengerIdDto>> findReserveByPassengerId(@PageableDefault(page = 0, size = 8) Pageable p, @AuthenticationPrincipal User user){
        return ResponseEntity.ok(reserveService.getReservesByPassengerId(p, user));
    }

    @Operation(summary = "Delete reserve by id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Reserve delete successfully",
                    content = @Content
            ),
            @ApiResponse(
                    responseCode = "404",
                    description = "Reserve not found",
                    content = @Content
            ),
            @ApiResponse(
                    responseCode = "403",
                    description = "Driver cant delete reserves",
                    content = @Content
            )
    })
    @CrossOrigin
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteReserve(@PathVariable String id){
        reserveService.deleteByReserveId(UUID.fromString(id));
        return ResponseEntity.noContent().build();
    }
}
