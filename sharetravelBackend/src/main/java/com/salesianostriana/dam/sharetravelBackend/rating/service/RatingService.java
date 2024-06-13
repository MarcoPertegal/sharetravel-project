package com.salesianostriana.dam.sharetravelBackend.rating.service;

import com.salesianostriana.dam.sharetravelBackend.rating.dto.*;
import com.salesianostriana.dam.sharetravelBackend.rating.exception.DuplicateRatingException;
import com.salesianostriana.dam.sharetravelBackend.rating.exception.EmptyRatingListException;
import com.salesianostriana.dam.sharetravelBackend.rating.exception.RatingNotFoundException;
import com.salesianostriana.dam.sharetravelBackend.rating.model.Rating;
import com.salesianostriana.dam.sharetravelBackend.rating.repository.RatingRepository;
import com.salesianostriana.dam.sharetravelBackend.user.dto.GetDriverByTripDto;
import com.salesianostriana.dam.sharetravelBackend.user.dto.GetPassengerByTripDto;
import com.salesianostriana.dam.sharetravelBackend.user.exception.UserNotFoundException;
import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;
import com.salesianostriana.dam.sharetravelBackend.user.model.Passenger;
import com.salesianostriana.dam.sharetravelBackend.user.model.User;
import com.salesianostriana.dam.sharetravelBackend.user.repository.DriverRepository;
import com.salesianostriana.dam.sharetravelBackend.user.repository.PassengerRepository;
import jakarta.transaction.Transactional;
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
public class RatingService {

    private final RatingRepository ratingRepository;
    private final PassengerRepository passengerRepository;
    private final DriverRepository driverRepository;

    @Value("${already.rate.driver}")
    private String alreadyRateDriverMessage;
    @Value("${rating.not.found}")
    private String ratingNotFoundMessage;
    @Value("${passenger.not.found}")
    private String passengerNotFoundMessage;
    @Value("${driver.not.found}")
    private String driverNotFoundMessage;
    @Value("${user.empty.rating}")
    private String userEmptyRatingMessage;
    @Value("${rating.not.match.id}")
    private String ratingNotMatchIdMessage;


    public Page<GetRatingDto> getAllRatings(Pageable p){
        Page<GetRatingDto> result = ratingRepository.findAllRatings(p);
        if(result.isEmpty()){
            throw new EmptyRatingListException(ratingNotFoundMessage);
        }
        return result;

    }

    public CreateRatingDto createRating (UUID passengerId, NewRatingDto newRatingDto){
        Optional<Passenger> optionalPassenger = passengerRepository.findById(passengerId);
        Passenger passenger = optionalPassenger.orElseThrow(() -> new UserNotFoundException(passengerNotFoundMessage));

        Optional<Driver> optionalDriver = driverRepository.findById(newRatingDto.driverId());
        Driver driver = optionalDriver.orElseThrow(() -> new UserNotFoundException(driverNotFoundMessage));

        boolean hasRated = ratingRepository.existsByPassengerAndDriver(passenger, driver);
        if (hasRated) {
            throw new DuplicateRatingException(alreadyRateDriverMessage);
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
            throw new EmptyRatingListException(userEmptyRatingMessage);
        }
        return result;
    }

    @Transactional
    public GetRatingBasicDataDto editRating(UUID id,NewRatingDto newRatingDto){

        Optional<Rating> optionalRating = ratingRepository.findById(id);
        Rating editRating = optionalRating.orElseThrow(() -> new RatingNotFoundException(ratingNotMatchIdMessage));

        editRating.setRatingValue(newRatingDto.ratingValue());
        editRating.setFeedback(newRatingDto.feedback());
        Rating savedRating = ratingRepository.save(editRating);

        return GetRatingBasicDataDto.builder()
                .id(savedRating.getId())
                .ratingDate(savedRating.getRatingDate())
                .feedback(savedRating.getFeedback())
                .ratingValue(savedRating.getRatingValue())
                .build();
    }

    public GetRatingBasicDataDto findById(UUID id){
        Optional<Rating> optionalRating = ratingRepository.findById(id);
        Rating rating = optionalRating.orElseThrow(() -> new RatingNotFoundException(ratingNotMatchIdMessage));
        return GetRatingBasicDataDto.builder()
                .id(rating.getId())
                .ratingDate(rating.getRatingDate())
                .ratingValue(rating.getRatingValue())
                .feedback(rating.getFeedback())
                .build();
    }

    public void deleteByRatingId (UUID id) {
        if (!ratingRepository.existsById(id)){
            throw new RatingNotFoundException(ratingNotMatchIdMessage);
        }
        ratingRepository.deleteById(id);
    }

}
