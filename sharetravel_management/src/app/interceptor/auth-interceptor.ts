import { Injectable } from '@angular/core';
import {
  HttpEvent,
  HttpInterceptor,
  HttpHandler,
  HttpRequest,
  HttpErrorResponse,
} from '@angular/common/http';
import { Observable, throwError, BehaviorSubject } from 'rxjs';
import { catchError, switchMap } from 'rxjs/operators';
import { AuthService } from '../service/auth.service';
import { Router } from '@angular/router';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {
  private isRefreshing = false;
  private refreshTokenSubject: BehaviorSubject<any> = new BehaviorSubject<any>(null);

  constructor(private authService: AuthService, private router: Router) { }


  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    return next.handle(req).pipe(
      catchError((error) => {
        if (error instanceof HttpErrorResponse && error.status === 403) {

          localStorage.setItem('ERROR_MESSAGE', error.error.message);

          if (req.url.includes('/refreshtoken')) {
            this.router.navigate(['/login-page']);
            window.alert('Refresh token expired, please login again');
            return throwError(() => new Error('Refresh token expired, please login again'));
          } else {
            return this.handle403Error(req, next);
          }
        } else {
          return throwError(() => error);
        }
      })
    );
  }

  private handle403Error(request: HttpRequest<any>, next: HttpHandler) {
    if (!this.isRefreshing) {
      this.isRefreshing = true;
      this.refreshTokenSubject.next(null);

      return this.authService.refreshToken().pipe(
        switchMap((tokenResponse: any) => {
          this.isRefreshing = false;
          const newToken = tokenResponse.token;
          const newRefreshToken = tokenResponse.refreshToken;

          localStorage.setItem('TOKEN', newToken);
          localStorage.setItem('REFRESH_TOKEN', newRefreshToken);

          this.refreshTokenSubject.next(newToken);

          return next.handle(this.addToken(request, newToken));
        }),
        catchError((err) => {
          this.isRefreshing = false;
          return throwError(() => new Error(err.message));
        })
      );
    } else {
      return this.refreshTokenSubject.pipe(
        switchMap(token => next.handle(this.addToken(request, token)))
      );
    }
  }

  private addToken(request: HttpRequest<any>, token: string) {
    return request.clone({
      setHeaders: {
        Authorization: `Bearer ${token}`
      }
    });
  }
}
