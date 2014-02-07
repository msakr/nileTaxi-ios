//
//  WebServiceManagerAPI.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/9/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "WebServiceManagerAPI.h"
#import "Helpers.h"
#import "nilecodeAppDelegate.h"
#import "AlertView.h"
@implementation WebServiceManagerAPI
static NSString *BaseURL = @"http://ntaxi.e7gezly.com/wp-admin/admin-ajax.php?test_mode=1&action=";


+(BOOL)logMeInWithUserName:(NSString* )userName andPassword:(NSString *)password withErrorMessage:(NSError **)errorPtr
{
    NSString *domain = @"com.nilecode.e7gezly.ErrorDomain";

    
    if (![self isNetworkReachable]) {
        NSString *desc = NSLocalizedString(@"check your internet connection", @"");
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        
        
        *errorPtr = [NSError errorWithDomain:domain
                     
                                        code:-101
                     
                                    userInfo:userInfo];
        
        return nil;
        
    }



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
            
            [Helpers saveName:[[result objectForKey:@"response"] objectForKey:@"name"] andTokenID:[[result objectForKey:@"response"] objectForKey:@"token_id"]];
            
            
            
            
            return YES;
        }else{
            
            NSString *desc = NSLocalizedString([result objectForKey:@"error_message"], @"");
            
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
            
            
            
           *errorPtr = [NSError errorWithDomain:domain
                              
                                                 code:-101
                              
                                             userInfo:userInfo];
            return NO;
        }
        
    }
    
    
	return NO;







}
+(NSArray*)getAllSatationsWithErrorMessage:(NSError **)errorPtr{

    NSString *domain = @"com.nilecode.e7gezly.ErrorDomain";

    
    if (![self isNetworkReachable]) {
        NSString *desc = NSLocalizedString(@"check your internet connection", @"");
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        
        
        *errorPtr = [NSError errorWithDomain:domain
                     
                                        code:-101
                     
                                    userInfo:userInfo];
        
        return nil;

    }
    
    

    if ([Helpers getToken]==nil) {
        
        
        NSString *desc = NSLocalizedString(@"You Must Login", @"");
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        
        
        *errorPtr = [NSError errorWithDomain:domain
                     
                                        code:-101
                     
                                    userInfo:userInfo];

        return nil;
    }
    
    
    NSMutableArray *resultsStations;

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@get_stations&token=%@",BaseURL,[Helpers getToken]]]];
    
    [request startSynchronous];
    NSError *error = [request error];
    NSDictionary *result = nil;
    if(error == nil) {
        NSString *str = [request responseString];
        result = [str JSONValue];
        NSLog(@"%@",result);
        int code=[(NSNumber*) [result valueForKey:@"error_code"] intValue];
        
        if (code==200) {
            

            resultsStations=[result objectForKey:@"response"];
            
            
            
            return resultsStations;
        }else{
            NSString *domain = @"com.nilecode.e7gezly.ErrorDomain";
            
            NSString *desc = NSLocalizedString([result objectForKey:@"error_message"], @"");
            
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
            
            
            
            *errorPtr = [NSError errorWithDomain:domain
                         
                                            code:-101
                         
                                        userInfo:userInfo];
            return nil;
        }
        
    }
    
    
	return nil;
    
    





}

+(NSArray*)getAllMapsWithErrorMessage:(NSError **)errorPtr
{
    
    NSString *domain = @"com.nilecode.e7gezly.ErrorDomain";
    
    
    if (![self isNetworkReachable]) {
        NSString *desc = NSLocalizedString(@"check your internet connection", @"");
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        
        
        *errorPtr = [NSError errorWithDomain:domain
                     
                                        code:-101
                     
                                    userInfo:userInfo];
        
        return nil;
        
    }
    
    
    
    if ([Helpers getToken]==nil) {
        
        
        NSString *desc = NSLocalizedString(@"You Must Login", @"");
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        
        
        *errorPtr = [NSError errorWithDomain:domain
                     
                                        code:-101
                     
                                    userInfo:userInfo];
        
        return nil;
    }
    
    
    NSMutableArray *resultsMaps;
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@get_map_info&direction=0&token=%@",BaseURL,[Helpers getToken]]]];
    
    [request startSynchronous];
    NSError *error = [request error];
    NSDictionary *result = nil;
    if(error == nil) {
        NSString *str = [request responseString];
        result = [str JSONValue];
        NSLog(@"%@",result);
        int code=[(NSNumber*) [result valueForKey:@"error_code"] intValue];
        
        if (code==200) {
            
            
            resultsMaps=[result objectForKey:@"response"];
            
            
            
            return resultsMaps;
        }else{
            NSString *domain = @"com.nilecode.e7gezly.ErrorDomain";
            
            NSString *desc = NSLocalizedString([result objectForKey:@"error_message"], @"");
            
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
            
            
            
            *errorPtr = [NSError errorWithDomain:domain
                         
                                            code:-101
                         
                                        userInfo:userInfo];
            return nil;
        }
        
    }
    
    
	return nil;
    
    
    

}

