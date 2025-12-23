import { Component } from '@angular/core';
import { ReserveService } from '../../service/reserve.service';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { Reserve } from '../../model/get-all-reserves-response.interface';
import { FormControl, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-reserve-page',
  templateUrl: './reserve-page.component.html',
  styleUrl: './reserve-page.component.css'
})
export class ReservePageComponent {
  reserveList: Reserve[] = [];
  pageNumber: number = 0;
  count: number = 0;
  reserveId!: string;
  fullName: string = '';

  constructor(
    private reserveService: ReserveService,
    private modalService: NgbModal
  ) {
  }
  ngOnInit(): void {
    this.loadNewPage();
  }

  loadNewPage() {
    this.reserveService.GetAll(this.fullName, this.pageNumber - 1).subscribe(resp => {
      this.reserveList = resp.content;
      this.count = resp.totalElements;
    });
  }

  ///Filtro por nombre del propietario de la reserva
  findReserve = new FormGroup({
    fullName: new FormControl('')
  });

  filterModal(filterReserve: any) {
    this.modalService.open(filterReserve);
  }

  findRes() {
    this.fullName = this.findReserve.value.fullName ?? '';
    this.pageNumber = 1;
    this.loadNewPage();
    this.closeModal();
  }
////////////////////

  closeModal() {
    this.modalService.dismissAll();
  }

  deleteRes() {
    this.reserveService.deleteReserveById(this.reserveId).subscribe(
      () => {
        location.reload();
      },
      error => {
        if (error.status === 404)
          window.alert('No reserve found with that id');
        if (error.status === 400)
          window.alert('Unexpected error');
      }
    );
  }

  deleteModal(deleteReserve: any, id: any) {
    this.reserveId = id;
    this.modalService.open(deleteReserve);
  }

}
