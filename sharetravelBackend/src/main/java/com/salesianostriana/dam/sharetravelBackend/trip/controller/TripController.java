package com.salesianostriana.dam.sharetravelBackend.trip.controller;

import com.salesianostriana.dam.sharetravelBackend.trip.service.TripService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class TripController {
    private final TripService tripService;

    /*
      @Operation(summary = "Get all patients")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Patients have been found",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = PatientDetailsDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "content": [
                                                    {
                                                                 "id": "6d31c447-aab3-4bcb-883c-7ee0ecea9151",
                                                                 "name": "manolo",
                                                                 "lastName": "manoles",
                                                                 "birthDate": "1990-10-12",
                                                                 "dni": "123456789",
                                                                 "email": "manolo@gamil.com",
                                                                 "phoneNumber": 123456789,
                                                                 "fotoUrl": "foto.url"
                                                             },
                                                             {
                                                                 "id": "66690825-6145-470c-b5a8-18bf386f1ceb",
                                                                 "name": "a",
                                                                 "lastName": "manoles",
                                                                 "birthDate": "2004-10-12",
                                                                 "dni": "123456789",
                                                                 "email": "a@gamil.com",
                                                                 "phoneNumber": 123456789,
                                                                 "fotoUrl": "foto.url"
                                                             },
                                                ],
                                                "pageable": {
                                                    "pageNumber": 1,
                                                    "pageSize": 4,
                                                    "sort": {
                                                        "empty": true,
                                                        "sorted": false,
                                                        "unsorted": true
                                                    },
                                                    "offset": 4,
                                                    "paged": true,
                                                    "unpaged": false
                                                },
                                                "last": true,
                                                "totalElements": 8,
                                                "totalPages": 2,
                                                "size": 4,
                                                "number": 1,
                                                "sort": {
                                                    "empty": true,
                                                    "sorted": false,
                                                    "unsorted": true
                                                },
                                                "first": false,
                                                "numberOfElements": 4,
                                                "empty": false
                                            }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "no patient has been found",
                    content = @Content),
    })
    @GetMapping("/sanitary/patient")
    public ResponseEntity<Page<PatientDetailsDto>> getAllPatients(@PageableDefault(page = 0, size = 8) Pageable pageable) {
        Page<PatientDetailsDto> pagedResult = sanitaryService.findAllPatients(pageable);

        if (pagedResult.isEmpty())
            return ResponseEntity.notFound().build();

        return ResponseEntity.ok(pagedResult);
    }
     */
}
