import { Component } from '@angular/core';
import { LoginService } from '../../service/login.service';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login-page',
  templateUrl: './login-page.component.html',
  styleUrl: './login-page.component.css'
})
export class LoginPageComponent {

  doLogin = new FormGroup({
    username: new FormControl('', Validators.required),
    password: new FormControl('', Validators.required)
  });

  constructor(private loginService: LoginService, private router: Router) { }

  login() {
    this.loginService.PostLogin(this.doLogin.value.username!, this.doLogin.value.password!).subscribe({
      next: (p) => {
        localStorage.setItem('TOKEN', p.token);
        localStorage.setItem('USER_ID', p.id);
        localStorage.setItem('AVATAR', p.avatar);
        localStorage.setItem('USERNAME', p.username);
        localStorage.setItem('REFRESH_TOKEN', p.refreshToken);
        if (p.userRol === '[ADMIN]') {
          this.router.navigate(['/trip-page']);
        } else {
          this.router.navigate(['/error-page'], { queryParams: { error: 'Access denied, only admins can access this page' } });
        }
      },
      error: (error) => {
        const message = error.error.message || 'Error desconocido';
        this.router.navigate(['/error-page'], { queryParams: { error: message } });
      }
    });
  }

}
