package com.salesianostriana.dam.sharetravelBackend.user.model;

import com.salesianostriana.dam.sharetravelBackend.reserve.model.Reserve;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
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
@AllArgsConstructor
@SuperBuilder
public class Passenger extends User{

    //Poner la asociacion a LAZY mas adelante?
    @OneToMany(mappedBy = "passenger", fetch = FetchType.EAGER)
    private List<Reserve> reservedTrips = new ArrayList<>();

}
