import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { PageNotFoundComponent } from '../ui/page-not-found/page-not-found.component';
import { TripPageComponent } from '../ui/trip-page/trip-page.component';
import { LoginPageComponent } from '../ui/login-page/login-page.component';
import { ErrorPageComponent } from '../ui/error-page/error-page.component';

const routes: Routes = [
  { path: 'login-page', component: LoginPageComponent },
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
