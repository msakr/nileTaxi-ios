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







+(BOOL)addTicketToDBWithT_email:(NSString*)t_email andT_from_name:(NSString*)t_from_name andt_idd:(NSString*)t_idd andt_isUsed:(NSNumber *)t_isUsed andt_mobile:(NSString *)t_mobile andt_name:(NSString*)t_name andt_num_tickets:(NSString *)t_num_tickets andt_rrn:(NSString*)t_rrn andt_ticket_type:(NSString*)t_ticket_type  andt_to_name:(NSString*)t_to_name andt_trans_date:(NSString*)t_trans_date andt_trans_time:(NSString* )t_trans_time withNSManagedObjectContext:(NSManagedObjectContext*)context withErrorMessage:(NSError *)errorPtr;

+(NSMutableArray*)getAllTicketsWithNSManagedObjectContext:(NSManagedObjectContext*)context withErrorMessage:(NSError *)errorPtr;
+(Ticket*)getTicketWithRRN:(NSString*)t_rrn WithNSManagedObjectContext:(NSManagedObjectContext*)context withErrorMessage:(NSError *)errorPtr;
+(NSMutableArray*)getAllUsedTicketsWithNSManagedObjectContext:(NSManagedObjectContext*)context withErrorMessage:(NSError *)errorPtr;

+(BOOL)deleteAllTicketsWithNSManagedObjectContext:(NSManagedObjectContext*)context withErrorMessage:(NSError *)errorPtr;

@end
