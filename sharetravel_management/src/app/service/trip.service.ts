import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GetAllTripsResponse } from '../model/get-all-trips-response.interface';
import { environment } from '../../environments/environment.development';

@Injectable({
  providedIn: 'root'
})
export class TripService {

  constructor(private http: HttpClient) { }

  GetAll(page: number): Observable<GetAllTripsResponse> {
    let token = localStorage.getItem('TOKEN');
    return this.http.get<GetAllTripsResponse>(`${environment.HeadUrl}/trip/?page=${page}`,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${token}`
        }
      });
  }
}
