import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment.development';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private http: HttpClient) { }

  refreshToken(): Observable<any> {
    const refreshToken = localStorage.getItem('REFRESH_TOKEN');
    return this.http.post(`${environment.HeadUrl}/refreshtoken`, { refreshToken });
  }
}
