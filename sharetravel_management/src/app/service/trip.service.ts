import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GetAllTripsResponse } from '../model/get-all-trips-response.interface';
import { environment } from '../../environments/environment.development';
import { EditTripResponse } from '../model/edit-trip-response.interface';
import { GetTripByIDResponse } from '../model/get-trip-by-id.interface';

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
  editTripById(id: string, departurePlace: string, arrivalPlace: string, departureTime: string, estimatedDuration: number, price: number, tripDescription: string): Observable<EditTripResponse> {
    return this.http.put<EditTripResponse>(`${environment.HeadUrl}/trip/${id}`,
      {
        "departurePlace": `${departurePlace}`,
        "arrivalPlace": `${arrivalPlace}`,
        "departureTime": `${departureTime}`,
        "estimatedDuration": `${estimatedDuration}`,
        "price": `${price}`,
        "tripDescription": `${tripDescription}`
      },
      {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('TOKEN')}`
        }
      }
    );
  }
  getTripById(id: string): Observable<GetTripByIDResponse> {
    return this.http.get<GetTripByIDResponse>(`${environment.HeadUrl}/trip/${id}`,
      {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('TOKEN')}`
        }
      }
    );
  }

  deleteTripById(id: string) {
    return this.http.delete(`${environment.HeadUrl}/trip/${id}`,
      {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('TOKEN')}`
        }
      });

  }

}
