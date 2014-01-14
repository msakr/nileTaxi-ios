//
//  Ticket.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/9/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
@interface Ticket : NSManagedObject


@property (nonatomic,retain) NSNumber *ticket_id;
@property (nonatomic,retain) NSDate *date;
@property (nonatomic,retain) NSString *time;
@property (nonatomic,retain) NSNumber *station_start_id;
@property (nonatomic,retain) NSNumber *station_end_id;
@property (nonatomic,retain) NSNumber *ticket_type;
@property (nonatomic,retain) NSDate *return_date;
@property (nonatomic,retain) NSString *return_time;
@property (nonatomic,retain) NSNumber *isUsed;


//-(id)initWithTicket_id:(NSString*)ticket_id andDate:(NSDate*)date andTime:(NSString*)time andStationStartId:(NSString *)station_start_id andStationEndId:(NSString *)station_end_id andTicketType:(NSString*)ticket_type andReturnDate:(NSDate *)return_date andReturnTime:(NSString*)return_time;
//
////-(id)initWithManagedObject:(NSManagedObject *)obj;
//-(id)initWithJson:(id)json_string;
//

@end
