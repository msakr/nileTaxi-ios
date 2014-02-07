//
//  Constants.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/9/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject


#define ticketID @"ticket_id"
#define dateOfTrip @"date"
#define timeOfTrip @"time"
#define stationStartId @"station_start_id"
#define stationEndId @"station_end_id"
#define ticketType @"ticket_type"
#define returnTime @"return_time"
#define returnDate @"return_date"
#define isUseds @"isUsed"



#define booking_stationFrom @"stationFrom"
#define booking_stationTo @"stationTo"
#define booking_returnTime @"returnTime"
#define booking_reservationTime @"resrvationTime"
#define booking_name @"name"
#define booking_email @"email"
#define booking_mobileNumber @"mobileNum"
#define booking_numberOfTickets @"numTickets"
#define booking_isRound @"isround"
#define booking_ReservationDate @"reservationDate"
#define booking_ReturnDate @"returnDate"
#define booking_price @"bookPrice"

#define booking_trips @"trips"


#define trip_type_Express 1
#define trip_type_Oncall 2
#define trip_type_Trips 3

@end
