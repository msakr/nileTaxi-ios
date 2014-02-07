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


@property (nonatomic,retain) NSString *email;
@property (nonatomic,retain) NSString *from_name;
@property (nonatomic,retain) NSString *idd;
@property (nonatomic,retain) NSNumber *isUsed;
@property (nonatomic,retain) NSString *mobile;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *num_tickets;
@property (nonatomic,retain) NSString *rrn;
@property (nonatomic,retain) NSString *ticket_type;
@property (nonatomic,retain) NSString *to_name;
@property (nonatomic,retain) NSString *trans_date;
@property (nonatomic,retain) NSString *trans_time;



@property (nonatomic,retain) NSNumber *isValid;

+(id)getTicketWithJson:(NSDictionary *)data;





//-(id)initWithTicket_id:(NSString*)ticket_id andDate:(NSDate*)date andTime:(NSString*)time andStationStartId:(NSString *)station_start_id andStationEndId:(NSString *)station_end_id andTicketType:(NSString*)ticket_type andReturnDate:(NSDate *)return_date andReturnTime:(NSString*)return_time;
//
////-(id)initWithManagedObject:(NSManagedObject *)obj;
//-(id)initWithJson:(id)json_string;
//

@end
