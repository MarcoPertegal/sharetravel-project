import { Component } from '@angular/core';
import { Rating } from '../../model/get-all-ratings-response.interface';
import { RatingService } from '../../service/rating.service';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-rating-page',
  templateUrl: './rating-page.component.html',
  styleUrl: './rating-page.component.css'
})
export class RatingPageComponent {
  ratingList: Rating[] = [];
  pageNumber: number = 0;
  count: number = 0;
  ratingId!: string;

  constructor(
    private ratingService: RatingService,
    private modalService: NgbModal
  ) {
  }
  ngOnInit(): void {
    this.loadNewPage();
  }

  loadNewPage() {
    this.ratingService.GetAll(this.pageNumber - 1).subscribe(resp => {
      this.ratingList = resp.content;
      this.count = resp.totalElements;
    });
  }
}
