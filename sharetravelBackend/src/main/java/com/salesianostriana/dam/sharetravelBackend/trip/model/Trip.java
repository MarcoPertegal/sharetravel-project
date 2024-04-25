package com.salesianostriana.dam.sharetravelBackend.trip.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.salesianostriana.dam.sharetravelBackend.reserve.model.Reserve;
import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.UuidGenerator;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Entity
@EntityListeners(AuditingEntityListener.class)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Trip {
    @Id
    @GeneratedValue(generator = "UUID")
    @UuidGenerator
    @Column(columnDefinition = "uuid")
    private UUID id;

    private String departurePlace;

    private String arrivalPlace;

    //@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy HH:mm:ss")
    private LocalDateTime departureTime;

    private int estimatedDuration;//EN MINUTOS

    //@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy HH:mm:ss")
    private LocalDateTime arrivalTime;

    private double price;

    private String tripDescription;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "driver_id", nullable = false)
    private Driver driver;

    @ToString.Exclude
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "trip_id")
    private List<Reserve> reserves;

    public void calculateArrivalTime() {
        if (departureTime != null && estimatedDuration > 0) {
            this.arrivalTime = departureTime.plusMinutes(estimatedDuration);
        }
    }

}
