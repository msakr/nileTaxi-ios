//
//  DBManager.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/9/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "DBManager.h"
#import "nilecodeAppDelegate.h"
#import "Ticket.h"


@implementation DBManager
+(BOOL)addTicketToDBWithTicket_id:(NSNumber*)ticket_id andDate:(NSDate*)date andTime:(NSString*)time andStationStartId:(NSNumber *)station_start_id andStationEndId:(NSNumber *)station_end_id andTicketType:(NSNumber*)ticket_type andReturnDate:(NSDate *)return_date andReturnTime:(NSString*)return_time withNSManagedObjectContext:(NSManagedObjectContext*)context{

//    nilecodeAppDelegate *appDelegate =
//    [[UIApplication sharedApplication] delegate];
    
    Ticket   *newContact;
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Tickets"
                  inManagedObjectContext:context];
    
    newContact.ticket_id=ticket_id;
    newContact.ticket_type=ticket_type;
    newContact.date=date;
    newContact.time=time;
    newContact.station_start_id=station_start_id;
    newContact.station_end_id=station_end_id;
    newContact.return_date=return_date;
    newContact.return_time=return_time;
    newContact.isUsed=[NSNumber numberWithBool:NO];
//    [newContact setValue:[NSNumber numberWithInt:ticket.ticket_id.intValue] forKey:ticketID];
//    [newContact setValue:[NSNumber numberWithInt:ticket.ticket_type.intValue] forKey:ticketType];
//    [newContact setValue:ticket.date forKey:dateOfTrip];
//    [newContact setValue:ticket.time forKey:timeOfTrip];
    
//    [newContact setValue:[NSNumber numberWithInt:ticket.station_start_id.intValue] forKey:stationStartId];
//    [newContact setValue:[NSNumber numberWithInt:ticket.station_end_id.intValue] forKey:stationEndId];
//    [newContact setValue:ticket.return_date forKey:returnDate];
//    [newContact setValue:ticket.return_time forKey:returnTime];
//    [newContact setValue:NO forKey:isUsed];

    
    
    NSError *error;
    [context save:&error];

    
    if (error!=nil) {
        NSLog(@"eeeee %@",error);
        return NO;
    }
    
    return YES;
    
}
+(NSMutableArray*)getAllTicketsWithNSManagedObjectContext:(NSManagedObjectContext*)context{

    NSMutableArray *resultsArr=[[NSMutableArray alloc]init];
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Tickets"
                inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(ticket_id = %@)", @"1"];
//    [request setPredicate:pred];
//    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    
    if (error==nil) {
        for (Ticket *tempObj in objects) {
            
//            [tempObj setValue:@316262 forKey:stationEndId];
            [resultsArr addObject:tempObj];
            NSLog(@"N");
        }
    }
    
//    [context save:&error];
    
    
    NSLog(@"vvv");
//    
//    if ([objects count] == 0) {
//
//    } else {
//        matches = [objects objectAtIndex:0];
//        address.text = [matches valueForKey:@"address"];
//        phone.text = [matches valueForKey:@"phone"];
//        status.text = [NSString stringWithFormat:
//                       @"%d matches found", [objects count]];
//    }
    
    return resultsArr;

}








@end
