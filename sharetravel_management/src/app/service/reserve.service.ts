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

  GetAll(fullname: String, page: number): Observable<GetAllReservesResponse> {
    return this.http.get<GetAllReservesResponse>(`${environment.HeadUrl}/reserve/?fullName=${fullname}&page=${page}`,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('TOKEN')}`
        }
      });
  }
  deleteReserveById(id: string) {
    return this.http.delete(`${environment.HeadUrl}/reserve/${id}`,
      {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('TOKEN')}`
        }
      });
  }
}
