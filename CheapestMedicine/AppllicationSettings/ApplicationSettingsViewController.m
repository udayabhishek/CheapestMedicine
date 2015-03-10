//
//  ApplicationSettingsViewController.m
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 24/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import "ApplicationSettingsViewController.h"

@interface ApplicationSettingsViewController ()

@end

@implementation ApplicationSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)tapGeturesForkeyboardReturn
{
    UITapGestureRecognizer *gestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:gestureRecognizer];
    
}
-(void)hideKeyboard{
    currencyView.hidden=YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"App Settings";
    checkNetwork=[[NetworkChecking alloc]init];
    [self tapGeturesForkeyboardReturn];
    currencyArray=[NSArray new];
    selectedIndexArray=[[NSMutableArray alloc] initWithCapacity:1];
    currencyArray=@[@"INR",@"PHP",@"EUR",@"USD"];
    currencyView.hidden=YES;
    [self makeRequestForAdmob];
    
    GADRequest *request = [GADRequest request];
    
    [request tagForChildDirectedTreatment:YES];
    request.testDevices = [NSArray arrayWithObjects:
                          GAD_SIMULATOR_ID,
                           nil];
    
}

-(IBAction)actionForShare:(id)sender{
     currencyView.hidden=YES;
    spinnerView.hidden=NO;
    if (![checkNetwork reachable])
    {
         UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:@"Unable to reach the network"
                              delegate:nil
                              cancelButtonTitle:@"Dismiss"
                              otherButtonTitles:nil, nil];
        [alert show];
        spinnerView.hidden=YES;
    }
    else{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Facebook" otherButtonTitles:@"Twitter",@"Email",@"SMS", nil];
   

         [action showInView:self.view];
    }
    
}
-(IBAction)actionForPointsCount:(id)sender{
     currencyView.hidden=YES;
    PointsViewController *points;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        points=[[PointsViewController alloc]initWithNibName:@"PointsViewController_iPad" bundle:nil];
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (IS_IPHONE_5){
            points=[[PointsViewController alloc]initWithNibName:@"PointsViewController" bundle:nil];
            
        }
        else{
            points=[[PointsViewController alloc]initWithNibName:@"PointsViewController_iPhone" bundle:nil];
            
        }
    }
    [self.navigationController pushViewController:points animated:YES];
    
}


-(IBAction)actionForCurrencyChange:(id)sender
{
    currencyView.hidden=NO;

}
-(IBAction)actionForHelpText:(id)sender
{
     currencyView.hidden=YES;
    HelpViewController *help;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        help=[[HelpViewController alloc]initWithNibName:@"HelpViewController_iPad" bundle:nil];
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (IS_IPHONE_5){
            help=[[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:nil];
            
        }
        else{
            help=[[HelpViewController alloc]initWithNibName:@"HelpViewController_iPhone" bundle:nil];
            
        }
    }
    [self.navigationController pushViewController:help animated:YES];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"Facebook"]) {
      
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController *controller=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [controller  setInitialText:@"Nice app to check for medicine"];
            [controller addImage:[UIImage imageNamed:@"Icon-76@2x"]];
            [self presentViewController:controller animated:YES completion:nil];
        }
        else{
            
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle:@"No Account is found" message:@"Please go to setting to set your facebook account" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorAlert show];
            
            
        }
    }
    
    
    if ([buttonTitle isEqualToString:@"Twitter"]) {

        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
            SLComposeViewController *twitter=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [twitter setInitialText:@"Nice app to check for medicine"];
            [twitter addImage:[UIImage imageNamed:@"Icon-76@2x"]];
            [self presentViewController:twitter animated:YES completion:nil];
        }
        else{
            
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle:@"No Account is found" message:@"Please go to setting to set your Twitter account" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorAlert show];
            
            
        }
        
    }
    if ([buttonTitle isEqualToString:@"Email"]) {
            if(![MFMailComposeViewController canSendMail])
            {
                UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Configure gmail account in settings page" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [warningAlert show];
            }
            else {
          mailComposer = [[MFMailComposeViewController alloc]init];
            mailComposer.mailComposeDelegate = self;
        [mailComposer setSubject:@"Cheapest Medicine By Anshtech"];
        [mailComposer setMessageBody:@"Nice app to check for medicine" isHTML:NO];
            
            [self presentViewController:mailComposer animated:YES completion:nil];
        }
        
    }
    
    
    if ([buttonTitle isEqualToString:@"SMS"]) {
        
        
        //<<** Action the Message Sending **>>//
        if(![MFMessageComposeViewController canSendText]) {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
          
        }
        else{
        
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        messageController.messageComposeDelegate = self;
        
        [messageController setBody:@"Nice app to know about medicines"];
        
        // Present message view controller on screen
        [self presentViewController:messageController animated:YES completion:nil];
    }
    }
    
}

