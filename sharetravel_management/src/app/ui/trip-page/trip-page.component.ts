import { Component } from '@angular/core';
import { Trip } from '../../model/get-all-trips-response.interface';
import { TripService } from '../../service/trip.service';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { GetTripByIDResponse } from '../../model/get-trip-by-id.interface';

@Component({
  selector: 'app-trip-page',
  templateUrl: './trip-page.component.html',
  styleUrl: './trip-page.component.css'
})
export class TripPageComponent {
  tripList: Trip[] = [];
  pageNumber: number = 0;
  count: number = 0;
  tripId!: string;

  constructor(
    private tripService: TripService,
    private modalService: NgbModal
  ) {
  }
  ngOnInit(): void {
    this.loadNewPage();
  }

  loadNewPage() {
    this.tripService.GetAll(this.pageNumber - 1).subscribe(resp => {
      this.tripList = resp.content;
      this.count = resp.totalElements;
    });
  }

  ////////////////EDIT TRIP
  //metodo para abrir el modal para abrirlo simplemente hace 
  //falta el "this.modalService.open(editTrip);" y el "this.tripId = id;" para pasarselo
  //al metodo que edita el viaje el resto es para poner los datos del viaje en el formulario
  editModal(editTrip: any, id: any) {
    this.tripId = id;
    this.tripService.getTripById(id).subscribe(
      (tripDetails: GetTripByIDResponse) => {
        if (tripDetails) {
          this.modalService.open(editTrip);
          this.modifyTrip.setValue({
            departurePlace: tripDetails.departurePlace,
            arrivalPlace: tripDetails.arrivalPlace,
            departureTime: tripDetails.departureTime.toString(),
            estimatedDuration: tripDetails.estimatedDuration.toString(),
            price: tripDetails.price.toString(),
            tripDescription: tripDetails.tripDescription
          });
        } else {
          alert('Trip not found!');
        }
      },
      (error) => {
        console.error('Error retrieving trip details:', error);
      }
    );
  }

  modifyTrip = new FormGroup({
    departurePlace: new FormControl('', Validators.required),
    arrivalPlace: new FormControl('', Validators.required),
    departureTime: new FormControl('', Validators.required),
    estimatedDuration: new FormControl('', [Validators.required, Validators.min(3)]),
    price: new FormControl('', [Validators.required, Validators.min(1)]),
    tripDescription: new FormControl('', Validators.required),
  })

  editTr() {
    this.tripService.editTripById(
      this.tripId,
      this.modifyTrip.value.departurePlace!,
      this.modifyTrip.value.arrivalPlace!,
      this.modifyTrip.value.departureTime!,
      Number(this.modifyTrip.value.estimatedDuration!),
      Number(this.modifyTrip.value.price!),
      this.modifyTrip.value.tripDescription!
    ).subscribe(() => {
      this.closeModal();
      location.reload();
    },
      error => {
        if (error.status === 400) {
          if (error.error.errors && error.error.errors.length > 0) {
            const errorMessage = error.error.errors[0].defaultMessage;
            window.alert(errorMessage);
          } else {
            window.alert('Invalid date time format!!');
          }
        } else {
          window.alert('Something go wrong!!');
        }
      }
    );
  }
  closeModal() {
    this.modalService.dismissAll();
  }

  deleteTr() {
    this.tripService.deleteTripById(this.tripId).subscribe(
      () => {
        location.reload();
      },
      error => {
        if (error.status === 404)
          window.alert('No trip found with that id');
        if (error.status === 400)
          window.alert('Unexpected error');
      }
    );
  }

  deleteModal(deleteTrip: any, id: any) {
    this.tripId = id;
    this.modalService.open(deleteTrip);
  }

}
