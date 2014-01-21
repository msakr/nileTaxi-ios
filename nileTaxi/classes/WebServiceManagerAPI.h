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

@interface WebServiceManagerAPI : NSObject



+(BOOL)logMeInWithUserName:(NSString* )userName andPassword:(NSString *)password;
+(NSArray*)getAllSatations;
+(NSArray*)gatAllNewTicketsWithSatationID:(NSString*)stationID andUsedTickets:(NSArray*)usedTickets;
@end
