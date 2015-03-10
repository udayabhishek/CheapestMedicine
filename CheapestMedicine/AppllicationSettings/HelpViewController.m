
//  HelpViewController.m
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 160714.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.


#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

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
    
    self.title=@"Help Text";
    helpTextArray=[NSArray new];
    helpTextArray=@[@"AboutAutomation",@"Features",@"SearchByName",@"SearchByCategory",@"SearchByGenericName"];
    carousel.type = iCarouselTypeCoverFlow2;
    [self makeRequestForAdmob];
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 5;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    
    if (view == nil)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 185 ,640.0f ,450.0f)];
            
            
        }
        else{
            view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 85 ,320.0f ,444.0f)];
        }
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeScaleAspectFill;
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(75,85, 150.0f ,40.0f)];
        
        nameLabel.text=[NSString stringWithFormat:@"%@",[helpTextArray objectAtIndex:index]];
        nameLabel.adjustsFontSizeToFitWidth=YES;
        nameLabel.textAlignment=NSTextAlignmentCenter;
        
        [view addSubview:nameLabel];
        
        UITextView *textView;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            
            textView=[[UITextView alloc]initWithFrame:CGRectMake(60.0 ,125, 450, 450)];
            
        }
        else{
            textView=[[UITextView alloc]initWithFrame:CGRectMake(30.0 ,105, 255, 225)];
        }
       
        if (index==0) {
            
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                textView.text=@"*CheapestMedicine is for searching the Generic Drug with cheapest price.\n\n*This is a free app.Data is reviewed regularly by various pharmaciespharmacists and doctors in network and gets updated daily in the system.\n\n*It allows user to fetch the required information with easy and fast navigation.\n\n*It is the best resource and can be used by anyone whether he is a pharmacist common man physician medical student nurse and any other healthcare professionals for medicine information.\n\n*Use CheapestMedicine to search and validate cheapest generic drugs that can substitute prescribed medicine.";
            }
            else{
                textView.text=@"\tCheapestMedicine is for searching the Generic Drug with cheapest price.This is a free app.Data is reviewed regularly by various pharmaciespharmacists and doctors in network and gets updated daily in the system.It allows user to fetch the required information with easy and fast navigation.It is the best resource and can be used by anyone whether he is a pharmacist common man physician medical student nurse and any other healthcare professionals for medicine information.Use CheapestMedicine to search and validate cheapest generic drugs that can substitute prescribed medicine.";
            }
        }
        
        if (index==1) {
            textView.text=@"\n\n\t*Real time price.\n\t*Find alternative cheapest price medicines.\n\t*Search by NAME GENERIC NAME and CATEGORY of the Drugs and get the medicine in order by price.";
        }
        
        if (index==2) {
            textView.text=@"\n\n\t*User can Search Medicine by Medicine name only. \n\t*Users suppose to type medicine name in the Search Box and he  she will get the particular Medicine Name with price.\n\t*Along with this by clicking on that users can  get the all information of the particular drug.";
        }
        if (index==3) {
            textView.text=@"\n\n\t*User can Search Medicine by Generic Name of the medicine only.\n\t*Users suppose to type Generic Name in the Search Box and he  she will get the particular Generic Name with Medicine Name and Price.\n\t*Along with this by clicking on that users can  get the all information of the particular drug.";
        }
        
        if (index ==4) {
            textView.text=  @"\n\n\t*User can Search Medicine by Drug Category of the medicine only. \n\t*Users suppose to type required category in the Search Box and he  she will get one dropdown for hints of the category.  \n\t*After selection of the category user will get the related Medicine Name with price.\nAlong with this by clicking on that users can  get the all information of the particular drug.";
        }
        textView.backgroundColor=[UIColor clearColor];
        
        [view addSubview:textView];
        
        
    }
    
    return view;
    
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
    
    
    
    
    
    ///////////////////////////////////////////////////////////////////////////////////
    
}
-(void)adViewDidReceiveAd:(GADBannerView *)view
{
    
}
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"%@",[error localizedFailureReason]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
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


-(void)coroselView{
    self.view.backgroundColor=[UIColor redColor];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
