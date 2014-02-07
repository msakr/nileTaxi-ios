//
//  WebServiceManagerAPI.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/9/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASIDownloadCache.h"
#import "JSON.h"
#import "Ticket.h"

@interface WebServiceManagerAPI : NSObject



+(BOOL)logMeInWithUserName:(NSString* )userName andPassword:(NSString *)password withErrorMessage:(NSError **)errorPtr;
+(NSArray*)getAllSatationsWithErrorMessage:(NSError **)errorPtr;
+(NSArray*)gatAllNewTicketsWithSatationID:(NSString*)stationID andUsedTickets:(NSArray*)usedTickets withErrorMessage:(NSError **)errorPtr;;
+(NSArray*)getAllMapsWithErrorMessage:(NSError **)errorPtr;
+(NSDictionary*)getTicketInfoWithTicketRRN:(NSString *)Ticket_id WithErrorMessage:(NSError **)errorPtr;
+(NSString*)getPriceWithFrom_station:(NSString*)from_station andTo_station:(NSString*)to_station andTicket_type:(NSString*)ticket_type andNumber_of_tickets:(NSString*)number_of_tickets andReservationDate:(NSString*)reservationDate andFromTime:(NSString*)fromTime andToTime:(NSString*)toTime andReturnDate:(NSString *)returnDatee WithErrorMessage:(NSError **)errorPtr;


+(NSDictionary*)getTimesWithFromStationID:(NSString*)from_station_id andToStationID:(NSString*)to_station_id  andReservation_date:(NSString*)reservation_date andReturn_date:(NSString*)return_date WithErrorMessage:(NSError **)errorPtr;

//+(NSInteger)getPriceWithFrom_station:(NSString*)from_station andTo_station:(NSString*)to_station andTicket_type:(NSString*)ticket_type 


+(NSArray*)getTripsWithReservation_date:(NSString*)reservation_date WithErrorMessage:(NSError **)errorPtr;


@end
