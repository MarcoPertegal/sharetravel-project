package com.salesianostriana.dam.sharetravelBackend.trip.service;

import com.salesianostriana.dam.sharetravelBackend.reserve.dto.GetReserveByTripDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.CreateTripDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetAllTripsDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDetailsDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDto;
import com.salesianostriana.dam.sharetravelBackend.trip.exception.EmptyTripListException;
import com.salesianostriana.dam.sharetravelBackend.trip.model.Trip;
import com.salesianostriana.dam.sharetravelBackend.trip.repository.TripRepository;
import com.salesianostriana.dam.sharetravelBackend.user.dto.GetDriverByTripDto;
import com.salesianostriana.dam.sharetravelBackend.user.exception.UserNotFoundException;
import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;
import com.salesianostriana.dam.sharetravelBackend.user.repository.DriverRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TripService {

    private final TripRepository tripRepository;
    private final DriverRepository driverRepository;

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


    public GetTripDetailsDto createtrip (UUID driverId, CreateTripDto createTripDto){

        Optional<Driver> optionalDriver = driverRepository.findById(driverId);
        Driver driver = optionalDriver.orElseThrow(() -> new UserNotFoundException("no driver match this id"+ driverId));
        //demomento no seteo ninguna reserva porque el viaje es nuevo comprobar si se le pueden
        //hacer reservas a este viaje
        Trip newTrip = Trip.builder()
                .departurePlace(createTripDto.departurePlace())
                .arrivalPlace(createTripDto.arrivalPlace())
                .departureTime(createTripDto.departureTime())
                .estimatedDuration(createTripDto.estimatedDuration())
                .price(createTripDto.price())
                .tripDescription(createTripDto.tripDescription())
                .driver(driver)
                .build();
        newTrip.calculateArrivalTime();
        Trip savedTrip = tripRepository.save(newTrip);

        return GetTripDetailsDto.builder()
                .id(savedTrip.getId())
                .departurePlace(savedTrip.getDeparturePlace())
                .arrivalPlace(savedTrip.getArrivalPlace())
                .departureTime(savedTrip.getDepartureTime())
                .estimatedDuration(savedTrip.getEstimatedDuration())
                .arrivalTime(savedTrip.getArrivalTime())
                .price(savedTrip.getPrice())
                .tripDescription(savedTrip.getTripDescription())
                .driver(savedTrip.getDriver() != null
                        ? GetDriverByTripDto.of(savedTrip.getDriver())
                        : null)
                .build();
    }
}
