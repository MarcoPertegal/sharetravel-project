package com.salesianostriana.dam.sharetravelBackend.rating.service;

import com.salesianostriana.dam.sharetravelBackend.rating.dto.CreateRatingDto;
import com.salesianostriana.dam.sharetravelBackend.rating.dto.GetRatingByDriverIdDto;
import com.salesianostriana.dam.sharetravelBackend.rating.dto.GetRatingDto;
import com.salesianostriana.dam.sharetravelBackend.rating.dto.NewRatingDto;
import com.salesianostriana.dam.sharetravelBackend.rating.exception.DuplicateRatingException;
import com.salesianostriana.dam.sharetravelBackend.rating.exception.EmptyRatingListException;
import com.salesianostriana.dam.sharetravelBackend.rating.model.Rating;
import com.salesianostriana.dam.sharetravelBackend.rating.repository.RatingRepository;
import com.salesianostriana.dam.sharetravelBackend.reserve.dto.GetReserveByPassengerIdDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.exception.DuplicateReserveException;
import com.salesianostriana.dam.sharetravelBackend.reserve.exception.ReserveNotFoundException;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetAllTripsDto;
import com.salesianostriana.dam.sharetravelBackend.trip.exception.EmptyTripListException;
import com.salesianostriana.dam.sharetravelBackend.user.dto.GetDriverByTripDto;
import com.salesianostriana.dam.sharetravelBackend.user.dto.GetPassengerByTripDto;
import com.salesianostriana.dam.sharetravelBackend.user.exception.UserNotFoundException;
import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;
import com.salesianostriana.dam.sharetravelBackend.user.model.Passenger;
import com.salesianostriana.dam.sharetravelBackend.user.model.User;
import com.salesianostriana.dam.sharetravelBackend.user.repository.DriverRepository;
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
public class RatingService {

    private final RatingRepository ratingRepository;
    private final PassengerRepository passengerRepository;
    private final DriverRepository driverRepository;

    public Page<GetRatingDto> getAllRatings(Pageable p){
        Page<GetRatingDto> result = ratingRepository.findAllRatings(p);
        if(result.isEmpty()){
            throw new EmptyRatingListException("no ratings has been found");
        }
        return result;

    }

    public CreateRatingDto createRating (UUID passengerId, NewRatingDto newRatingDto){
        Optional<Passenger> optionalPassenger = passengerRepository.findById(passengerId);
        Passenger passenger = optionalPassenger.orElseThrow(() -> new UserNotFoundException("no user match this id"+ passengerId));

        Optional<Driver> optionalDriver = driverRepository.findById(newRatingDto.driverId());
        Driver driver = optionalDriver.orElseThrow(() -> new UserNotFoundException("no user match this id"+ newRatingDto.driverId()));

        boolean hasRated = ratingRepository.existsByPassengerAndDriver(passenger, driver);
        if (hasRated) {
            throw new DuplicateRatingException("You have already rated this driver");
        }

        Rating newRating = Rating.builder()
                .ratingDate(LocalDateTime.now())
                .ratingValue(newRatingDto.ratingValue())
                .feedback(newRatingDto.feedback())
                .passenger(passenger)
                .driver(driver)
                .build();
        Rating savedRating = ratingRepository.save(newRating);

        return CreateRatingDto.builder()
                .id(savedRating.getId())
                .ratingDate(savedRating.getRatingDate())
                .ratingValue(savedRating.getRatingValue())
                .feedback(savedRating.getFeedback())
                .driver(savedRating.getDriver()!= null
                        ? GetDriverByTripDto.of(savedRating.getDriver())
                        : null)
                .passenger(savedRating.getPassenger()!= null
                        ? GetPassengerByTripDto.of(savedRating.getPassenger())
                        : null)
                .build();
    }

    public Page<GetRatingByDriverIdDto> getRatingByDriverIdDto(Pageable p, User user){
        Page<GetRatingByDriverIdDto> result = ratingRepository.findRatingsWithPassengerByDriverId(user.getId(), p);
        if (result.isEmpty()){
            throw new EmptyRatingListException("You dont have any ratings yet");
        }
        return result;
    }

}
