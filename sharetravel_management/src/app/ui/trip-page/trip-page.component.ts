import { Component } from '@angular/core';
import { Trip } from '../../model/get-all-trips-response.interface';
import { TripService } from '../../service/trip.service';

@Component({
  selector: 'app-trip-page',
  templateUrl: './trip-page.component.html',
  styleUrl: './trip-page.component.css'
})
export class TripPageComponent {
  tripList: Trip[] = [];
  pageNumber: number = 0;
  count: number = 0;

  constructor(
    private tripService: TripService,
    //config: NgbOffcanvasConfig, PARA EL MODAL
    //private offcanvasService: NgbOffcanvas,
    //private modalService: NgbModal
  ) {
    //config.position = 'end';
    //config.backdropClass = 'bg-dark';
    //config.keyboard = false;
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

}
