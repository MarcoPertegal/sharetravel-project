package com.salesianostriana.dam.sharetravelBackend.user.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@EntityListeners(AuditingEntityListener.class)
@Entity
@Data
@NoArgsConstructor
@SuperBuilder
public class Passenger extends User{

}
