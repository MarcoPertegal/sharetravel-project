package com.salesianostriana.dam.sharetravelBackend.user.service;

import com.salesianostriana.dam.sharetravelBackend.rating.exception.RatingNotFoundException;
import com.salesianostriana.dam.sharetravelBackend.rating.repository.RatingRepository;
import com.salesianostriana.dam.sharetravelBackend.reserve.dto.GetReserveByTripDto;
import com.salesianostriana.dam.sharetravelBackend.reserve.model.Reserve;
import com.salesianostriana.dam.sharetravelBackend.reserve.repository.ReserveRepository;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.refresh.RefreshTokenService;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.CreateTripDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetAllTripsDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDetailsDto;
import com.salesianostriana.dam.sharetravelBackend.trip.dto.GetTripDto;
import com.salesianostriana.dam.sharetravelBackend.trip.exception.EmptyTripListException;
import com.salesianostriana.dam.sharetravelBackend.trip.exception.TripNotFoundException;
import com.salesianostriana.dam.sharetravelBackend.trip.model.Trip;
import com.salesianostriana.dam.sharetravelBackend.trip.repository.TripRepository;
import com.salesianostriana.dam.sharetravelBackend.trip.service.TripService;
import com.salesianostriana.dam.sharetravelBackend.user.dto.*;
import com.salesianostriana.dam.sharetravelBackend.user.exception.UserNotAllowedException;
import com.salesianostriana.dam.sharetravelBackend.user.exception.UserNotFoundException;
import com.salesianostriana.dam.sharetravelBackend.user.model.Driver;
import com.salesianostriana.dam.sharetravelBackend.rating.model.Rating;
import com.salesianostriana.dam.sharetravelBackend.user.model.User;
import com.salesianostriana.dam.sharetravelBackend.user.model.UserRole;
import com.salesianostriana.dam.sharetravelBackend.user.repository.DriverRepository;
import com.salesianostriana.dam.sharetravelBackend.user.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserService {
    private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final DriverRepository driverRepository;
    private final RatingRepository ratingRepository;
    private final TripService tripService;
    private final TripRepository tripRepository;
    private final RefreshTokenService refreshTokenService;
    private final ReserveRepository reserveRepository;

    public User createUser(CreateUserRequest createUserRequest, EnumSet<UserRole> roles) {

        if (userRepository.existsByUsernameIgnoreCase(createUserRequest.getUsername()))
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "El nombre de usuario ya existe");

        User user =  User.builder()
                .username(createUserRequest.getUsername())
                .password(passwordEncoder.encode(createUserRequest.getPassword()))
                .avatar(createUserRequest.getAvatar())
                .fullName(createUserRequest.getFullName())
                .email(createUserRequest.getEmail())
                .phoneNumber(createUserRequest.getPhoneNumber())
                .personalDescription(createUserRequest.getPersonalDescription())
                .roles(roles)
                .build();

        return userRepository.save(user);
    }

    public User createUserWithAdminRole(CreateUserRequest createUserRequest) {
        return createUser(createUserRequest, EnumSet.of(UserRole.ADMIN));
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public Optional<User> findById(UUID id) {
        return userRepository.findById(id);
    }

    public Optional<User> findByUsername(String username) {
        return userRepository.findFirstByUsername(username);
    }

    public Optional<User> edit(User user) {

        // El username no se puede editar
        // La contraseña se edita en otro método

        return userRepository.findById(user.getId())
                .map(u -> {
                    u.setAvatar(user.getAvatar());
                    u.setFullName(user.getFullName());
                    return userRepository.save(u);
                }).or(() -> Optional.empty());

    }

    public Optional<User> editPassword(UUID userId, String newPassword) {

        // Aquí no se realizan comprobaciones de seguridad. Tan solo se modifica

        return userRepository.findById(userId)
                .map(u -> {
                    u.setPassword(passwordEncoder.encode(newPassword));
                    return userRepository.save(u);
                });

    }

    public void delete(User user) {
        deleteById(user.getId());
    }

    public void deleteById(UUID id) {
        // Prevenimos errores al intentar borrar algo que no existe
        if (userRepository.existsById(id))
            userRepository.deleteById(id);
    }

    public boolean passwordMatch(User user, String clearPassword) {
        return passwordEncoder.matches(clearPassword, user.getPassword());
    }

    public GetUserDetailsDto findLoggedById(User loggedUser){
        //Se hace un casteo a driver para poder llamar a la lista de ratings
        //Como da el error de lazy al sacar los ratings de un driver
        //Hay que hacer una consulta con left join a tabla rating para extraer la lista
        //Como da un error de casteo si el usuario logueado es un passenger que no tiene ratings
        //hay que realizar una comprobación
        //Si averageRating esta ha cero significa que el driver no tiene valoraciones
        //Si esta en negativo significa que el usuario es passenger(mejorar mas adelante para que
        // pueda tener valoraciones tambien)
        double averageRating;
        if (Objects.equals(loggedUser.getRoles().toString(), "[DRIVER]")){
            Driver driver = (Driver) loggedUser;
            Optional<Driver> result = driverRepository.findByIdWithRatings(driver.getId());
            Driver driverWithRating = result.orElseThrow(() -> new EmptyTripListException("no driver match this id"));
            averageRating = driverWithRating.getRatings().stream()
                    .mapToDouble(Rating::getRatingValue)
                    .average()
                    .orElse(0.0);
            averageRating = Math.round(averageRating * 10.0) / 10.0;
        } else {
            averageRating = -1.0;
        }

        return GetUserDetailsDto.builder()
                .id(loggedUser.getId().toString())
                .email(loggedUser.getEmail())
                .phoneNumber(loggedUser.getPhoneNumber())
                .personalDescription(loggedUser.getPersonalDescription())
                .avatar(loggedUser.getAvatar())
                .fullName(loggedUser.getFullName())
                .averageRating(Double.toString(averageRating))
                .build();
    }

    public Page<UserDataDto> getAllUsers(Pageable p){
        List<User> result = userRepository.findAll();
        if(result.isEmpty()){
            throw new EmptyTripListException("no users has been found");
        }
        List<UserDataDto> userDataDtoList = result.stream()
                .map(this::convertToUserDataDto)
                .collect(Collectors.toList());

        return new PageImpl<>(userDataDtoList, p, result.size());
    }

    private UserDataDto convertToUserDataDto(User user) {
        return UserDataDto.builder()
                .id(user.getId())
                .avatar(user.getAvatar())
                .username(user.getUsername())
                .fullName(user.getFullName())
                .email(user.getEmail())
                .phoneNumber(user.getPhoneNumber())
                .personalDescription(user.getPersonalDescription())
                .roles(user.getRoles().toString())
                .createdAt(user.getCreatedAt())
                .build();
    }

    @Transactional
    public UserDataDto editUser(UUID id, EditUserDto editUserDto){

        Optional<User> optionalUser = userRepository.findById(id);
        User editUser = optionalUser.orElseThrow(() -> new UserNotFoundException("no user match this id"+ id));

        editUser.setAvatar(editUserDto.avatar());
        editUser.setFullName(editUserDto.fullName());
        editUser.setEmail(editUserDto.email());
        editUser.setPhoneNumber(editUserDto.phoneNumber());
        editUser.setPersonalDescription(editUserDto.personalDescription());
        User saverUser = userRepository.save(editUser);

        return UserDataDto.builder()
                .id(saverUser.getId())
                .avatar(saverUser.getAvatar())
                .username(saverUser.getUsername())
                .fullName(saverUser.getFullName())
                .email(saverUser.getEmail())
                .phoneNumber(saverUser.getPhoneNumber())
                .personalDescription(saverUser.getPersonalDescription())
                .roles(saverUser.getRoles().toString())
                .createdAt(saverUser.getCreatedAt())
                .build();

    }

    @Transactional
    public UserDataDto getUserById(UUID id) {
        Optional<User> optionalUser = userRepository.findById(id);
        User user = optionalUser.orElseThrow(() -> new UserNotFoundException("no user match this id: "+ id));

        return UserDataDto.builder()
                .id(user.getId())
                .avatar(user.getAvatar())
                .username(user.getUsername())
                .fullName(user.getFullName())
                .email(user.getEmail())
                .phoneNumber(user.getPhoneNumber())
                .personalDescription(user.getPersonalDescription())
                .roles(user.getRoles().toString())
                .createdAt(user.getCreatedAt())
                .build();
    }

    @Transactional
    public void deleteByUserId (UUID id) {

        Optional<User> optionalUser = userRepository.findById(id);
        User user = optionalUser.orElseThrow(() -> new UserNotFoundException("No user found with that id"));

        if (user.getRoles().toString().equals("[DRIVER]")){

            List<Rating> driverRatings = ratingRepository.findByDriverId(id);
            driverRatings.forEach(ratingRepository::delete);

            List<Trip> driverTrips = tripRepository.findByDriverId(id);
            driverTrips.forEach(trip -> tripService.deleteByTripId(user, trip.getId()));
        }

        if (user.getRoles().toString().equals("[PASSENGER]")){
            List<Reserve> passengerReserves = reserveRepository.findByPassengerId(id);
            passengerReserves.forEach(reserveRepository::delete);
        }

        //si el user se ha logueado hay que eliminarle el refresh token antes de borrarlo
        refreshTokenService.deleteByUser(user);

        //Comprobación para que un admin no se borre a sí mismo


        userRepository.deleteById(user.getId());
    }
}
