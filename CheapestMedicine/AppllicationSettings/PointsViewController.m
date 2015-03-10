//
//  PointsViewController.m
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 03/07/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import "PointsViewController.h"

@interface PointsViewController ()

@end

@implementation PointsViewController

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
    // Do any additional setup after loading the view from its nib.
    
    pointsLabel.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"Count"];
    [self makeRequestForAdmob];

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

- (void)adViewWillLeaveApplication:(GADBannerView *)adView{
    int i = (int)[[[NSUserDefaults standardUserDefaults] valueForKey:@"Count"] integerValue];
  
    if (i<99 ) {
        i=i+2;
        NSString *strCount=[NSString stringWithFormat:@"%i",i];
        [[NSUserDefaults standardUserDefaults]setObject:strCount forKey:@"Count"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Congratulations your points is increased by 2" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag=6;
        [alert show];
        
    }
    else{
        
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ((buttonIndex==0)&&(alertView.tag==6)) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
