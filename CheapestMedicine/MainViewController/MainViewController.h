//
//  MainViewController.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 21/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchByCategoryViewController.h"
#import "SearchByGenericViewController.h"
#import "SearchByNameViewController.h"
#import "ApplicationSettingsViewController.h"
#import "NetworkChecking.h"
#import "BaseUrl.h"



@interface MainViewController : UIViewController
{
    
    NetworkChecking *checkNetwork;
    IBOutlet UIActivityIndicatorView *spinnerView;
   
        NSArray *categoryArray;
}
-(IBAction)actionForSearchByCategory:(id)sender;
-(IBAction)actionForSearchByGeneric:(id)sender;
-(IBAction)actionForSearchByName:(id)sender;
-(IBAction)actionForAppicationSetting:(id)sender;


 @end
