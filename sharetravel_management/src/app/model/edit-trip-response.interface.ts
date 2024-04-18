export interface EditTripResponse {
    id: string;
    departurePlace: string;
    arrivalPlace: string;
    departureTime: Date;
    estimatedDuration: number;
    arrivalTime: Date;
    price: number;
    tripDescription: string;
    driver: Driver;
}

export interface Driver {
    id: string;
    avatar: string;
    fullName: string;
}
