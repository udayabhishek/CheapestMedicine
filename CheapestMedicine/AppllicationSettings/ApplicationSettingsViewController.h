//
//  ApplicationSettingsViewController.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 24/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import "NetworkChecking.h"
#import "BaseUrl.h"
#import "PointsViewController.h"
#import "HelpViewController.h"
#import "CustomCell.h"

#import "GADBannerView.h"

@interface ApplicationSettingsViewController : UIViewController<UIActionSheetDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,UIGestureRecognizerDelegate,GADBannerViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
   IBOutlet UIPickerView *currencyPickerView;
    NetworkChecking *checkNetwork;
     MFMailComposeViewController *mailComposer;
    UIActivityIndicatorView *spinnerView;
    NSArray *currencyArray;
    BOOL cellSelected;
    NSString *currenecyString;
    UITableViewCell *cell;
    NSMutableArray *selectedIndexArray; //capacity should be 1 always
    int *curr;
    GADBannerView *bannerView;
    IBOutlet UIView *currencyView;
}

-(IBAction)actionForShare:(id)sender;
-(IBAction)actionForPointsCount:(id)sender;
-(IBAction)actionForCurrencyChange:(id)sender;
-(IBAction)actionForHelpText:(id)sender;

@end
