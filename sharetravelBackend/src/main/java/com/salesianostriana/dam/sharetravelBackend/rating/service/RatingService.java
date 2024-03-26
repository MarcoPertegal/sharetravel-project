package com.salesianostriana.dam.sharetravelBackend.rating.service;

import com.salesianostriana.dam.sharetravelBackend.rating.repository.RatingRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class RatingService {

    private final RatingRepository ratingRepository;



}
