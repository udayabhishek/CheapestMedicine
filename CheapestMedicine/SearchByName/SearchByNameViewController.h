//
//  SearchByNameViewController.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 21/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchByNameRequestClass.h"
#import "MedicineSearchTableViewCell.h"
#import "NetworkChecking.h"
#import "DetailNameViewController.h"
#import "CurrencyChangeRequestClass.h"
#import "GADBannerView.h"


@interface SearchByNameViewController : UIViewController<MedicineSearchDelegate,UISearchDisplayDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CurrencyChangeDelegate,GADBannerViewDelegate>
{
    IBOutlet UIActivityIndicatorView *spinnerView;
    NetworkChecking *checkNetwork;
    IBOutlet UISearchBar *searchMedicine;
    NSMutableArray *relatedSearchArray;
    NSMutableArray *priceArray;
    NSMutableArray *mainRelatedSearchArray;
    NSMutableArray *mainPriceArray;
    NSString *strMedicine;
    NSMutableArray *medicineSearchIdArray;
    NSMutableArray *relatedSearchIdArray;
    IBOutlet UITableView *medicineSearchTableView;
    MedicineSearchTableViewCell *cell;
    int count;
    IBOutlet UISegmentedControl *searchSegment;
    NSUserDefaults *defaults;
    NSString *titleString;
   
    NSMutableArray *finalPriceArray;
    
    NSMutableArray *relatedPriceArray;
    float curr;
    GADBannerView *bannerView;
    BOOL isGoogleAd;
}
@property (nonatomic, strong)NSString *titleString;

-(IBAction)changeSegment:(id)sender;
@end
