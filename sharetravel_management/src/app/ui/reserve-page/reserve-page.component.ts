import { Component } from '@angular/core';
import { ReserveService } from '../../service/reserve.service';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { Reserve } from '../../model/get-all-reserves-response.interface';

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

  constructor(
    private reserveService: ReserveService,
    private modalService: NgbModal
  ) {
  }
  ngOnInit(): void {
    this.loadNewPage();
  }

  loadNewPage() {
    this.reserveService.GetAll(this.pageNumber - 1).subscribe(resp => {
      this.reserveList = resp.content;
      this.count = resp.totalElements;
    });
  }

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