#pragma MailComposer Delegate

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result) {
        NSLog(@"Result : %d",result);
    }
    if (error) {
        NSLog(@"Error : %@",error);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma MFMessageComposer Delegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
	
    switch (result)
	{
		case MessageComposeResultCancelled:
            
            NSLog(@"Result : %d",result);
            			break;
		case MessageComposeResultSent:
            
            NSLog(@"Result : %d",result);
            
			break;
		case MessageComposeResultFailed:
            
            NSLog(@"Result : %d",result);
            
            break;
		default:
            
            NSLog(@"Result : %d",result);
            
			break;
	}
	[self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
  }
#pragma mark - UIPickerVieDelegateMethods


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return currencyArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [currencyArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    currenecyString=[currencyArray objectAtIndex:row];
    [[NSUserDefaults standardUserDefaults] setObject:currenecyString forKey:@"currency"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    currencyView.hidden=YES;
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Selected currency type"
                                                 message:currenecyString
                                                delegate:self
                                       cancelButtonTitle:@"Okay"
                                       otherButtonTitles:nil, nil];
    [alert show];
}

-(void)makeRequestForAdmob{
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        bannerView = [[GADBannerView alloc]
                      
                      initWithFrame:CGRectMake(10.0,
                                               
                                               self.view.frame.size.height -
                                               
                                               GAD_SIZE_728x90.height,
                                               
                                               GAD_SIZE_728x90.width,
                                               
                                               GAD_SIZE_728x90.height)];//Set Position
        
    }
    
    else{
        
        bannerView = [[GADBannerView alloc]
                      
                      initWithFrame:CGRectMake(0.0,
                                               
                                               self.view.frame.size.height -
                                               
                                               GAD_SIZE_320x50.height,
                                               
                                               GAD_SIZE_320x50.width,
                                               
                                               GAD_SIZE_320x50.height)];//Set Position
        
    }
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    
    bannerView.adUnitID = ADMOB_KEY;//Call your id
    bannerView.delegate=self;
    
    
    // Let the runtime know which UIViewController to restore after taking
    
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView.rootViewController = self;

    [self.view addSubview:bannerView];//Your attempt to add bannerview
    
    
    
    // Initiate a generic request to load it with an ad.
    
    [bannerView loadRequest:[GADRequest request]];
}
-(void)adViewDidReceiveAd:(GADBannerView *)view
{
   
}
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error{
    
    
    NSLog(@"%@",[error localizedFailureReason]);
    
    
}
- (void)adViewWillLeaveApplication:(GADBannerView *)adView{
    int i= (int)[[[NSUserDefaults standardUserDefaults] valueForKey:@"Count"] integerValue];
   
    if (i<99 ) {
        i=i+2;
        NSString *strCount=[NSString stringWithFormat:@"%i",i];
        [[NSUserDefaults standardUserDefaults]setObject:strCount forKey:@"Count"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Congratulations your points is increased by 2" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else{
        
        
        
    }


}
@end
