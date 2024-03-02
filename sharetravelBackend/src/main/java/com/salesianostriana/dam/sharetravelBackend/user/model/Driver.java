package com.salesianostriana.dam.sharetravelBackend.user.model;

import com.salesianostriana.dam.sharetravelBackend.reserve.model.Reserve;
import com.salesianostriana.dam.sharetravelBackend.trip.model.Trip;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.util.ArrayList;
import java.util.List;


@EntityListeners(AuditingEntityListener.class)
@Entity
@Data
@NoArgsConstructor
//@AllArgsConstructor
@SuperBuilder
public class Driver extends User{
    /*
    @OneToMany
    @JoinColumn(name = "driver_id", nullable = false)
    private List<Trip> publishedTrips = new ArrayList<>();*/
    //ver si dejar la asociacion en la clase trips(como está ahora) o descomentar esto y moverla a este lado
    //¿Qué diferencia hay?

}
