import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GetAllUsersResponse } from '../model/get-all-users-response.interface';
import { environment } from '../../environments/environment.development';
import { EditUserResponse } from '../model/edit-user-response.interface';
import { GetUserByIDResponse } from '../model/get-user-by-id.interface';
import { CreateAdminResponse } from '../model/create-admin.response';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private http: HttpClient) { }

  GetAll(page: number, filterRole: string): Observable<GetAllUsersResponse> {
    return this.http.get<GetAllUsersResponse>(`${environment.HeadUrl}/user/filter?filterRole=${filterRole}&page=${page}`,
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

  deleteUserById(id: string) {
    return this.http.delete(`${environment.HeadUrl}/user/${id}`,
      {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('TOKEN')}`
        }
      });
  }

  CreateAdmin(avatar: string, username: string, password: string, fullName: string, email: string, phoneNumber: string, personalDescription: string): Observable<CreateAdminResponse> {
    return this.http.post<CreateAdminResponse>(`${environment.HeadUrl}/auth/register/admin`,
      {
        "avatar": `${avatar}`,
        "username": `${username}`,
        "password": `${password}`,
        "fullName": `${fullName}`,
        "email": `${email}`,
        "phoneNumber": `${phoneNumber}`,
        "personalDescription": `${personalDescription}`
      },
      {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('TOKEN')}`
        }
      }
    );
  }
}
