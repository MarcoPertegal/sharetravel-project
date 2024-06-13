![image](https://github.com/MarcoPertegal/sharetravel-project/assets/122262025/2e790499-7ac7-4528-aa4a-ff922471be5f)


# SHARETRAVEL

Driver User: 
- user: marco123
- password: 1
  
Passenger User:
- user: fran123
- password: 1

Admin User:
- user: admin123
- password: 1
  
## Index:
- Project Description
- Project Status
- Features and Applications Demonstration
- Project Deployment: Both the Flutter App and the API
- Technologies Used
- Project Developers
- License

![cover](https://github.com/MarcoPertegal/sharetravel-project/assets/122262025/b142cae7-8e4a-4c5b-b028-86a1b5387b9d)

## Project Description
ShareTravel is a mobile application that connects people who want to travel the same route by car to save costs and reduce emissions. This document outlines the key points related to the project.

The application has three roles:
- Admin: Can manage all entities within the application.
- Driver: Can view trips, post new trips, check profile information, view ratings received, and manage posted trips.
- Passenger: Can view trips, book trips, see booked trips, rate the drivers they've traveled with, cancel bookings, and view profile information.

## Project Status
The project is currently complete.

## Features and Applications Demonstration
![figma_screens](https://github.com/MarcoPertegal/sharetravel-project/assets/122262025/9f128798-5d32-4f46-934e-dd80da96f205)
![uml_diagram](https://github.com/MarcoPertegal/sharetravel-project/assets/122262025/5d0cd220-9c2c-46e6-a26d-16fb4643b442)

### FLUTTER

#### Login Screens:
- **Login Page:** When the application starts, users with an account can log in. New users must register first.
- **Register Page:** By selecting register, users can choose to sign up as a passenger or a driver. Upon creating an account, they can access functionalities assigned to their chosen role. Both screens redirect to a menu with the main pages of the application.

#### Driver Role Screens:
- **Filter Page:** The first menu option allows filtering trips by departure location, arrival location, and departure date. If trips are found, a list is displayed; otherwise, an error screen indicates no trips found.
- **List Trip Page:** Shows the list of trips returned by the filter method, displaying basic trip information. Users can tap on trips to view details.
- **Detail Trip Page:** Displays all relevant trip information, including departure and arrival locations, schedule, duration, driver, and a list of passengers (if any). Drivers cannot book trips, and if they try, a dialog informs them of this.
- **Publish Trip Page:** The second menu option allows drivers to post a new trip by entering the necessary data. A success screen confirms the trip's publication.
- **Your Trips Page:** The third menu option lets drivers view their posted trips. If no trips are posted, an informational screen appears. Drivers can edit or delete their trips, which also removes them from passengers' reserved trips lists.
- **Profile Page:** The fourth menu option displays the logged-in user's profile information, including profile picture, description, name, average rating, and passenger reviews. If there are no reviews, an informational text appears.

#### Passenger Role Screens:
- **Filter Page:** The first menu option allows filtering trips by departure location, arrival location, and departure date. If trips are found, a list is displayed; otherwise, an error screen indicates no trips found.
- **List Trip Page:** Shows the list of trips returned by the filter method, displaying basic trip information. Users can tap on trips to view details.
- **Detail Trip Page:** Displays all relevant trip information, including departure and arrival locations, schedule, duration, driver, and a list of passengers (if any). Passengers can book trips, and upon booking, a confirmation screen appears. If the trip is already booked by the passenger, an informative dialog appears.
- **Your Reserves Page:** The third menu option shows a list of reservations made by the passenger, allowing cancellations or driver ratings. If no reservations are made, an informational message appears.
- **Your Profile Page:** The fourth menu option displays the logged-in user's profile information, including profile picture, description, name, etc. Since passengers cannot receive ratings, an informational text appears.

### ANGULAR

#### Admin Role Screens:
- **Trip Page:** A list of all published trips' relevant information. Trips can be filtered by departure location, arrival location, and departure date, and can be edited or deleted.
- **Reserve Page:** A list of all reservations' relevant information. Reservations can be searched by the passenger's name and deleted.
- **Rating Page:** A list of all ratings' relevant information. Ratings can be searched by the driver's ratings and the passenger's ratings. They can be edited or deleted.
- **User Page:** Displays all users with their relevant information. Depending on their role, they will have a specific icon. Users can be searched by username, edited, deleted, and new admins can be created.

## Project Deployment
- From the sharetravelBackend directory, run the command `docker-compose up -d` to start server.
- Navigate to sharetravel_management directory and run the command `npm i` and then `npm start` to run administator web app.
- Navigate to sharetravel_frontend directory and run the command `flutter pub get` and then `flutter run` to run user movile-app.

## Technologies Used
The project was developed using the following technologies:

- Spring Boot, Java, Lombok, JWT Security, Postgres
- Flutter, Dart, Angular

## Project Developers
- Marco Pertegal Prieto

## License
Creative Commons



