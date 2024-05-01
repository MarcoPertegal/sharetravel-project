import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GetAllReservesResponse } from '../model/get-all-reserves-response.interface';
import { environment } from '../../environments/environment.development';

@Injectable({
  providedIn: 'root'
})
export class ReserveService {

  constructor(private http: HttpClient) { }

  GetAll(page: number): Observable<GetAllReservesResponse> {
    return this.http.get<GetAllReservesResponse>(`${environment.HeadUrl}/reserve/?page=${page}`,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('TOKEN')}`
        }
      });
  }
}
