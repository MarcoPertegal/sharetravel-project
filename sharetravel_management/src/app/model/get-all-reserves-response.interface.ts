export interface GetAllReservesResponse {
    content: Reserve[];
    pageable: Pageable;
    last: boolean;
    totalElements: number;
    totalPages: number;
    size: number;
    number: number;
    sort: Sort;
    first: boolean;
    numberOfElements: number;
    empty: boolean;
}

export interface Reserve {
    id: string;
    reserveDate: Date;
    trip: Trip;
    passenger: Passenger;
}

export interface Passenger {
    avatar: string;
    fullName: string;
}

export interface Trip {
    id: string;
    departurePlace: string;
    arrivalPlace: string;
    price: number;
}

export interface Pageable {
    pageNumber: number;
    pageSize: number;
    sort: Sort;
    offset: number;
    paged: boolean;
    unpaged: boolean;
}

export interface Sort {
    empty: boolean;
    sorted: boolean;
    unsorted: boolean;
}
