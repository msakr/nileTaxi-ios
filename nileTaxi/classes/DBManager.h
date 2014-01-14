//
//  DBManager.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/9/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ticket.h"
@interface DBManager : NSObject

+(BOOL)addTicketToDBWithTicket_id:(NSNumber*)ticket_id andDate:(NSDate*)date andTime:(NSString*)time andStationStartId:(NSNumber *)station_start_id andStationEndId:(NSNumber *)station_end_id andTicketType:(NSNumber*)ticket_type andReturnDate:(NSDate *)return_date andReturnTime:(NSString*)return_time withNSManagedObjectContext:(NSManagedObjectContext*)context;

+(NSMutableArray*)getAllTicketsWithNSManagedObjectContext:(NSManagedObjectContext*)context;


@end
