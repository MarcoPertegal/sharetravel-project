package com.salesianostriana.dam.sharetravelBackend.user.model;

import com.salesianostriana.dam.sharetravelBackend.reserve.model.Reserve;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="passanger")
@EntityListeners(AuditingEntityListener.class)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Passanger extends User{

    @OneToMany(fetch = FetchType.LAZY)
    @JoinColumn(name = "passanger_id")
    private List<Reserve> reservedTrips = new ArrayList<>();

}
