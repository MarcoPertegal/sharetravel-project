package com.salesianostriana.dam.sharetravelBackend.reserve.service;

import com.salesianostriana.dam.sharetravelBackend.reserve.dto.CreateReserveDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.model.Reserve;
import com.salesianostriana.dam.sharetravelBackend.reserve.repository.ReserveRepository;
import com.salesianostriana.dam.sharetravelBackend.trip.exception.EmptyTripListException;
import com.salesianostriana.dam.sharetravelBackend.trip.exception.TripNotFoundException;
import com.salesianostriana.dam.sharetravelBackend.trip.model.Trip;
import com.salesianostriana.dam.sharetravelBackend.trip.repository.TripRepository;
import com.salesianostriana.dam.sharetravelBackend.user.exception.UserNotFoundException;
import com.salesianostriana.dam.sharetravelBackend.user.model.Passenger;
import com.salesianostriana.dam.sharetravelBackend.user.repository.PassengerRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class RepositoryService {

    private final ReserveRepository reserveRepository;
    private final PassengerRepository passengerRepository;
    private final TripRepository tripRepository;

    public CreateReserveDto createReserve (String passagerId, String tripId){
        Optional<Passenger> optionalPassenger = passengerRepository.findById(UUID.fromString(passagerId));
        Passenger passenger = optionalPassenger.orElseThrow(() -> new UserNotFoundException("no user match this id"+ passagerId));

        Optional<Trip> optionalTrip = tripRepository.findById(UUID.fromString(tripId));
        Trip trip = optionalTrip.orElseThrow(() -> new TripNotFoundException("no trip match this id"+ tripId));

        Reserve newReserve = Reserve.builder()
                .reserveDate(LocalDateTime.now())
                .passenger(passenger)
                .trip(trip)
                .build();

        Reserve savedReserve = reserveRepository.save(newReserve);

        return CreateReserveDto.builder()
                .reserveDate(savedReserve.getReserveDate())
                .passenger(savedReserve.getPassenger())
                .trip(savedReserve.getTrip())
                .build();
    }
}
