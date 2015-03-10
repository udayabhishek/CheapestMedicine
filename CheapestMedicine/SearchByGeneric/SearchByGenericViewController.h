//
//  SearchByGenericViewController.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 21/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericNameRequestClass.h"
#import "MedicineSearchTableViewCell.h"
#import "NetworkChecking.h"
#import "DetailGenericViewController.h"
#import "CurrencyChangeRequestClass.h"
#import "GADBannerView.h"
@interface SearchByGenericViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, GenericSearchDelegate, CurrencyChangeDelegate,UIAlertViewDelegate, GADBannerViewDelegate>
{
    IBOutlet UITableView *genericTableView;
    MedicineSearchTableViewCell *cell;
    NSMutableArray *relatedSearchArray;
    IBOutlet UISegmentedControl *searchSegment;
    IBOutlet UISearchBar *searchMedicine;
    NSMutableArray *priceArray;
    NSMutableArray *mainRelatedSearchArray;
    NSMutableArray *mainPriceArray;
    NSString *strMedicine;
    NetworkChecking *checkNetwork;
    IBOutlet  UIActivityIndicatorView *spinnerView;
    NSUserDefaults *defaults;
    NSString *titleString;
    
    NSMutableArray *medicineSearchIdArray;
    NSMutableArray *relatedSearchIdArray;
    float curr;
    NSMutableArray *finalPriceArray;
    NSMutableArray *relatedPriceArray;
    int count;
     GADBannerView *bannerView;
    }
@property (strong, nonatomic)NSString *titleString;
-(IBAction)changeSegment:(id)sender;

@end