+(NSArray*)gatAllNewTicketsWithSatationID:(NSString*)stationID andUsedTickets:(NSArray*)usedTickets withErrorMessage:(NSError **)errorPtr
{
    
    
    NSString *domain = @"com.nilecode.e7gezly.ErrorDomain";
    
    
    if (![self isNetworkReachable]) {
        NSString *desc = NSLocalizedString(@"check your internet connection", @"");
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        
        
        *errorPtr = [NSError errorWithDomain:domain
                     
                                        code:-101
                     
                                    userInfo:userInfo];
        
        return nil;
        
    }
    
    
    
    if ([Helpers getToken]==nil) {
        
        
        NSString *desc = NSLocalizedString(@"You Must Login", @"");
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        
        
        *errorPtr = [NSError errorWithDomain:domain
                     
                                        code:-101
                     
                                    userInfo:userInfo];
        
        return nil;
    }
    
    
    NSMutableArray *resultsTickets;
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sync_station_tickets&station_id=%@&synced_tickets=%@&token=%@",BaseURL,stationID,[usedTickets JSONRepresentation],[Helpers getToken]]]];
    
    [request startSynchronous];
    NSError *error = [request error];
    NSDictionary *result = nil;
    if(error == nil) {
        NSString *str = [request responseString];
        result = [str JSONValue];
        NSLog(@"%@",result);
        int code=[(NSNumber*) [result valueForKey:@"error_code"] intValue];
        
        if (code==200) {
            
            
            resultsTickets=[result objectForKey:@"response"];
            
            
            
            return resultsTickets;
        }else{
            NSString *domain = @"com.nilecode.e7gezly.ErrorDomain";
            
            NSString *desc = NSLocalizedString([result objectForKey:@"error_message"], @"");
            
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
            
            
            
            *errorPtr = [NSError errorWithDomain:domain
                         
                                            code:-101
                         
                                        userInfo:userInfo];
            return nil;
        }
        
    }
    
    
	return nil;
    
    
}
+(NSDictionary*)getTicketInfoWithTicketRRN:(NSString *)Ticket_id WithErrorMessage:(NSError **)errorPtr
{
    NSString *domain = @"com.nilecode.e7gezly.ErrorDomain";
    
    
    if (![self isNetworkReachable]) {
        NSString *desc = NSLocalizedString(@"check your internet connection", @"");
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        
        
        *errorPtr = [NSError errorWithDomain:domain
                     
                                        code:-101
                     
                                    userInfo:userInfo];
        
        return nil;
        
    }
    
    
    
    if ([Helpers getToken]==nil) {
        
        
        NSString *desc = NSLocalizedString(@"You Must Login", @"");
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        
        
        *errorPtr = [NSError errorWithDomain:domain
                     
                                        code:-101
                     
                                    userInfo:userInfo];
        
        return nil;
    }
    
    
    NSDictionary *resultTikcket;
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@get_ticket_info&ticket_id=%@&token=%@",BaseURL,Ticket_id,[Helpers getToken]]]];
    
    [request startSynchronous];
    NSError *error = [request error];
    NSDictionary *result = nil;
    if(error == nil) {
        NSString *str = [request responseString];
        result = [str JSONValue];
        NSLog(@"%@",result);
        int code=[(NSNumber*) [result valueForKey:@"error_code"] intValue];
        
        if (code==200) {
            
            
            resultTikcket=[result objectForKey:@"response"];
            
            
            
            return resultTikcket;
        }else{
            
            if (code==401) {
                [self logInOnTheRun];
                
            }
            NSString *domain = @"com.nilecode.e7gezly.ErrorDomain";
            
            NSString *desc = NSLocalizedString([result objectForKey:@"error_message"], @"");
            
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
            
            
            
            *errorPtr = [NSError errorWithDomain:domain
                         
                                            code:-101
                         
                                        userInfo:userInfo];
            return nil;
        }
        
    }
    
    
	return nil;
    

}

