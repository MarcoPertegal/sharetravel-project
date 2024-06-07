import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { ReactiveFormsModule } from '@angular/forms';

import { AppRoutingModule } from './module/app-routing.module';
import { AppComponent } from './app.component';
import { NgbModule, NgbNavModule } from '@ng-bootstrap/ng-bootstrap';
import { HTTP_INTERCEPTORS, HttpClientModule, provideHttpClient, withInterceptors } from '@angular/common/http';
import { LoginPageComponent } from './ui/login-page/login-page.component';
import { TripPageComponent } from './ui/trip-page/trip-page.component';
import { NavComponent } from './component/nav/nav.component';
import { PageNotFoundComponent } from './ui/page-not-found/page-not-found.component';
import { ErrorPageComponent } from './ui/error-page/error-page.component';
import { ReservePageComponent } from './ui/reserve-page/reserve-page.component';
import { RatingPageComponent } from './ui/rating-page/rating-page.component';
import { UserPageComponent } from './ui/user-page/user-page.component';
import { httpRequestInterceptor } from './interceptor/http-request.interceptor';

@NgModule({
  declarations: [
    AppComponent,
    LoginPageComponent,
    TripPageComponent,
    NavComponent,
    PageNotFoundComponent,
    ErrorPageComponent,
    ReservePageComponent,
    RatingPageComponent,
    UserPageComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    NgbModule,
    NgbNavModule,
    HttpClientModule,
    ReactiveFormsModule
  ],
  providers: [
    //{ provide: HTTP_INTERCEPTORS, useClass: HttpRequestInterceptor, multi: true },
    provideHttpClient(withInterceptors([httpRequestInterceptor])),
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
