import { Component } from '@angular/core';
import { User } from '../../model/get-all-users-response.interface';
import { UserService } from '../../service/user.service';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-user-page',
  templateUrl: './user-page.component.html',
  styleUrl: './user-page.component.css'
})
export class UserPageComponent {
  userList: User[] = [];
  pageNumber: number = 0;
  count: number = 0;
  userId!: string;

  constructor(
    private userService: UserService,
    private modalService: NgbModal
  ) {
  }
  ngOnInit(): void {
    this.loadNewPage();
  }

  loadNewPage() {
    this.userService.GetAll(this.pageNumber - 1).subscribe(resp => {
      this.userList = resp.content;
      console.log("LISTAAA" + this.userList);
      this.count = resp.totalElements;
    });
  }

  closeModal() {
    this.modalService.dismissAll();
  }

}