+(void)logInOnTheRun
{
    AlertView *av = [[AlertView alloc] initWithTitle:@"Login" message:@"LogIn Please"  cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"OK"]];
    
    
    av.completion = ^(BOOL cancelled, NSInteger buttonIndex) {
        if (!cancelled) {

            NSError *tempError;
            NSNumber* state=[NSNumber numberWithBool:[WebServiceManagerAPI logMeInWithUserName:[av textFieldAtIndex:0].text andPassword:[av textFieldAtIndex:1].text withErrorMessage:&tempError]];
            
            NSLog(@"1 %@", [av textFieldAtIndex:0].text);
            NSLog(@"2 %@", [av textFieldAtIndex:1].text);
            
            
            
            
            if (!state.boolValue) {
                UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:tempError.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertNO show];
                
            }else{
                nilecodeAppDelegate   *appDelegate = (nilecodeAppDelegate *)[[UIApplication sharedApplication] delegate];
                appDelegate.isLogin=YES;
                
                
                
            }

        
        }
    };
    [av setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    
    // Alert style customization
    [[av textFieldAtIndex:1] setSecureTextEntry:YES];
    [[av textFieldAtIndex:0] setPlaceholder:@"User Name"];
    [[av textFieldAtIndex:1] setPlaceholder:@"Password"];
   
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        /* Do UI work here */
        [av show];

    });
    
}




+(NSString*)getPriceWithFrom_station:(NSString*)from_station andTo_station:(NSString*)to_station andTicket_type:(NSString*)ticket_type andNumber_of_tickets:(NSString*)number_of_tickets andReservationDate:(NSString*)reservationDate andFromTime:(NSString*)fromTime andToTime:(NSString*)toTime andReturnDate:(NSString *)returnDatee WithErrorMessage:(NSError **)errorPtr
{
    NSString *domain = @"com.nilecode.e7gezly.ErrorDomain";
    
    
    if (![self isNetworkReachable]) {
        NSString *desc = NSLocalizedString(@"check your internet connection", @"");
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        
        
        *errorPtr = [NSError errorWithDomain:domain
                     
                                        code:-101
                     
                                    userInfo:userInfo];
        
        return nil;
        
    }
    
    
    
    if ([Helpers getToken]==nil) {
        
        
        NSString *desc = NSLocalizedString(@"You Must Login", @"");
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        
        
        *errorPtr = [NSError errorWithDomain:domain
                     
                                        code:-101
                     
                                    userInfo:userInfo];
        
        return nil;
    }
    
    
    NSString *resultPrice;
    

    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@get_price&from_station=%@&reservation_date=%@&to_station=%@&from_time=%@&to_time=%@&return_date=%@&number_of_tickets=%@&ticket_type=%@&token=%@",BaseURL,from_station,reservationDate,to_station,fromTime,toTime,returnDatee,number_of_tickets, ticket_type,[Helpers getToken]]]];
    
    [request startSynchronous];
    NSError *error = [request error];
    NSDictionary *result = nil;
    if(error == nil) {
        NSString *str = [request responseString];
        result = [str JSONValue];
        NSLog(@"%@",result);
        int code=[(NSNumber*) [result valueForKey:@"error_code"] intValue];
        
        if (code==200) {
            
            
            resultPrice=[[result objectForKey:@"response"] objectForKey:@"price"];
            
            
            
            return resultPrice;
        }else{
            
            if (code==401) {
                [self logInOnTheRun];
                
            }
            NSString *domain = @"com.nilecode.e7gezly.ErrorDomain";
            
            NSString *desc = NSLocalizedString([result objectForKey:@"error_message"], @"");
            
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
            
            
            
            *errorPtr = [NSError errorWithDomain:domain
                         
                                            code:-101
                         
                                        userInfo:userInfo];
            return nil;
        }
        
    }
    
    
	return nil;
    

}

