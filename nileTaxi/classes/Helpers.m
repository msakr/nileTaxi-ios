//
//  Helpers.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/22/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "Helpers.h"

@implementation Helpers


+(void)saveName:(NSString *)name andTokenID:(NSString*)tokenID{

NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
[defaults setObject:tokenID forKey:@"token_id"];
[defaults setObject:name  forKey:@"name"];

[defaults synchronize];
}


+(NSString *)getName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return    [defaults objectForKey:@"name"];
 
}
+(NSString *)getToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSLog(@"%@",[defaults objectForKey:@"token_id"]);
    return    [defaults objectForKey:@"token_id"];

}
+(void)logOutUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"token_id"];
    [defaults removeObjectForKey:@"name"];
    [defaults removeObjectForKey:@"selectedStation"];
    
    
    [defaults synchronize];
}
+(void)addStationS:(NSArray *)stations{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:stations forKey:@"Stations"];
    
    
    [defaults synchronize];
}
+(NSArray*)getStations
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return    [defaults objectForKey:@"Stations"];

}

+(void)addSelectedStation:(NSDictionary *)station
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:station forKey:@"selectedStation"];
    
    
    [defaults synchronize];
}
+(NSDictionary*)getSelectedStation{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return    [defaults objectForKey:@"selectedStation"];

}

+(NSString*)getSelectedStationID
{
    if ([self getSelectedStation]) {
        return [[self getSelectedStation]objectForKey:@"station_id"];

    }else{
        return nil;
    }
}
+(void)saveLastUpdatedHomeScreen:(NSString*)lastUpdated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:lastUpdated forKey:@"lastUpdatedHome"];
    
    
    [defaults synchronize];
}
+(NSString*)getLastUpdatedHomeScreen
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return    [defaults objectForKey:@"lastUpdatedHome"];

}




@end
