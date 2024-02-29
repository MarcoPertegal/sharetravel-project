INSERT INTO user_entity (id, username, password, email, phone_number, personal_description, avatar, full_name, rating, account_non_expired, account_non_locked, credentials_non_expired, enabled) VALUES ('09fe7587-487a-49ba-8188-ec1a9ddc7b3f', 'marco', '{bcrypt}$2a$12$XH8wT6/caAydqRgAMb1pn.B44Jby3J8b5Uz82kfqOh2QLmpJbpn1G', 'marco@gmail.com', NULL, NULL, 'Soy estudiante de programacion en Sevilla', NULL, 4.6, true, true, true, true);
INSERT INTO user_entity (id, username, password, email, phone_number, personal_description, avatar, full_name, rating, account_non_expired, account_non_locked, credentials_non_expired, enabled) VALUES ('5bbf88cf-c116-4d4c-92a3-0f1bb001ee33', 'miguel', '{bcrypt}$2a$12$XH8wT6/caAydqRgAMb1pn.B44Jby3J8b5Uz82kfqOh2QLmpJbpn1G', 'miguel@gmail.com', NULL, NULL, 'Trabajo en sevila en los Salesianos de Triana', NULL, 3.3, true, true, true, true);
INSERT INTO user_roles (user_id, roles) VALUES ('09fe7587-487a-49ba-8188-ec1a9ddc7b3f', 1);
INSERT INTO user_roles (user_id, roles) VALUES ('09fe7587-487a-49ba-8188-ec1a9ddc7b3f', 2);

INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description, driver) VALUES ('5d9458e8-7834-4df8-ba48-79aadfaa42d3', 'Seville', 'Sanlúcar de Barrameda', '2024-05-01T10:00:00', 120, '2024-05-01T12:00:00', 7.99, 'Viaje de prueba');
INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description, driver) VALUES ('6f9458e8-7834-4df8-ba48-79aadfaa42d4', 'Seville', 'Sanlúcar de Barrameda', '2024-05-01T17:15:00', 120, '2024-05-01T18:30:00', 8.50, 'Viaje de prueba2');
INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description) VALUES ('cf9458e8-7834-4df8-ba48-79aadfaa42d5', 'Madrid', 'Barcelona', '2024-02-23T08:30:00', 180, '2024-02-23T11:30:00', 15.50, 'Viaje a Barcelona');
INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description) VALUES ('7a9458e8-7834-4df8-ba48-79aadfaa42d6', 'Valencia', 'Alicante', '2024-02-24T14:45:00', 90, '2024-02-24T16:15:00', 9.99, 'Viaje corto a Alicante');
INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description) VALUES ('8b9458e8-7834-4df8-ba48-79aadfaa42d7', 'Barcelona', 'Madrid', '2024-02-25T11:00:00', 150, '2024-02-25T13:30:00', 12.75, 'Viaje de vuelta a Madrid');
INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description) VALUES ('9a9458e8-7834-4df8-ba48-79aadfaa42d8', 'Granada', 'Málaga', '2024-02-26T12:30:00', 120, '2024-02-26T14:30:00', 12.75, 'Viaje a Málaga');
INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description) VALUES ('ab9458e8-7834-4df8-ba48-79aadfaa42d3', 'Seville', 'Cordoba', '2024-02-27T09:15:00', 60, '2024-02-27T10:15:00', 5.99, 'Viaje corto a Cordoba');
INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description) VALUES ('bc9458e8-7834-4df8-ba48-79aadfaa42d3', 'Valencia', 'Barcelona', '2024-02-28T16:30:00', 120, '2024-02-28T18:30:00', 11.50, 'Viaje a Barcelona');
INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description) VALUES ('cd9458e8-7834-4df8-ba48-79aadfaa42d3', 'Seville', 'Granada', '2024-03-01T14:00:00', 90, '2024-03-01T15:30:00', 8.50, 'Viaje a Granada');
INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description) VALUES ('de9458e8-7834-4df8-ba48-79aadfaa42d3', 'Madrid', 'Valencia', '2024-03-02T10:45:00', 120, '2024-03-02T12:45:00', 10.99, 'Viaje a Valencia');
INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description) VALUES ('ef9458e8-7834-4df8-ba48-79aadfaa42d3', 'Barcelona', 'Seville', '2024-03-03T13:30:00', 150, '2024-03-03T16:00:00', 14.99, 'Viaje de vuelta a Seville');

INSERT
INTO
  trip
  (id, driver)
VALUES
  ('07ae9391-ccd1-400f-be05-f81ca4476294', '401c44ca-a039-4d71-bf23-2d48b3f8da2c');