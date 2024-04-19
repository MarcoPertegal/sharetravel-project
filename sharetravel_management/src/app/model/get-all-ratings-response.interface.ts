export interface GetAllRatingsResponse {
    content: Rating[];
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

export interface Rating {
    id: string;
    ratingDate: Date;
    ratingValue: number;
    feedback: string;
    driver: Driver;
    passenger: Passenger;
}

export interface Driver {
    id: string;
    avatar: string;
    fullName: string;
}

export interface Passenger {
    avatar: string;
    fullName: string;
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
