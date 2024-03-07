package com.salesianostriana.dam.sharetravelBackend.trip.service;

import com.salesianostriana.dam.sharetravelBackend.reserve.dto.GetReserveByTripDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetAllTripsDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDetailsDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDto;
import com.salesianostriana.dam.sharetravelBackend.trip.exception.EmptyTripListException;
import com.salesianostriana.dam.sharetravelBackend.trip.model.Trip;
import com.salesianostriana.dam.sharetravelBackend.trip.repository.TripRepository;
import com.salesianostriana.dam.sharetravelBackend.user.dto.GetDriverByTripDto;
import com.salesianostriana.dam.sharetravelBackend.user.dto.GetPassengerByTripDto;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TripService {

    private final TripRepository tripRepository;

    public Page<GetAllTripsDto> getAllTrips(Pageable p){
        Page<GetAllTripsDto> result = tripRepository.findAllTrips(p);
        if(result.isEmpty()){
            throw new EmptyTripListException("no trips has been found");
        }
        return result;

    }

    public Page<GetTripDto> getTripsByDeparturePlaceArrivalPlaceAndDepartureTime(Pageable p, String departurePlace, String arrivalPlace, LocalDate departureDate){
        Page<GetTripDto> result = tripRepository.filterTripsByDeparturePlaceArrivalPlaceAndDepartureTime(p, departurePlace, arrivalPlace, departureDate);
        if (result.isEmpty()){
            throw new EmptyTripListException("no trips match your credentials");
        }
        return result;
    }

    public GetTripDetailsDto getTripById(UUID id) {
        Optional<Trip> result = tripRepository.findById(id);
        Trip trip = result.orElseThrow(() -> new EmptyTripListException("no trip match this id"));

        return GetTripDetailsDto.builder()
                .id(trip.getId())
                .departurePlace(trip.getDeparturePlace())
                .arrivalPlace(trip.getArrivalPlace())
                .departureTime(trip.getDepartureTime())
                .estimatedDuration(trip.getEstimatedDuration())
                .arrivalTime(trip.getArrivalTime())
                .price(trip.getPrice())
                .tripDescription(trip.getTripDescription())
                .driver(trip.getDriver() != null
                        ? GetDriverByTripDto.of(trip.getDriver())
                        : null)
                .reserves(trip.getReserves().stream()
                        .map(GetReserveByTripDto::of)
                        .collect(Collectors.toList()))
                .build();
    }


}
