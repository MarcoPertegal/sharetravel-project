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


  //comprueba todas las peticiones http si devuelve un 403 comprueba si la ruta incluye /refreshtoken
  //si es así redirije al usuario a la login page para que se loguee de nuevo y reciba una nueva 
  //pareja de tokens, si el error es 403 pero no inclye refrshToken llama al otro metodo
  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    return next.handle(req).pipe(
      catchError((error) => {
        if (error instanceof HttpErrorResponse && error.status === 403) {
          //EL error mensaje de delete admin pq al ser un 403 tmb y al gestionar el json de respuesta 
          //se setea a undefined por lo que la unica forma de pasarle el mensaje de error para mostrarlo
          //si el delete da errror es asi pq al llamarlo desde el mismo archivo donde se hace la peticion
          //de delete peta
          localStorage.setItem('ERROR_MESSAGE', error.error.message);

          //si dan 403 he incluyen refreshToken se ejecutará este codigo
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
