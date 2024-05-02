export interface GetAllUsersResponse {
    content: User[];
    pageable: Pageable;
    last: boolean;
    totalPages: number;
    totalElements: number;
    size: number;
    number: number;
    sort: Sort;
    first: boolean;
    numberOfElements: number;
    empty: boolean;
}

export interface User {
    id: string;
    avatar: string;
    username: string;
    fullName: null | string;
    email: null | string;
    phoneNumber: null | string;
    personalDescription: null | string;
    roles: string;
    createdAt: Date;
}

export interface Pageable {
    pageNumber: number;
    pageSize: number;
    sort: Sort;
    offset: number;
    unpaged: boolean;
    paged: boolean;
}

export interface Sort {
    empty: boolean;
    unsorted: boolean;
    sorted: boolean;
}
