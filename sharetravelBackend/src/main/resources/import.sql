INSERT INTO user_entity (id, username, password, email, phone_number, personal_description, avatar, full_name, account_non_expired, account_non_locked, credentials_non_expired, enabled, created_at) VALUES ('09fe7587-487a-49ba-8188-ec1a9ddc7b3f', 'marco123', '{bcrypt}$2a$12$XH8wT6/caAydqRgAMb1pn.B44Jby3J8b5Uz82kfqOh2QLmpJbpn1G', 'marco@gmail.com', '408452322','Reliable driver who values punctuality and silence during the journey. Efficient and uncomplicated routes, no room for unnecessary chatter.', 'https://previews.123rf.com/images/rawpixel/rawpixel1704/rawpixel170441704/76561515-retrato-de-personas-estudio-disparar-con-expresi%C3%B3n-de-cara-sonriente.jpg',  'Marco Pertegal Prieto', true, true, true, true, '2024-05-01T21:00:00');
INSERT INTO driver (id) VALUES ('09fe7587-487a-49ba-8188-ec1a9ddc7b3f');
INSERT INTO user_roles (user_id, roles) VALUES ('09fe7587-487a-49ba-8188-ec1a9ddc7b3f', 1);

INSERT INTO user_entity (id, username, password, email, phone_number, personal_description, avatar, full_name, account_non_expired, account_non_locked, credentials_non_expired, enabled, created_at) VALUES ('d85d42e8-5950-4b7a-9a1d-06716fa8ef47', 'miguel123', '{bcrypt}$2a$12$XH8wT6/caAydqRgAMb1pn.B44Jby3J8b5Uz82kfqOh2QLmpJbpn1G', 'miguel@gmail.com', '706424242', 'Road trip enthusiast who loves exploring new destinations. Offering a relaxed and friendly atmosphere. Ready to share road trip stories and interesting discoveries.', 'https://www.redaccionmedica.com/images/destacados/las-personas-con-un-riesgo-genetico-bajo-de-tdah-son-mas-afortunadas--2868.jpg', 'Miguel Campos González', true, true, true, true, '2024-05-01T21:00:00');
INSERT INTO driver (id) VALUES ('d85d42e8-5950-4b7a-9a1d-06716fa8ef47');
INSERT INTO user_roles (user_id, roles) VALUES ('d85d42e8-5950-4b7a-9a1d-06716fa8ef47', 1);

INSERT INTO user_entity (id, username, password, email, phone_number, personal_description, avatar, full_name, account_non_expired, account_non_locked, credentials_non_expired, enabled, created_at) VALUES ('f47ac10b-58cc-4372-a567-0e02b2c3d479', 'fran123', '{bcrypt}$2a$12$XH8wT6/caAydqRgAMb1pn.B44Jby3J8b5Uz82kfqOh2QLmpJbpn1G', 'fran@gmail.com', '604234567', 'Relaxed traveler seeking peaceful experiences. Enjoying the scenery and soft music. A pleasant and calm companion for the journey.', 'https://f.rpp-noticias.io/2019/02/15/753300descarga-11jpg.jpg', 'Fran Ruíz Prieto', true, true, true, true, '2024-05-01T21:00:00');
INSERT INTO passenger (id) VALUES ('f47ac10b-58cc-4372-a567-0e02b2c3d479');
INSERT INTO user_roles (user_id, roles) VALUES ('f47ac10b-58cc-4372-a567-0e02b2c3d479', 2);

INSERT INTO user_entity (id, username, password, email, phone_number, personal_description, avatar, full_name, account_non_expired, account_non_locked, credentials_non_expired, enabled, created_at) VALUES ('ef9458e8-7834-4df8-ba48-79aadfaa42d3', 'fernando123', '{bcrypt}$2a$12$XH8wT6/caAydqRgAMb1pn.B44Jby3J8b5Uz82kfqOh2QLmpJbpn1G', 'fernando@gmail.com', '606040205', 'Passionate about reading, always carrying a good book to immerse myself during the journey. Not much of a talker, but always ready to share literary recommendations.', 'https://www.laguiadelvaron.com/wp-content/uploads/2018/12/ai-image-generation-fake-faces-people-nvidia-5c18b20b472c2__700.jpg', 'Fernando Pérez Gil', true, true, true, true, '2024-05-01T21:00:00');
INSERT INTO passenger (id) VALUES ('ef9458e8-7834-4df8-ba48-79aadfaa42d3');
INSERT INTO user_roles (user_id, roles) VALUES ('ef9458e8-7834-4df8-ba48-79aadfaa42d3', 2);

