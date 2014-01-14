//
//  Ticket.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/9/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "Ticket.h"
#import "Constants.h"
@implementation Ticket

@dynamic ticket_id;
@dynamic date;
@dynamic time;
@dynamic station_start_id;
@dynamic station_end_id;
@dynamic ticket_type;
@dynamic return_date;
@dynamic return_time;
@dynamic isUsed;
//-(id)initWithTicket_id:(NSString*)ticket_id andDate:(NSDate*)date andTime:(NSString*)time andStationStartId:(NSString *)station_start_id andStationEndId:(NSString *)station_end_id andTicketType:(NSString*)ticket_type andReturnDate:(NSDate *)return_date andReturnTime:(NSString*)return_time{
//    self=[super init];
//    if (self) {
//        
//        
//        
//        _ticket_id=ticket_id;
//        _date=date;
//        _time=time;
//        _station_start_id=station_start_id;
//        _station_end_id=station_end_id;
//        _ticket_type=ticket_type;
//        _return_date=return_date;
//        _return_time=return_time;
//        
//        
//        
//    }
//    return self;
//    
//}
//
//
//-(id)initWithJson:(id)json_string{
//    self=[super init];
//    if (self) {
//        
//        
//
//        
//        
//        
//        
//        _ticket_id=[json_string objectForKey:ticketID];
//        
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[json_string objectForKey:dateOfTrip]doubleValue]];
//
//        _date=date;
//        _time=[json_string objectForKey:timeOfTrip];
//        _station_start_id=[json_string objectForKey:stationStartId];
//        _station_end_id=[json_string objectForKey:stationEndId];
//        _ticket_type=[json_string objectForKey:ticketType];
//        _return_time=[json_string objectForKey:returnTime];
//        
//        if ([json_string objectForKey:returnDate]!=nil) {
//            NSDate *date_return = [NSDate dateWithTimeIntervalSince1970:[[json_string objectForKey:returnDate]doubleValue]];
//            _return_date=date_return;
//        }
//
//        
//        
//        
//        
//        
//        
//    }
//    return self;
//}


//-(id)initWithManagedObject:(NSManagedObject *)obj
//{
//    self=[super init];
//    if (self) {
//        
//        
//        
//        
//        
//        
//        
//        _ticket_id=[obj valueForKey:ticketID];
//        
//        NSDate *date = [obj valueForKey:dateOfTrip];
//        
//        _date=date;
//        _time=[obj valueForKey:timeOfTrip];
//        _station_start_id=[obj valueForKey:stationStartId];
//        _station_end_id=[obj valueForKey:stationEndId];
//        _ticket_type=[obj valueForKey:ticketType];
//        _return_time=[obj valueForKey:returnTime];
//        
//        if ([obj valueForKey:returnDate]!=nil) {
//            NSDate *date_return = [obj valueForKey:returnDate];
//            _return_date=date_return;
//        }
//        
//        
//        
//        
//        
//        
//        
//    }
//    return self;
//}

@end
