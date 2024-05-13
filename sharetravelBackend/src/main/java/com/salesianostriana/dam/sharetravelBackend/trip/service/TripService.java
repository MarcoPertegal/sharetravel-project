package com.salesianostriana.dam.sharetravelBackend.trip.service;

import com.salesianostriana.dam.sharetravelBackend.reserve.dto.GetReserveByTripDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.model.Reserve;
import com.salesianostriana.dam.sharetravelBackend.reserve.repository.ReserveRepository;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.*;
import com.salesianostriana.dam.sharetravelBackend.trip.exception.EmptyTripListException;
import com.salesianostriana.dam.sharetravelBackend.trip.exception.TripNotFoundException;
import com.salesianostriana.dam.sharetravelBackend.trip.model.Trip;
import com.salesianostriana.dam.sharetravelBackend.trip.repository.TripRepository;
import com.salesianostriana.dam.sharetravelBackend.user.dto.GetDriverByTripDto;
import com.salesianostriana.dam.sharetravelBackend.user.exception.UserNotAllowedException;
import com.salesianostriana.dam.sharetravelBackend.user.exception.UserNotFoundException;
import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;
import com.salesianostriana.dam.sharetravelBackend.user.model.User;
import com.salesianostriana.dam.sharetravelBackend.user.repository.DriverRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TripService {

    private final TripRepository tripRepository;
    private final DriverRepository driverRepository;
    private final ReserveRepository reserveRepository;

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
    @Transactional
    public GetTripDetailsDto getTripById(UUID id) {
        Optional<Trip> optionalTrip = tripRepository.findByIdWithDriverAndReserves(id);
        Trip trip = optionalTrip.orElseThrow(() -> new TripNotFoundException("No trip matches this id: "+ id));

        return GetTripDetailsDto.builder()
                .id(trip.getId())
                .departurePlace(trip.getDeparturePlace())
                .arrivalPlace(trip.getArrivalPlace())
                .departureTime(trip.getDepartureTime())
                .estimatedDuration(trip.getEstimatedDuration())
                .arrivalTime(trip.getArrivalTime())
                .price(trip.getPrice())
                .tripDescription(trip.getTripDescription())
                .driver(trip.getDriver() != null ? GetDriverByTripDto.of(trip.getDriver()) : null)
                .reserves(trip.getReserves().stream()
                        .map(GetReserveByTripDto::of)
                        .collect(Collectors.toList()))
                .build();
    }


    public GetTripDetailsDto createtrip (UUID driverId, CreateTripDto createTripDto){

        Optional<Driver> optionalDriver = driverRepository.findById(driverId);
        Driver driver = optionalDriver.orElseThrow(() -> new UserNotFoundException("no driver match this id"+ driverId));

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

    public Page<GetTripDto> getTripsByDriverId(Pageable p, User user){
        Page<GetTripDto> result = tripRepository.findTripsByDriverId(user.getId(), p);
        if (result.isEmpty()){
            throw new EmptyTripListException("You have not publish any trip");
        }
        return result;
    }
    @Transactional
    public GetTripDto editTrip(User user, UUID id, CreateTripDto createTripDto){

        if (user.getRoles().toString().equals("[PASSENGER]")) {
            throw new UserNotAllowedException("A passenger cant edit trips");
        }

        LocalDateTime departureTimeString = createTripDto.departureTime();
        //verificar

        Optional<Trip> optionalTrip = tripRepository.findById(id);
        Trip editTrip = optionalTrip.orElseThrow(() -> new TripNotFoundException("no trip match this id"+ id));

        editTrip.setDeparturePlace(createTripDto.departurePlace());
        editTrip.setArrivalPlace(createTripDto.arrivalPlace());
        editTrip.setDepartureTime(createTripDto.departureTime());
        editTrip.setEstimatedDuration(createTripDto.estimatedDuration());
        editTrip.setPrice(createTripDto.price());
        editTrip.setTripDescription(createTripDto.tripDescription());
        editTrip.calculateArrivalTime();
        Trip savedTrip = tripRepository.save(editTrip);

        return GetTripDto.builder()
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


    @Transactional
    public void deleteByTripId (User user, UUID id){
        if (user.getRoles().toString().equals("[PASSENGER]")) {
            throw new UserNotAllowedException("A passenger cant delete trips");
        }
        Optional<Trip> optionalTrip = tripRepository.findById(id);
        Trip trip = optionalTrip.orElseThrow(() -> new TripNotFoundException("No trip found with that id"));

        List<Reserve> tripReserves = reserveRepository.findByTripId(id);

        //deleteAll? se supone que es más eficiente
        tripReserves.forEach(reserveRepository::delete);

        //si quito esta linea falla
        List<Reserve> tripReservesBorradas = reserveRepository.findByTripId(id);

        tripRepository.deleteById(trip.getId());
    }
}