+(NSDictionary*)getTimesWithFromStationID:(NSString*)from_station_id andToStationID:(NSString*)to_station_id  andReservation_date:(NSString*)reservation_date andReturn_date:(NSString*)return_date WithErrorMessage:(NSError **)errorPtr
{
    NSString *domain = @"com.nilecode.e7gezly.ErrorDomain";
    
    
    if (![self isNetworkReachable]) {
        NSString *desc = NSLocalizedString(@"check your internet connection", @"");
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        
        
        *errorPtr = [NSError errorWithDomain:domain
                     
                                        code:-101
                     
                                    userInfo:userInfo];
        
        return nil;
        
    }
    
    
    
    if ([Helpers getToken]==nil) {
        
        
        NSString *desc = NSLocalizedString(@"You Must Login", @"");
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        
        
        *errorPtr = [NSError errorWithDomain:domain
                     
                                        code:-101
                     
                                    userInfo:userInfo];
        
        return nil;
    }
    
    
    NSArray *resultTimes;
    
    ASIFormDataRequest *request =
    [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@get_times",BaseURL]]];
    
    
    [request setPostValue:from_station_id forKey:@"from_station"];
        [request setPostValue:reservation_date forKey:@"reservation_date"];
        [request setPostValue:[Helpers getToken]forKey:@"token"];
    
    if (to_station_id!=nil) {
        [request setPostValue:to_station_id forKey:@"to_station"];

    }
    if (return_date!=nil) {
        [request setPostValue:return_date forKey:@"return_date"];

    }

    
//    NSLog(@"%@",[NSString stringWithFormat:@"%@get_times&from_station=%@&reservation_date=%@&to_station=%@&return_date=%@&token=%@",BaseURL,from_station_id,reservation_date,to_station_id,return_date,[Helpers getToken]]);
    
    [request startSynchronous];
    NSError *error = [request error];
    NSDictionary *result = nil;
    if(error == nil) {
        NSString *str = [request responseString];
        result = [str JSONValue];
        NSLog(@"%@",result);
        int code=[(NSNumber*) [result valueForKey:@"error_code"] intValue];
        
        if (code==200) {
            
            
            resultTimes=[result objectForKey:@"response"];
            
            
            
            return resultTimes;
        }else{
            
            if (code==401) {
                [self logInOnTheRun];
                
            }
            NSString *domain = @"com.nilecode.e7gezly.ErrorDomain";
            
            NSString *desc = NSLocalizedString([result objectForKey:@"error_message"], @"");
            
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
            
            
            
            *errorPtr = [NSError errorWithDomain:domain
                         
                                            code:-101
                         
                                        userInfo:userInfo];
            return nil;
        }
        
    }
    
    
	return nil;
    
}

+(NSArray*)getTripsWithReservation_date:(NSString*)reservation_date WithErrorMessage:(NSError **)errorPtr
{
    NSString *domain = @"com.nilecode.e7gezly.ErrorDomain";
    
    
    if (![self isNetworkReachable]) {
        NSString *desc = NSLocalizedString(@"check your internet connection", @"");
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        
        
        *errorPtr = [NSError errorWithDomain:domain
                     
                                        code:-101
                     
                                    userInfo:userInfo];
        
        return nil;
        
    }
    
    
    
    if ([Helpers getToken]==nil) {
        
        
        NSString *desc = NSLocalizedString(@"You Must Login", @"");
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        
        
        *errorPtr = [NSError errorWithDomain:domain
                     
                                        code:-101
                     
                                    userInfo:userInfo];
        
        return nil;
    }
    
    
    NSArray *resultTrips;
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@get_trips&date=%@&token=%@",BaseURL,reservation_date,[Helpers getToken]]]];
    
    [request startSynchronous];
    NSError *error = [request error];
    NSDictionary *result = nil;
    if(error == nil) {
        NSString *str = [request responseString];
        result = [str JSONValue];
        NSLog(@"%@",result);
        int code=[(NSNumber*) [result valueForKey:@"error_code"] intValue];
        
        if (code==200) {
            
            
            resultTrips=[result objectForKey:@"response"];
            
            
            
            return resultTrips;
        }else{
            
            if (code==401) {
                [self logInOnTheRun];
                
            }
            NSString *domain = @"com.nilecode.e7gezly.ErrorDomain";
            
            NSString *desc = NSLocalizedString([result objectForKey:@"error_message"], @"");
            
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
            
            
            
            *errorPtr = [NSError errorWithDomain:domain
                         
                                            code:-101
                         
                                        userInfo:userInfo];
            return nil;
        }
        
    }
    
    
	return nil;
}

+ (BOOL)isNetworkReachable
{
	return [ASIHTTPRequest isNetworkReachable];
    
}


@end
