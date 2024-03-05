![image](https://github.com/MarcoPertegal/sharetravel-project/assets/122262025/2e790499-7ac7-4528-aa4a-ff922471be5f)


# SHARETRAVEL

## Índice:
- Descripción del Proyecto
- Estado del Proyecto
- Demostración de Funciones y Aplicaciones
- Despliegue del Proyecto: tanto de la app Flutter como de la API
- Tecnologías Utilizadas
- Personas Desarrolladoras del Proyecto
- Licencia


![portada](https://github.com/MarcoPertegal/sharetravel-project/assets/122262025/b142cae7-8e4a-4c5b-b028-86a1b5387b9d)
## Descripción del Proyecto
SHARETRAVEL es una aplicación móvil que conecta a personas que quieren realizar el mismo trayecto en coche para ahorrar costes y reducir emisiones.
La aplicación constará de tres roles:
- Admin: podrá gestionar todas las entidades de la aplicación.
- Conductor: podrá consultar viajes, publicar nuevos viajes, gestionar su perfil y realizar operaciones CRUD con los viajes que ha publicado.
- Pasajero: podrá consultar viajes, realizar una reserva de un viaje, valorar a los conductores con los que ha viajado, ver los viajes que ha reservado y gestionar su perfil.

## Estado del Proyecto
Actualmente, el proyecto cuenta con un login y dos registros para cada rol, una pantalla que filtra por lugar de salida, lugar de llegada y fecha de salida. Tras realizar el filtrado, se mostrará un listado de los viajes que coincidan con las credenciales. Si no se encuentran viajes que coincidan, deberá aparecer un mensaje de que no hay viajes disponibles con esas credenciales. Cuando se pulsa en un viaje, se pueden ver los detalles del mismo y ver el perfil del usuario logueado. Faltaría realizar la creación de un nuevo viaje si el usuario registrado es conductor, la gestión de los viajes publicados o reservados, gestionar el perfil del usuario, poder reservar un viaje, pulsar en el lugar de salida o llegada en el detalle de un viaje y ver en maps la ubicación, valorar conductores.

## Demostración de Funciones y Aplicaciones
![figma_screens](https://github.com/MarcoPertegal/sharetravel-project/assets/122262025/9f128798-5d32-4f46-934e-dd80da96f205)
![diagrama_uml](https://github.com/MarcoPertegal/sharetravel-project/assets/122262025/5d0cd220-9c2c-46e6-a26d-16fb4643b442)

Al iniciar la aplicación, si el usuario tiene una cuenta, podrá loguearse. Si no, deberá registrarse en la aplicación eligiendo entre tener un rol de pasajero o conductor. De esta manera, al crear una cuenta, podrá realizar las funcionalidades asignadas al rol que ha elegido. Ambos roles de usuario podrán filtrar por lugar de salida, lugar de llegada y fecha de salida. Tras realizar el filtrado, se mostrará un listado de los viajes que coincidan con las credenciales. Si no se encuentran viajes que coincidan, deberá aparecer un mensaje de que no hay viajes disponibles con esas credenciales. Cuando se pulsa en un viaje, se pueden ver los detalles del mismo y si el usuario tiene rol pasajero dará la opción de reservar. Se podrá pulsar en el lugar de salida o llegada y ver la ubicación en Google Maps. Una vez reservado, aparecerá una pantalla de confirmación de la reserva. 
Si el usuario es conductor, podrá crear un nuevo viaje rellenando un formulario. 
En el apartado 'My trips' un usuario conductor podrá readlizar operaciones CRUD con los viajes que ha creado y un pasajero podrá ver los viajes que ha realizado y valorar al conductor del mismo. 
Ambos usuarios podrán ver su perfil y realizar opereciones CRUD .

## Despliegue del Proyecto
Desde la raíz del proyecto, realiza el comando `docker-compose up -d`.

## Tecnologías Utilizadas
El proyecto se realizó con las siguientes tecnologías:
Back:
- Spring Boot, Java, Lombok, JWT Security, Postgres
Front:
- Flutter, Dart

## Personas Desarrolladoras del Proyecto
El proyecto fue realizado por Marco Pertegal Prieto.

## Licencia
Creative Commons



