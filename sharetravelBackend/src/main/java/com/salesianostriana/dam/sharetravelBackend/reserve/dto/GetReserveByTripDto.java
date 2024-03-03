package com.salesianostriana.dam.sharetravelBackend.reserve.dto;

import com.salesianostriana.dam.sharetravelBackend.reserve.model.Reserve;
import com.salesianostriana.dam.sharetravelBackend.user.dto.GetDriverByTripDto;
import com.salesianostriana.dam.sharetravelBackend.user.dto.GetPassengerByTripDto;
import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;

import java.time.LocalDateTime;

public record GetReserveByTripDto(
        LocalDateTime reserveDate,
        GetPassengerByTripDto passenger
) {
    public static GetReserveByTripDto of(Reserve r){
        return new GetReserveByTripDto(
                r.getReserveDate(),
                (r.getPassenger() == null) ? null
                        : GetPassengerByTripDto.of(r.getPassenger())
        );
    }
}
