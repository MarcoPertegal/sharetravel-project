export interface GetTripByIDResponse {
    id: string;
    departurePlace: string;
    arrivalPlace: string;
    departureTime: Date;
    estimatedDuration: number;
    arrivalTime: Date;
    price: number;
    tripDescription: string;
    driver: Driver;
    reserves: Reserve[];
}

export interface Driver {
    id: string;
    avatar: string;
    fullName: string;
}

export interface Reserve {
    reserveDate: Date;
    passenger: Passenger;
}

export interface Passenger {
    avatar: string;
    fullName: string;
}
