![image](https://github.com/MarcoPertegal/sharetravel-project/assets/122262025/2e790499-7ac7-4528-aa4a-ff922471be5f)


# SHARETRAVEL

Usuario conductor: 
- user: marco123
- contraseña: 1
  
Usuario pasajero:
- user: fran123
- contraseña: 1

Usuario admin:
- user: admin123
- contraseña: 1
  
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
ShareTravel es una aplicación móvil que conecta a personas que quieren realizar el mismo trayecto en coche para ahorrar costes y reducir emisiones, en esta memoria abordaremos los puntos más importantes en relación al proyecto sobre la misma.

La aplicación constará de tres roles:
- Admin: podrá gestionar todas las entidades de la aplicación.
- Conductor: podrá consultar viajes, publicar nuevos viajes, consultar la información del perfil, consultar las valoraciones que le han realizado y gestionar los viajes que ha publicado.
- Pasajero: podrá consultar viajes, realizar una reserva de un viaje, ver los viajes que ha reservado, valorar a los conductores con los que ha viajado, cancelar sus reservas y ver la información de su perfil.

## Estado del Proyecto
Actualmente, el proyecto se encuentra finalizado.

## Demostración de Funciones y Aplicaciones
![figma_screens](https://github.com/MarcoPertegal/sharetravel-project/assets/122262025/9f128798-5d32-4f46-934e-dd80da96f205)
![diagrama_uml](https://github.com/MarcoPertegal/sharetravel-project/assets/122262025/5d0cd220-9c2c-46e6-a26d-16fb4643b442)

- **FLUTTER**

### Pantallas de login:
- Login Page: Al iniciar la aplicación, si el usuario tiene una cuenta, podrá loguearse. Si no, deberá registrarse en la aplicación.
- Register Page: Al pulsar en registrarse se le dará la opción de registrarse como pasajero o conductor. De esta manera, al crear una cuenta, podrá realizar las funcionalidades asignadas al rol que ha elegido. 
    Ambas pantallas redirigirán a un menú con las páginas principales de la aplicación.

### Pantallas Rol Conductor:
- Filer Page: primera opción del menú, esta pantalla podrá realizar un filtrado de los viajes por lugar de salida, lugar de llegada y fecha de salida, si se encuentran viajes aparecerá un listado, si no, se mostrará una pantalla de error en la que informa de que no se han encontrado viajes.
- List Trip Page: Mostrará el listado de viajes devuelto por el método de filtrado estos tendrán la información básica de un viaje y se podrá pulsar en ellos para ver el detalle de los mismos.
- Detail trip page: Se puede consultar toda la información relevante de un viaje tanto lugar de salida y llegada, horario, duración, conductor y un listado de los pasajeros(si tiene), un conductor no podrá reservar un viaje por lo que si pulsa el botón de resarvar aparecerá un dialog informando de esto.
- Publish trip page: segunda opción del menú, un conductor podrá publicar un nuevo viaje introduciendo los datos necesarios, si la publicación es realizada con éxito aparecerá una pantalla de confirmación que informará al usuario.
- Your Trips page: tercera opción del menú, un conductor podrá ver los viajes que tiene publicados, si todavía no tiene ningún viaje publicado aparecerá una pantalla que le informa de esto, podrá editar sus viajes publicados mediante un formulario y podrá borrarlos, estos desaparecerán del listado de viajes reservados de los pasajeros.
- Profile page: cuarta opción del menú, aparecerá la información del usuario logueado, su foto de perfil, descripción, nombre, etc, además aparecerá la media de puntuación de sus valoraciones y un listado con las opiniones de los pasajeros que lo han valorado, si aún no tiene valoraciones aparecerá un texto informativo.

### Pantallas Rol Pasajero:
- Filer Page: primera opción del menú, esta pantalla podrá realizar un filtrado de los viajes por lugar de salida, lugar de llegada y fecha de salida, si se encuentran viajes aparecerá un listado, si no, se mostrará una pantalla de error en la que informa de que no se han encontrado viajes.
- List Trip Page: Mostrará el listado de viajes devuelto por el método de filtrado estos tendrán la información básica de un viaje y se podrá pulsar en ellos para ver el detalle de los mismos.
- Detail trip page: Se puede consultar toda la información relevante de un viaje tanto lugar de salida y llegada, horario, duración, conductor y un listado de los pasajeros(si tiene), un pasajero podrá reservar un viaje por lo que si pulsa el botón de reservar aparecerá una pantalla de confirmación de su reserva, en el caso de que el pasajero y haya reservado ese viaje aparecerá un dialog informativo.
- Publish trip page: segunda opción del menú, un pasajero no podrá publicar viajes.
- Your Reserves page: tercera opción del menú, aparecerá un listado con  las reservas realizadas por el pasajero, podrá cancelarlas o valorar al conductor que ha publicado el viaje reservado, si el pasajero no tiene reservas aparecerá un mensaje informativo.
- Your Profile Page:  cuarta opción del menú, aparecerá la información del usuario logueado, su foto de perfil, descripción, nombre, etc, debido a que los pasajeros no pueden tener valoraciones aparecerá un texto informativo.

- **ANGULAR**

Pantallas Rol Admin:
- Trip page**: listado con toda la información relevante de los viajes publicados de la aplicación, se podrá realizar un filtrado por lugar de salida lugar de llegada y fecha de salida, se podrán editar los viajes y eliminarlos.
- Reserve page: listado con la información relevante de todas las reservas realizadas, se podrán buscar las reservas por el nombre del pasajero, así como eliminar cualquier reserva.
- Rating page: listado con toda la información relevante de las valoraciones, se podrán buscar las valoraciones que tiene un conductor y las que ha realizado un pasajero, además de editarlas y eliminarlas.
- User page: en este listado aparecerán todos los usuarios de la aplicación junto a toda su información relevante, dependiendo del rol que poseen tendrán un icono en específico, se podrá realizar una búsqueda por username, editar la información de cada uno, eliminarlos y crear un nuevo administrador.


## Despliegue del Proyecto
Desde la raíz del proyecto, realiza el comando `docker-compose up -d`.

## Tecnologías Utilizadas
El proyecto se realizó con las siguientes tecnologías:

- Spring Boot, Java, Lombok, JWT Security, Postgres
- Flutter, Dart, Angular

## Personas Desarrolladoras del Proyecto
- Marco Pertegal Prieto.

## Licencia
Creative Commons



