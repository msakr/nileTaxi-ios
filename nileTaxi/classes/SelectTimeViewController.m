    //
    //  SelectTimeViewController.m
    //  nileTaxi
    //
    //  Created by mohamed sakr macBook on 2/1/14.
    //  Copyright (c) 2014 mohamed sakr. All rights reserved.
    //

    #import "SelectTimeViewController.h"
    #import "UserInfoViewController.h"
    #import "Helpers.h"
    #import "BookViewController.h"
    @interface SelectTimeViewController ()

    @end

    @implementation SelectTimeViewController

    - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
    {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
        }
        return self;
    }

    - (void)viewDidLoad
    {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        
        stations=[Helpers getStations];

        
        if (!_isForStations) {
            if (_timesArray_reservation.count<=0) {
                //        times_reservation_TabelView
                [times_reservation_TabelView setHidden:YES];
                [times_return_TabelView setHidden:YES];
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"there is no available times" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                
            }

        }else{
            if (stations.count<=0) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"there is no available Stations" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }
        
        
        
    //    if (!_isForStations) {
        
        
        
            
    //    }
        
        
        
        
        CGRect fframe=times_return_TabelView.superview.frame;
        tempRectReturn=fframe;
        tempRectReservationTabel=times_reservation_TabelView.frame;

        
        fframe.origin.y+=500;
        [times_return_TabelView.superview setFrame:fframe];
        
        
        fframe=times_reservation_TabelView.superview.frame;
        
        tempRectRservation=fframe;
        
        fframe.size.height=  nextButton.frame.origin.y-  times_reservation_TabelView.superview.frame.origin.y-times_reservation_TabelView.frame.origin.y+20;
        
        times_reservation_TabelView.superview.frame=fframe;
        
        fframe=times_reservation_TabelView.frame;
        
        fframe.origin.y-=40;
        fframe.size.height+=40;
        times_reservation_TabelView.frame=fframe;
        

        
        
        if (_isForStations) {
            UILabel *fromStationLabel=(UILabel*)[times_reservation_TabelView.superview viewWithTag:1];
            UIImageView *fromStationImage=(UIImageView*)[times_reservation_TabelView.superview viewWithTag:2];
            UILabel *ToStationLabel=(UILabel*)[times_return_TabelView.superview viewWithTag:3];
            UIImageView *ToStationImage=(UIImageView*)[times_return_TabelView.superview viewWithTag:4];
            
            
            CGRect ff=fromStationLabel.frame;
            ff.size.width-=(fromStationLabel.frame.size.width/2);
            fromStationLabel.frame=ff;
            CGRect ff2=ToStationLabel.frame;
            ff2.size.width-=(ToStationLabel.frame.size.width/2);
            ToStationLabel.frame=ff2;
            
            
            UILabel *vv=(UILabel*)[[times_reservation_TabelView superview] viewWithTag:200];
            UILabel *vv2=(UILabel*)[[times_return_TabelView superview] viewWithTag:200];
            
            
            CGRect ff3=vv.frame;
            ff3.origin.x-=80;
            ff3.size.width=fromStationImage.frame.origin.x-ff3.origin.x;
            vv.frame=ff3;
            
            
            
            CGRect ff4=vv2.frame;
            ff4.origin.x-=80;
            ff4.size.width=fromStationImage.frame.origin.x-ff4.origin.x;
            vv2.frame=ff4;
            
            
            
            
            
            
        }
        
        

    }

    - (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }
    -(void)viewWillAppear:(BOOL)animated
    {
        
        
        
        
        if (_isForStations) {
            UILabel *fromStationLabel=(UILabel*)[times_reservation_TabelView.superview viewWithTag:1];
            UIImageView *fromStationImage=(UIImageView*)[times_reservation_TabelView.superview viewWithTag:2];
            UILabel *ToStationLabel=(UILabel*)[times_return_TabelView.superview viewWithTag:3];
            UIImageView *ToStationImage=(UIImageView*)[times_return_TabelView.superview viewWithTag:4];
            
            fromStationLabel.text=@"From";
            ToStationLabel.text=@"To";
                   
            
            
            
            fromStationImage.image=[UIImage imageNamed:@"01New.png"];
            ToStationImage.image=[UIImage imageNamed:@"02New.png"];
            
        }else{
            UILabel *fromStationLabel=(UILabel*)[times_reservation_TabelView.superview viewWithTag:1];
            UIImageView *fromStationImage=(UIImageView*)[times_reservation_TabelView.superview viewWithTag:2];
            UILabel *ToStationLabel=(UILabel*)[times_return_TabelView.superview viewWithTag:3];
            UIImageView *ToStationImage=(UIImageView*)[times_return_TabelView.superview viewWithTag:4];
            
            fromStationLabel.text=@"Departure Time";
            ToStationLabel.text=@"Arrival Time";
            
            fromStationImage.image=[UIImage imageNamed:@"03New.png"];
            ToStationImage.image=[UIImage imageNamed:@"04New.png"];
            
        }
        
        
        
        
        if (!_isForStations) {
    //        CGRect fframe=times_return_TabelView.superview.frame;
    //        fframe.origin.y+=500;
    //        [times_return_TabelView.superview setFrame:fframe];
    //        [times_return_TabelView setHidden:YES];
            

    //    if (!_isRound) {
    //        
    //        
    //        [times_return_TabelView.superview setHidden:YES];
    //        [times_return_TabelView setHidden:YES];
    //    }
        
        if ([_timesArray_reservation count]<=0) {
            //diableButton
            
            [nextButton setEnabled:NO];
        }
        }else
        {

            if ([stations count]<=0) {
                //diableButton
                
                [nextButton setEnabled:NO];
            }
        }
        times_return_TabelView.backgroundColor = [UIColor whiteColor];
        times_reservation_TabelView.backgroundColor = [UIColor whiteColor];

    }

    #pragma mark - times table datasource and delegates

    -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return 66;
    }

    -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        
        
        
        if (!_isForStations) {

        if ([tableView isEqual:times_return_TabelView]) {

                return [_timesArray_return count];
        }else if ([tableView isEqual:times_reservation_TabelView]) {
            
          
                return [_timesArray_reservation count];
        }
        }else{
            return stations.count;
        }
        
        return 0;
    }

    -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        
        
        
        if ([tableView isEqual:times_return_TabelView] ) {
            ((UILabel*)[[times_return_TabelView cellForRowAtIndexPath:lastSelectedIndexTabel2] viewWithTag:100]).textColor=[UIColor blackColor];
            ((UILabel*)[[times_return_TabelView cellForRowAtIndexPath:lastSelectedIndexTabel2] viewWithTag:101]).textColor=[UIColor blackColor];
        }else{
            ((UILabel*)[[times_reservation_TabelView cellForRowAtIndexPath:lastSelectedIndexTabel11] viewWithTag:100]).textColor=[UIColor blackColor];
            ((UILabel*)[[times_reservation_TabelView cellForRowAtIndexPath:lastSelectedIndexTabel11] viewWithTag:101]).textColor=[UIColor blackColor];
        }
        
        
       
        
        

        
        if (!_isForStations) {

        UILabel *vv=(UILabel*)[[tableView superview] viewWithTag:200];
        
        
        NSDictionary *tempD;

        if ([tableView isEqual:times_return_TabelView]) {
            tempD=[_timesArray_return objectAtIndex:indexPath.row];
            
            
            ((UILabel*)[[tableView cellForRowAtIndexPath:indexPath] viewWithTag:100]).textColor=[UIColor colorWithRed:76.0/255.0 green:217.0/255.0 blue:100.0/255.0 alpha:1];
            ((UILabel*)[[tableView cellForRowAtIndexPath:indexPath] viewWithTag:101]).textColor=[UIColor colorWithRed:76.0/255.0 green:217.0/255.0 blue:100.0/255.0 alpha:1];

            

            
        }else if ([tableView isEqual:times_reservation_TabelView]) {
            tempD=[_timesArray_reservation objectAtIndex:indexPath.row];
            
            ((UILabel*)[[tableView cellForRowAtIndexPath:indexPath] viewWithTag:100]).textColor=[UIColor colorWithRed:76.0/255.0 green:217.0/255.0 blue:100.0/255.0 alpha:1];

            ((UILabel*)[[tableView cellForRowAtIndexPath:indexPath] viewWithTag:101]).textColor=[UIColor colorWithRed:76.0/255.0 green:217.0/255.0 blue:100.0/255.0 alpha:1];

            
    //        if (!_isForStations) {
    //            if (_isRound) {
                
                    //            [times_return_TabelView.superview setHidden:YES];
                    
                    
            
                       if (_isRound) {

                           [UIView beginAnimations:nil context:nil];
                           [UIView setAnimationDuration:0.2];
                           [UIView setAnimationDelay:0.0];
                           [UIView setAnimationCurve:UIViewAnimationOptionCurveEaseIn];
                           
                           
                           CGRect fframe=times_return_TabelView.superview.frame;
                           fframe.origin.y=tempRectReturn.origin.y  ;
                           [times_return_TabelView.superview setFrame:fframe];
                           

            
            fframe=times_reservation_TabelView.superview.frame;
            
            fframe.size.height=  tempRectRservation.size.height;
            
            times_reservation_TabelView.superview.frame=fframe;
                           
                           times_reservation_TabelView.frame=tempRectReservationTabel;
                           
                           [UIView commitAnimations];

                       }else{
                           
//                           [UIView beginAnimations:nil context:nil];
//                           [UIView setAnimationDuration:0.2];
//                           [UIView setAnimationDelay:0.0];
//                           [UIView setAnimationCurve:UIViewAnimationOptionCurveEaseIn];
//                           
//                           
////                           CGRect fframe=times_return_TabelView.superview.frame;
////                           fframe.origin.y=tempRectReturn.origin.y  ;
////                           [times_return_TabelView.superview setFrame:fframe];
//                           
//                           
//                           
////                           fframe=times_reservation_TabelView.superview.frame;
////                           
////                           fframe.size.height=  tempRectRservation.size.height;
////                           
////                           times_reservation_TabelView.superview.frame=fframe;
////                           
////                           times_reservation_TabelView.frame=tempRectReservationTabel;
////                           
//                           [UIView commitAnimations];

                       }

    //            }
    //        }
            
            

        }
        
        vv.text=[tempD objectForKey:@"time"];
            
            
            
        }else{
            UILabel *vv=(UILabel*)[[tableView superview] viewWithTag:200];
            
            
            NSDictionary *tempD;
            
           
                tempD=[stations objectAtIndex:indexPath.row];
           
            
            vv.text=[tempD objectForKey:@"station_name"];
            
            
            
            
            ((UILabel*)[[tableView cellForRowAtIndexPath:indexPath] viewWithTag:100]).textColor=[UIColor colorWithRed:76.0/255.0 green:217.0/255.0 blue:100.0/255.0 alpha:1];

            ((UILabel*)[[tableView cellForRowAtIndexPath:indexPath] viewWithTag:101]).textColor=[UIColor colorWithRed:76.0/255.0 green:217.0/255.0 blue:100.0/255.0 alpha:1];


            
            
            if ([tableView isEqual:times_reservation_TabelView]) {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.2];
                [UIView setAnimationDelay:0.0];
                [UIView setAnimationCurve:UIViewAnimationOptionCurveEaseIn];
                
                /////
                
                
    //            if (_isRound) {
                
                    
                
                /////
                CGRect fframe=times_return_TabelView.superview.frame;
                fframe.origin.y=tempRectReturn.origin.y  ;
                [times_return_TabelView.superview setFrame:fframe];
                
                
    //            fframe=times_reservation_TabelView.superview.frame;
    //            
    //            fframe.size.height=  tempRectRservation.size.height;
                
                
                
                times_reservation_TabelView.superview.frame=tempRectRservation;
                
                times_reservation_TabelView.frame=tempRectReservationTabel;
                

                
                
    //            times_reservation_TabelView.superview.frame=tempRectRservation;
                
    //            fframe=times_return_TabelView.frame;
    //            fframe.origin.x=0;
    //            fframe.origin.y=0;
    //            times_return_TabelView.frame=fframe;
                
                [UIView commitAnimations];
            }
           
            
            
        }
        
        if ([tableView isEqual:times_return_TabelView] ) {
            
            lastSelectedIndexTabel2=indexPath;
            LastTbleTable2=tableView;
              }else{

                  
                  lastSelectedIndexTabel11=indexPath;
                  LastTbleTable11=tableView;
        }
        
    }
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timesCell"];
        
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"timesCell"];
        }
        
        cell.backgroundColor =  [UIColor clearColor];
       
        
        
        if (!_isForStations) {

        NSDictionary *tempD;
        if ([tableView isEqual:times_return_TabelView]) {
            tempD=[_timesArray_return objectAtIndex:indexPath.row];
        }else if ([tableView isEqual:times_reservation_TabelView]) {
            tempD=[_timesArray_reservation objectAtIndex:indexPath.row];
        }
        
        ((UILabel*)[cell viewWithTag:100]).text=[tempD objectForKey:@"time"];
        
        ((UILabel*)[cell viewWithTag:101]).text=[NSString stringWithFormat:@"remain %@ from %@",[tempD objectForKey:@"remining_quota"],[tempD objectForKey:@"taxi_quota"]];

            
            ((UILabel*)[cell viewWithTag:100]).textColor=[UIColor blackColor];
            ((UILabel*)[cell viewWithTag:101]).textColor=[UIColor blackColor];
            
            
        }else{
            
            NSDictionary *tempD;
                tempD=[stations     objectAtIndex:indexPath.row];
           
            
            ((UILabel*)[cell viewWithTag:100]).text=[tempD objectForKey:@"station_name"];
            
            ((UILabel*)[cell viewWithTag:101]).text=@"";
            ((UILabel*)[cell viewWithTag:101]).hidden=YES;
            
            ((UILabel*)[cell viewWithTag:100]).textColor=[UIColor blackColor];
            ((UILabel*)[cell viewWithTag:101]).textColor=[UIColor blackColor];
            
        }
        return cell;
        
    }

    #pragma mark segue prepare

    -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
    {
        
        if ([[segue identifier] isEqualToString:@"userInfo"]) {
            
            ((UserInfoViewController*)segue.destinationViewController).allData=_allData;
            ((UserInfoViewController*)segue.destinationViewController).TripType=_TripType;

            
            
        }else if ([[segue identifier] isEqualToString:@"goBookView"])
        {
            ((BookViewController*)segue.destinationViewController).stationFrom=[stations objectAtIndex:times_reservation_TabelView.indexPathForSelectedRow.row];
            ((BookViewController*)segue.destinationViewController).stationTo=[stations objectAtIndex:times_return_TabelView.indexPathForSelectedRow.row];
            ((BookViewController*)segue.destinationViewController).TripType=_TripType;
        }
        
        
        
    }
    #pragma mark -buttons action



    - (IBAction)goNext:(id)sender {

        
        if (!_isForStations) {

        if (times_reservation_TabelView.indexPathForSelectedRow ==nil || times_reservation_TabelView.indexPathForSelectedRow.row<0 ) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"you must select Time" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            return;
        }
        
        
        if (_isRound && (times_return_TabelView.indexPathForSelectedRow ==nil || times_return_TabelView.indexPathForSelectedRow.row<0 )) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"you must select Time" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            return;
        }
        
        
        [_allData setObject:[_timesArray_reservation objectAtIndex:times_reservation_TabelView.indexPathForSelectedRow.row]  forKey:booking_reservationTime];
        
        
        if (_isRound) {
            [_allData setObject:[_timesArray_return objectAtIndex:times_return_TabelView.indexPathForSelectedRow.row]  forKey:booking_returnTime];
            
        }
        

        [self performSegueWithIdentifier:@"userInfo" sender:self];
        }else
        {
            
            if (times_reservation_TabelView.indexPathForSelectedRow ==nil || times_reservation_TabelView.indexPathForSelectedRow.row<0 ) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"you must select Station" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                return;
            }
            
            
            if ((times_return_TabelView.indexPathForSelectedRow ==nil || times_return_TabelView.indexPathForSelectedRow.row<0 )) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"you must select Station" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                return;
            }

            if (times_reservation_TabelView.indexPathForSelectedRow.row == times_return_TabelView.indexPathForSelectedRow.row ) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"source and destination station must not be the same" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                return;
            }
            
            
            [self performSegueWithIdentifier:@"goBookView" sender:self];

            
            
        }
        
    }






    @end
