import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { PageNotFoundComponent } from '../ui/page-not-found/page-not-found.component';
import { TripPageComponent } from '../ui/trip-page/trip-page.component';
import { LoginPageComponent } from '../ui/login-page/login-page.component';
import { ErrorPageComponent } from '../ui/error-page/error-page.component';
import { ReservePageComponent } from '../ui/reserve-page/reserve-page.component';
import { RatingPageComponent } from '../ui/rating-page/rating-page.component';
import { UserPageComponent } from '../ui/user-page/user-page.component';

const routes: Routes = [
  { path: 'login-page', component: LoginPageComponent },
  { path: 'reserve-page', component: ReservePageComponent },
  { path: 'rating-page', component: RatingPageComponent },
  { path: 'user-page', component: UserPageComponent },
  { path: 'trip-page', component: TripPageComponent },
  { path: 'error-page', component: ErrorPageComponent },
  { path: '', pathMatch: 'full', redirectTo: '/login-page' },
  { path: '**', component: PageNotFoundComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
