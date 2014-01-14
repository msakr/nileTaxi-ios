//
//  nilecodeViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/9/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "nilecodeViewController.h"
#import "DBManager.h"
#import "Ticket.h"
#import "nilecodeAppDelegate.h"


@interface nilecodeViewController ()

@end

@implementation nilecodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    nilecodeAppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;

    
    NSDate *datee=[NSDate date];
    
//    Ticket *t=[[Ticket alloc]initWithTicket_id:@"1" andDate:datee andTime:@"123" andStationStartId:@"11" andStationEndId:@"12" andTicketType:@"1" andReturnDate:datee andReturnTime:@"456"];
//    Ticket *t2=[[Ticket alloc]initWithTicket_id:@"11" andDate:datee andTime:@"1123" andStationStartId:@"111" andStationEndId:@"112" andTicketType:@"11" andReturnDate:datee andReturnTime:@"1456"];
//    
//    
//        Ticket *t3=[[Ticket alloc]initWithTicket_id:@"21" andDate:datee andTime:@"2123" andStationStartId:@"211" andStationEndId:@"212" andTicketType:@"21" andReturnDate:datee andReturnTime:@"2456"];
//    [DBManager addTicketToDB:t2 withNSManagedObjectContext:self.managedObjectContext];
//    [DBManager addTicketToDB:t3 withNSManagedObjectContext:self.managedObjectContext];

    
    
    
    [DBManager addTicketToDBWithTicket_id:@123 andDate:[NSDate date] andTime:@"1" andStationStartId:@11 andStationEndId:@12 andTicketType:@3 andReturnDate:[NSDate date] andReturnTime:@"33" withNSManagedObjectContext:self.managedObjectContext];
    
    NSMutableArray *rr=[DBManager getAllTicketsWithNSManagedObjectContext:self.managedObjectContext];
    NSLog(@"aaaa %i",rr.count)  ;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
