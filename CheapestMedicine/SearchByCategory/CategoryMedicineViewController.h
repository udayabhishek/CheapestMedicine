//
//  CategoryMedicineViewController.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 24/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategorySearchRequestClass.h"
#import "MedicineSearchTableViewCell.h"
#import "MedicineDetailsViewController.h"
#import "NetworkChecking.h"
#import "CurrencyChangeRequestClass.h"
@interface CategoryMedicineViewController : UIViewController<CategoryMedicineSearchDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,CurrencyChangeDelegate,UIAlertViewDelegate>
{
    NSString *medicineString;
    NetworkChecking *checkNetwork;
    NSMutableArray *medicineNameArray;
    NSMutableArray *priceArray;
    MedicineSearchTableViewCell *cell;
    IBOutlet UIActivityIndicatorView *spinnerView;
    NSMutableArray *medicineIdArray;
    NSMutableArray *finalPriceArray;
    float curr;
    NSString *pageValue;
    int count;
    NSUserDefaults *defaults;
    NSString *hasnext;
}
@property (nonatomic, strong) NSString *medicineString;
@property(strong,nonatomic)IBOutlet UITableView *categoryTableView;

@end
