//
//  SearchByCategoryViewController.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 21/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryRequestClass.h"
#import "CategoryMedicineViewController.h"
#import "NetworkChecking.h"
@interface SearchByCategoryViewController : UIViewController<CategorySearchDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UIAlertViewDelegate>
{
    
    IBOutlet UITableView *categoryTableView;
    NetworkChecking *checkNetwork;
    IBOutlet UIActivityIndicatorView *spinnerView;
    NSMutableArray *categoryArray;
    IBOutlet UISearchBar *searchCategory;
    NSMutableArray *filteredCategoryArray;
    NSString *titleString;
}
@property (nonatomic, strong)NSString *titleString;

@end
