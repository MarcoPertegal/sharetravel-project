package com.salesianostriana.dam.sharetravelBackend.trip.service;

import com.salesianostriana.dam.sharetravelBackend.trip.repository.TripRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class TripService {
    private final TripRepository tripRepository;
    /*
    public Page<PatientDetailsDto> findAllPatients(Pageable p){
        return patientRepository.findAllPatients(p);
    }
     */
}
