package com.salesianostriana.dam.sharetravelBackend.reserve.service;

import com.salesianostriana.dam.sharetravelBackend.rating.exception.EmptyRatingListException;
import com.salesianostriana.dam.sharetravelBackend.reserve.dto.CreateReserveDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.dto.GetReserveByPassengerIdDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.dto.GetReserveWithPassengerAndTripDto;
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
import org.springframework.beans.factory.annotation.Value;
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

    @Value("${passenger.not.found}")
    private String passengerNotFoundMessage;
    @Value("${trip.not.match.id}")
    private String tripNotMatchIdMessage;
    @Value("${duplicate.reserve}")
    private String duplicateReserveMessage;
    @Value("${no.reserve.trip}")
    private String noReserveTripMessage;
    @Value("${reserve.not.match.id}")
    private String reserveNotMatchIdMessage;
    @Value("${reserve.not.found}")
    private String reserveNotFoundMessage;

    public CreateReserveDto createReserve (UUID passengerId, UUID tripId){
        Optional<Passenger> optionalPassenger = passengerRepository.findById(passengerId);
        Passenger passenger = optionalPassenger.orElseThrow(() -> new UserNotFoundException(passengerNotFoundMessage));

        Optional<Trip> optionalTrip = tripRepository.findById(tripId);
        Trip trip = optionalTrip.orElseThrow(() -> new TripNotFoundException(tripNotMatchIdMessage));

        boolean hasReserved = reserveRepository.existsByPassengerAndTrip(passenger, trip);
        if (hasReserved) {
            throw new DuplicateReserveException(duplicateReserveMessage);
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
            throw new ReserveNotFoundException(noReserveTripMessage);
        }
        return result;
    }

    public void deleteByReserveId (UUID id) {
        if (!reserveRepository.existsById(id)){
            throw new ReserveNotFoundException(reserveNotMatchIdMessage);
        }
        reserveRepository.deleteById(id);
    }

    public Page<GetReserveWithPassengerAndTripDto> getAllReserves(Pageable p){
        Page<GetReserveWithPassengerAndTripDto> result = reserveRepository.findAllReserves(p);
        if(result.isEmpty()){
            throw new ReserveNotFoundException(reserveNotFoundMessage);
        }
        return result;
    }
}