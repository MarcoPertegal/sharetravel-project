import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { GetAllRatingsResponse } from '../model/get-all-ratings-response.interface';
import { environment } from '../../environments/environment.development';
import { Observable } from 'rxjs';

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
}
