package com.salesianostriana.dam.sharetravelBackend.reserve.service;

import com.salesianostriana.dam.sharetravelBackend.reserve.dto.CreateReserveDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.dto.GetReserveByPassengerIdDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.exception.DuplicateReserveException;
import com.salesianostriana.dam.sharetravelBackend.reserve.exception.ReserveNotFoundException;
import com.salesianostriana.dam.sharetravelBackend.reserve.model.Reserve;
import com.salesianostriana.dam.sharetravelBackend.reserve.repository.ReserveRepository;
import com.salesianostriana.dam.sharetravelBackend.trip.exception.TripNotFoundException;
import com.salesianostriana.dam.sharetravelBackend.trip.model.Trip;
import com.salesianostriana.dam.sharetravelBackend.trip.repository.TripRepository;
import com.salesianostriana.dam.sharetravelBackend.user.exception.UserNotFoundException;
import com.salesianostriana.dam.sharetravelBackend.user.model.Passenger;
import com.salesianostriana.dam.sharetravelBackend.user.model.User;
import com.salesianostriana.dam.sharetravelBackend.user.repository.PassengerRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ReserveService {

    private final ReserveRepository reserveRepository;
    private final PassengerRepository passengerRepository;
    private final TripRepository tripRepository;

    public CreateReserveDto createReserve (UUID passengerId, UUID tripId){
        Optional<Passenger> optionalPassenger = passengerRepository.findById(passengerId);
        Passenger passenger = optionalPassenger.orElseThrow(() -> new UserNotFoundException("no user match this id"+ passengerId));

        Optional<Trip> optionalTrip = tripRepository.findById(tripId);
        Trip trip = optionalTrip.orElseThrow(() -> new TripNotFoundException("no trip match this id"+ tripId));

        boolean hasReserved = reserveRepository.existsByPassengerAndTrip(passenger, trip);
        if (hasReserved) {
            throw new DuplicateReserveException("A passenger cannot reserve the same trip twice.");
        }

        Reserve newReserve = Reserve.builder()
                .reserveDate(LocalDateTime.now())
                .passenger(passenger)
                .trip(trip)
                .build();
        Reserve savedReserve = reserveRepository.save(newReserve);

        return CreateReserveDto.builder()
                .id(savedReserve.getId())
                .reserveDate(savedReserve.getReserveDate())
                .passengerId(savedReserve.getPassenger().getId())
                .tripId(savedReserve.getTrip().getId())
                .build();
    }

    public Page<GetReserveByPassengerIdDto> getReservesByPassengerId(Pageable p, User user){
        Page<GetReserveByPassengerIdDto> result = reserveRepository.findReservesWithTripByPassengerId(user.getId(), p);
        if (result.isEmpty()){
            throw new ReserveNotFoundException("This passenger doesnt have any reserves");
        }
        return result;
    }
}