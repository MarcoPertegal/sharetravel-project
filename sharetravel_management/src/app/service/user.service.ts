import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GetAllUsersResponse } from '../model/get-all-users-response.interface';
import { environment } from '../../environments/environment.development';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private http: HttpClient) { }

  GetAll(page: number): Observable<GetAllUsersResponse> {
    return this.http.get<GetAllUsersResponse>(`${environment.HeadUrl}/user/?page=${page}`,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('TOKEN')}`
        }
      });
  }
}
