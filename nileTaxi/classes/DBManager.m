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

+(BOOL)addTicketToDBWithT_email:(NSString*)t_email andT_from_name:(NSString*)t_from_name andt_idd:(NSString*)t_idd andt_isUsed:(NSNumber *)t_isUsed andt_mobile:(NSString *)t_mobile andt_name:(NSString*)t_name andt_num_tickets:(NSString *)t_num_tickets andt_rrn:(NSString*)t_rrn andt_ticket_type:(NSString*)t_ticket_type  andt_to_name:(NSString*)t_to_name andt_trans_date:(NSString*)t_trans_date andt_trans_time:(NSString* )t_trans_time withNSManagedObjectContext:(NSManagedObjectContext*)context withErrorMessage:(NSError *)errorPtr{

    
    Ticket   *newContact;
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Tickets"
                  inManagedObjectContext:context];
    
    newContact.email=t_email;
    newContact.from_name=t_from_name;
    newContact.idd=t_idd;
    newContact.isUsed=[NSNumber numberWithBool:NO];
    newContact.mobile=t_mobile;
    newContact.name=t_name;
    newContact.num_tickets=t_num_tickets;
    newContact.rrn=t_rrn;
    newContact.ticket_type=t_ticket_type;
    newContact.to_name=t_to_name;
    newContact.trans_date=t_trans_date;
    newContact.trans_time=t_trans_time;

//    [newContact setValue:[NSNumber numberWithInt:ticket.ticket_id.intValue] forKey:ticketID];
//    [newContact setValue:[NSNumber numberWithInt:ticket.ticket_type.intValue] forKey:ticketType];
//    [newContact setValue:ticket.date forKey:dateOfTrip];
//    [newContact setValue:ticket.time forKey:timeOfTrip];
    
//    [newContact setValue:[NSNumber numberWithInt:ticket.station_start_id.intValue] forKey:stationStartId];
//    [newContact setValue:[NSNumber numberWithInt:ticket.station_end_id.intValue] forKey:stationEndId];
//    [newContact setValue:ticket.return_date forKey:returnDate];
//    [newContact setValue:ticket.return_time forKey:returnTime];
//    [newContact setValue:NO forKey:isUsed];

    
    
//    NSError *error;
    [context save:&errorPtr];

    
    if (errorPtr!=nil) {
        NSLog(@"eeeee %@",errorPtr.description);
        return NO;
    }
    
    return YES;
    
}


+(NSMutableArray*)getAllUsedTicketsWithNSManagedObjectContext:(NSManagedObjectContext*)context withErrorMessage:(NSError *)errorPtr
{
    NSMutableArray *resultsArr=[[NSMutableArray alloc]init];
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Tickets"
                inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(isUsed = %@)", @1];
   [request setPredicate:pred];
    //    NSManagedObject *matches = nil;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&errorPtr];
    
    
    if (errorPtr==nil) {
        for (Ticket *tempObj in objects) {
            

            [resultsArr addObject:tempObj.rrn];

            NSLog(@"aaa %@",tempObj.isUsed);
        }
    }
    

    
    

    
    
    return resultsArr;

}

+(NSMutableArray*)getAllTicketsWithNSManagedObjectContext:(NSManagedObjectContext*)context withErrorMessage:(NSError *)errorPtr{

    NSMutableArray *resultsArr=[[NSMutableArray alloc]init];
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Tickets"
                inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(ticket_id = %@)", @"1"];
//    [request setPredicate:pred];
//    NSManagedObject *matches = nil;
//    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&errorPtr];
    
    
    if (errorPtr==nil) {
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

+(Ticket*)getTicketWithRRN:(NSString*)t_rrn WithNSManagedObjectContext:(NSManagedObjectContext*)context withErrorMessage:(NSError *)errorPtr{
    
    
    Ticket *resultTicket=nil;
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Tickets"
                inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(rrn = %@)", t_rrn];
    [request setPredicate:pred];
    //    NSManagedObject *matches = nil;
    //    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&errorPtr];
    
    
    if (errorPtr==nil) {
        
        if (objects!=nil &&objects.count>0) {
            resultTicket=[objects objectAtIndex:0];
        }
        
       
        
        
    }
    
    
    
    
    
    return resultTicket;
    
}



+(BOOL)deleteAllTicketsWithNSManagedObjectContext:(NSManagedObjectContext*)context withErrorMessage:(NSError *)errorPtr{
    NSFetchRequest * allTickets = [[NSFetchRequest alloc] init];
    [allTickets setEntity:[NSEntityDescription entityForName:@"Tickets" inManagedObjectContext:context]];
    [allTickets setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSArray * tikcets = [context executeFetchRequest:allTickets error:&errorPtr];

    
    if (errorPtr==nil) {
//        return YES;
    }else{
        return NO;
    }
    
    for (NSManagedObject * tickett in tikcets) {
        [context deleteObject:tickett];
    }
    [context save:&errorPtr];
    
    if (errorPtr==nil) {
        return YES;
    }else{
    return NO;
    }
}


@end
