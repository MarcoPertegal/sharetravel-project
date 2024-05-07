import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GetAllUsersResponse } from '../model/get-all-users-response.interface';
import { environment } from '../../environments/environment.development';
import { EditUserResponse } from '../model/edit-user-response.interface';
import { GetUserByIDResponse } from '../model/get-user-by-id.interface';

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

  editUserById(id: string, fullName: string, email: string, phoneNumber: string, personalDescription: string, avatar: string): Observable<EditUserResponse> {
    return this.http.put<EditUserResponse>(`${environment.HeadUrl}/user/${id}`,
      {
        "fullName": `${fullName}`,
        "email": `${email}`,
        "phoneNumber": `${phoneNumber}`,
        "personalDescription": `${personalDescription}`,
        "avatar": `${avatar}`
      },
      {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('TOKEN')}`
        }
      }
    );
  }

  getUserById(id: string): Observable<GetUserByIDResponse> {
    return this.http.get<GetUserByIDResponse>(`${environment.HeadUrl}/user/${id}`,
      {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('TOKEN')}`
        }
      }
    );
  }
}
