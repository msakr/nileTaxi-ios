//
//  WebServiceManagerAPI.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/9/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "WebServiceManagerAPI.h"

@implementation WebServiceManagerAPI
static NSString *BaseURL = @"http://ntaxi.e7gezly.com/wp-admin/admin-ajax.php?action=";


+(BOOL)logMeInWithUserName:(NSString* )userName andPassword:(NSString *)password
{


    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@get_auth_token",BaseURL]]];
    [request setPostValue:userName forKey:@"username"];
    [request setPostValue:password  forKey:@"password"];
   
    [request startSynchronous];
    NSError *error = [request error];
    NSDictionary *result = nil;
    if(error == nil) {
        NSString *str = [request responseString];
        result = [str JSONValue];
        NSLog(@"%@",result);
        int code=[(NSNumber*) [result valueForKey:@"error_code"] intValue];
        
        if (code==200) {
            return YES;
        }else{
            return NO;
        }
        
    }
    
    
	return NO;







}
+(NSArray*)getAllSatations
{
    return nil;
}
+(NSArray*)gatAllNewTicketsWithSatationID:(NSString*)stationID andUsedTickets:(NSArray*)usedTickets
{
    return nil;
}




@end
