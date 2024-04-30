import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { GetAllRatingsResponse } from '../model/get-all-ratings-response.interface';
import { environment } from '../../environments/environment.development';
import { Observable } from 'rxjs';
import { EditRatingResponse } from '../model/edit-rating-reponse.interface';
import { GetRatingByIdResponse } from '../model/get-rating-by-id.interface';

@Injectable({
  providedIn: 'root'
})
export class RatingService {

  constructor(private http: HttpClient) { }

  GetAll(page: number): Observable<GetAllRatingsResponse> {
    return this.http.get<GetAllRatingsResponse>(`${environment.HeadUrl}/rating/?page=${page}`,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('TOKEN')}`
        }
      });
  }

  editRatingById(id: string, ratingValue: number, feedback: string): Observable<EditRatingResponse> {
    return this.http.put<EditRatingResponse>(`${environment.HeadUrl}/rating/${id}`,
      {
        "ratingValue": `${ratingValue}`,
        "feedback": `${feedback}`
      },
      {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('TOKEN')}`
        }
      }
    );
  }

  getRatingById(id: string): Observable<GetRatingByIdResponse> {
    return this.http.get<GetRatingByIdResponse>(`${environment.HeadUrl}/rating/${id}`,
      {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('TOKEN')}`
        }
      }
    );
  }

}
