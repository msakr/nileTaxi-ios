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
+(NSString*)getPriceWithFrom_station:(NSString*)from_station andTo_station:(NSString*)to_station andTicket_type:(NSString*)ticket_type andNumber_of_tickets:(NSString*)number_of_tickets andReservationDate:(NSString*)reservationDate andFromTime:(NSString*)fromTime andToTime:(NSString*)toTime andReturnDate:(NSString *)returnDatee andTripsJson:(NSString*)tripsJson WithErrorMessage:(NSError **)errorPtr;

+(NSDictionary*)getTimesWithFromStationID:(NSString*)from_station_id andToStationID:(NSString*)to_station_id  andReservation_date:(NSString*)reservation_date andReturn_date:(NSString*)return_date WithErrorMessage:(NSError **)errorPtr;

//+(NSInteger)getPriceWithFrom_station:(NSString*)from_station andTo_station:(NSString*)to_station andTicket_type:(NSString*)ticket_type 


+(NSArray*)getTripsWithReservation_date:(NSString*)reservation_date WithErrorMessage:(NSError **)errorPtr;



+(NSDictionary*)bookExpressTicketWithReservation_method:(NSString*)reservation_method  andNumber_of_tickets:(NSString*)number_of_tickets andReservation_date:(NSString*)reservation_date andMobile:(NSString*)mobile andName:(NSString*)name andEmail:(NSString*)email andFromStationId:(NSString*)fromStationId andToStationId:(NSString*)tostationId andReservationTimeID:(NSString*)reservation_time_id andReturnTimeId:(NSString*)return_time_id andTicketType:(NSString*)ticketTypee WithErrorMessage:(NSError **)errorPtr;


+(NSDictionary*)bookOnCallTicketWithReservation_method:(NSString*)reservation_method  andNumber_of_tickets:(NSString*)number_of_tickets andReservation_date:(NSString*)reservation_date andMobile:(NSString*)mobile andName:(NSString*)name andEmail:(NSString*)email andFromStationId:(NSString*)fromStationId andToStationId:(NSString*)tostationId andTicketType:(NSString*)ticketTypee WithErrorMessage:(NSError **)errorPtr;




@end
