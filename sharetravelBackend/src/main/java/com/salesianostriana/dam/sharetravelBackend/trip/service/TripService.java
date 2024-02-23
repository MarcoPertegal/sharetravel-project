package com.salesianostriana.dam.sharetravelBackend.trip.service;

import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDto;
import com.salesianostriana.dam.sharetravelBackend.trip.exception.EmptyTripListException;
import com.salesianostriana.dam.sharetravelBackend.trip.repository.TripRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class TripService {

    private final TripRepository tripRepository;

    public Page<GetTripDto> getAllTrips(Pageable p){
        Page<GetTripDto> result = tripRepository.findAllTrips(p);
        if(result.isEmpty()){
            throw new EmptyTripListException("no trips has been found");
        }
        return result;

    }

    public Page<GetTripDto> getTripsByDeparturePlaceArrivalPlaceAndDepartureTime(Pageable p, String departurePlace, String arrivalPlace, LocalDateTime departureTime){
        Page<GetTripDto> result = tripRepository.filterTripsByDeparturePlaceArrivalPlaceAndDepartureTime(p, departurePlace, arrivalPlace, departureTime);
        if (result.isEmpty()){
            throw new EmptyTripListException("no trips match your credentials");
        }
        return result;
    }

}
