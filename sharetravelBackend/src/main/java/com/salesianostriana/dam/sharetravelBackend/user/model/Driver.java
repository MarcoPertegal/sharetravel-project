package com.salesianostriana.dam.sharetravelBackend.user.model;

import com.salesianostriana.dam.sharetravelBackend.rating.model.Rating;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.util.List;


@EntityListeners(AuditingEntityListener.class)
@Entity
@Data
@NoArgsConstructor
@SuperBuilder
public class Driver extends User{

    @ToString.Exclude
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "driver_id")
    private List<Rating> ratings;
}
