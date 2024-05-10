import { Component } from '@angular/core';
import { User } from '../../model/get-all-users-response.interface';
import { UserService } from '../../service/user.service';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { GetUserByIDResponse } from '../../model/get-user-by-id.interface';
import { FormControl, FormGroup, Validators } from '@angular/forms';

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
      this.count = resp.totalElements;
    });
  }

  editModal(editUser: any, id: any) {
    this.userId = id;
    this.userService.getUserById(id).subscribe(
      (userDetails: GetUserByIDResponse) => {
        if (userDetails) {
          this.modalService.open(editUser);
          this.modifyUser.setValue({
            fullName: userDetails.fullName,
            email: userDetails.email,
            phoneNumber: userDetails.phoneNumber,
            personalDescription: userDetails.personalDescription,
            avatar: userDetails.avatar

          });
        } else {
          alert('User not found!');
        }
      },
      (error) => {
        console.error('Error retrieving user details:', error);
      }
    );
  }

  modifyUser = new FormGroup({
    fullName: new FormControl('', Validators.required),
    email: new FormControl('', Validators.required),
    phoneNumber: new FormControl('', Validators.required),
    personalDescription: new FormControl('', Validators.required),
    avatar: new FormControl('', Validators.required),
  })

  editUs() {
    this.userService.editUserById(
      this.userId,
      this.modifyUser.value.fullName!,
      this.modifyUser.value.email!,
      this.modifyUser.value.phoneNumber!,
      this.modifyUser.value.personalDescription!,
      this.modifyUser.value.avatar!,
    ).subscribe(() => {
      this.closeModal();
      location.reload();
    },
      error => {
        if (error.status === 400)
          window.alert('Invalid data or something go wrong!!');
      }
    );
  }
  closeModal() {
    this.modalService.dismissAll();
  }

  deleteUs() {
    this.userService.deleteUserById(this.userId).subscribe(
      () => {
        location.reload();
      },
      error => {
        if (error.status === 403)
          window.alert('Logged admin cant delete himself!');
        if (error.status === 404)
          window.alert('No trip found with that id');
        if (error.status === 400)
          window.alert('Unexpected error');
      }
    );
  }

  deleteModal(deleteUser: any, id: any) {
    this.userId = id;
    this.modalService.open(deleteUser);
  }
}
