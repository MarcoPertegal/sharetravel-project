import { Component } from '@angular/core';
import { Rating } from '../../model/get-all-ratings-response.interface';
import { RatingService } from '../../service/rating.service';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { GetRatingByIdResponse } from '../../model/get-rating-by-id.interface';
import { FormControl, FormGroup, Validators } from '@angular/forms';

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

  editModal(editRating: any, id: any) {
    this.ratingId = id;
    this.ratingService.getRatingById(id).subscribe(
      (ratingDetails: GetRatingByIdResponse) => {
        if (ratingDetails) {
          this.modalService.open(editRating);
          this.modifyRating.setValue({
            ratingValue: ratingDetails.ratingValue.toString(),
            feedback: ratingDetails.feedback
          });
        } else {
          alert('Rating not found!');
        }
      },
      (error) => {
        console.error('Error retrieving rating details:', error);
      }
    );
  }

  modifyRating = new FormGroup({
    ratingValue: new FormControl('', [Validators.required, Validators.min(1), Validators.max(5)]),
    feedback: new FormControl('', Validators.required),
  })

  editRat() {
    this.ratingService.editRatingById(
      this.ratingId,
      Number(this.modifyRating.value.ratingValue!),
      this.modifyRating.value.feedback!,
    ).subscribe(() => {
      this.closeModal();
      location.reload();
    },
      error => {
        if (error.status === 400)
          window.alert('Invalid data or something go wrong!!');
      }
    );
  }
  closeModal() {
    this.modalService.dismissAll();
  }

  deleteRat() {
    this.ratingService.deleteRatingById(this.ratingId).subscribe(
      () => {
        location.reload();
      },
      error => {
        if (error.status === 404)
          window.alert('No rating found with that id');
        if (error.status === 400)
          window.alert('Unexpected error');
      }
    );
  }

  deleteModal(deleteRating: any, id: any) {
    this.ratingId = id;
    this.modalService.open(deleteRating);
  }
}