INSERT INTO user_entity (id, username, password, email, phone_number, personal_description, avatar, full_name, account_non_expired, account_non_locked, credentials_non_expired, enabled, created_at) VALUES ('0c0e22b3-92b0-413b-90bc-1fd837ba5fba', 'admin123', '{bcrypt}$2a$12$XH8wT6/caAydqRgAMb1pn.B44Jby3J8b5Uz82kfqOh2QLmpJbpn1G', 'roberto@admin.com', '335545434', 'Roberto Ruíz Vega', 'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg', 'Felipe García Gómez', true, true, true, true, '2024-05-01T21:00:00');
INSERT INTO user_roles (user_id, roles) VALUES ('0c0e22b3-92b0-413b-90bc-1fd837ba5fba', 0);

INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description, driver_id) VALUES ('5d9458e8-7834-4df8-ba48-79aadfaa42d3', 'Seville', 'Sanlúcar de Barrameda', '2024-05-01T10:00:00', 120, '2024-05-01T12:00:00', 7, 'I have space for three passengers, no flexibility in the arrival place, and hand luggage only', '09fe7587-487a-49ba-8188-ec1a9ddc7b3f');
INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description, driver_id) VALUES ('6f9458e8-7834-4df8-ba48-79aadfaa42d4', 'Seville', 'Sanlúcar de Barrameda', '2024-05-01T17:15:00', 110, '2024-05-01T18:30:00', 8, 'I can drop off in nearby places in Sanlúcar, two passengers with hand luggage only', 'd85d42e8-5950-4b7a-9a1d-06716fa8ef47');
INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description, driver_id) VALUES ('cf9458e8-7834-4df8-ba48-79aadfaa42d5', 'Madrid', 'Barcelona', '2024-05-23T08:30:00', 180, '2024-02-23T11:30:00', 15, 'Trip to Barcelona', 'd85d42e8-5950-4b7a-9a1d-06716fa8ef47');
INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description, driver_id) VALUES ('df9458e8-7834-4df8-ba48-79aadfaa42d6', 'Seville', 'Sanlúcar de Barrameda', '2024-05-01T15:00:00', 90, '2024-05-01T16:15:00', 5, 'Trip to Cádiz with space for two passengers', '09fe7587-487a-49ba-8188-ec1a9ddc7b3f');
INSERT INTO trip (id, departure_place, arrival_place, departure_time, estimated_duration, arrival_time, price, trip_description, driver_id) VALUES ('af9458e8-7834-4df8-ba48-79aadfaa42d7', 'Seville', 'Sanlúcar de Barrameda', '2024-05-01T18:15:00', 50, '2024-05-20T19:30:00', 12, 'Trip to Valencia with stops in intermediate cities', 'd85d42e8-5950-4b7a-9a1d-06716fa8ef47');

INSERT INTO reserve (id, reserve_date, passenger_id, trip_id) VALUES ('100a570a-3b5f-4b51-ace0-44c8dd7580db', '2024-04-29T17:15:00', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', '5d9458e8-7834-4df8-ba48-79aadfaa42d3');
INSERT INTO reserve (id, reserve_date, passenger_id, trip_id) VALUES ('9fedff98-d9f4-46b7-809c-cce716ed6699', '2024-05-1T17:19:00', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', '6f9458e8-7834-4df8-ba48-79aadfaa42d4');
INSERT INTO reserve (id, reserve_date, passenger_id, trip_id) VALUES ('ba262511-1e49-4ebf-bfba-930b86e1a092', '2024-04-29T10:30:00', 'ef9458e8-7834-4df8-ba48-79aadfaa42d3', '6f9458e8-7834-4df8-ba48-79aadfaa42d4');

INSERT INTO rating (id, rating_date, rating_value, feedback, passenger_id, driver_id) VALUES ('d42504ee-dc7f-4025-beff-6ec4af0f567d', '2024-05-1T22:22:00', 4.6, 'An enjoyable and pleasant trip, I recommend it', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', '09fe7587-487a-49ba-8188-ec1a9ddc7b3f');
INSERT INTO rating (id, rating_date, rating_value, feedback, passenger_id, driver_id) VALUES ('846fb48c-fe49-4e53-bb5a-50cf08691bfc', '2024-06-1T14:00:00', 5.0, 'A very comfortable and enjoyable trip', 'ef9458e8-7834-4df8-ba48-79aadfaa42d3', '09fe7587-487a-49ba-8188-ec1a9ddc7b3f');
INSERT INTO rating (id, rating_date, rating_value, feedback, passenger_id, driver_id) VALUES ('8007b140-753e-40a9-8912-877e36058e99', '2024-07-1T16:00:00', 3.8, 'Good driving skills', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 'd85d42e8-5950-4b7a-9a1d-06716fa8ef47');