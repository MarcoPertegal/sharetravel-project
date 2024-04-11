import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

import { environment } from '../../environments/environment.development';
import { LoginResponse } from '../model/login-response.interface';

@Injectable({
  providedIn: 'root'
})
export class LoginService {

  constructor(private http: HttpClient) { }

  PostLogin(username: string, password: string): Observable<LoginResponse> {
    return this.http.post<LoginResponse>(`${environment.HeadUrl}/auth/login`,
      {
        "username": `${username}`,
        "password": `${password}`
      }
    );
  }


}
