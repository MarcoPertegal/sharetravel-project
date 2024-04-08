import { Component } from '@angular/core';
import { LoginService } from '../../service/login.service';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login-page',
  templateUrl: './login-page.component.html',
  styleUrl: './login-page.component.css'
})
export class LoginPageComponent {

  doLogin = new FormGroup({
    username: new FormControl(''),
    password: new FormControl('')
  });

  constructor(private loginService: LoginService, private router: Router) { };

  login() {
    this.loginService.PostLogin(this.doLogin.value.username!, this.doLogin.value.password!).subscribe({
      next: (p) => {
        localStorage.setItem('TOKEN', p.token);
        localStorage.setItem('USER_ID', p.id);
        this.router.navigate(['/trip-page']);
      },
      error: (error) => {
        const message = error.error.message || 'Error desconocido';
        this.router.navigate(['/error-page'], { queryParams: { error: message } });
      }
    });
  }

}
