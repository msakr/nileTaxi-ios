//
//  Helpers.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/22/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helpers : NSObject


+(void)logOutUser;
+(void)addStationS:(NSArray *)stations;
+(void)addSelectedStation:(NSDictionary *)station;
+(NSArray*)getStations;
+(NSDictionary*)getSelectedStation;
+(NSString*)getSelectedStationID;
+(NSString *)getName;
+(NSString *)getToken;
+(void)saveName:(NSString *)name andTokenID:(NSString*)tokenID;
@end
