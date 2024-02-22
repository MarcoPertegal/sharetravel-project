package com.salesianostriana.dam.sharetravelBackend.trip.repository;

import com.salesianostriana.dam.sharetravelBackend.trip.model.Trip;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface  TripRepository extends JpaRepository<Trip, UUID> {
    /*
    @Query("""
            SELECT new com.salesianos.triana.VaxConnectApi.user.dto.PatientDetailsDto(
                    p.id,
                    p.name,
                    p.lastName,
                    p.birthDate,
                    p.dni,
                    p.email,
                    p.phoneNumber,
                    p.fotoUrl
                )
            FROM Patient p
           """)
    Page<PatientDetailsDto> findAllPatients(Pageable pageable);
     */
    //Crear el dto
}
