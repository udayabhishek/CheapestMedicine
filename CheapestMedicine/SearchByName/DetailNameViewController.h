//
//  DetailNameViewController.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 04/07/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewMedicineDetailsRequestClass.h"
#import "NetworkChecking.h"
@interface DetailNameViewController : UIViewController<MedicineDetailsSearchDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    
    NSString *medicineIdString;
    NSString *medicineNameString;
    NSString *categoryString;
    NSString *packingString;
    NSString *sideEffectsString;
    NSString *descriptionString;
    NSString *contentsString;
    NSString *sourceNameString;
    IBOutlet UITableView *nameTableView;
    
    IBOutlet UIActivityIndicatorView *spinnerView;
    NetworkChecking *checkNetwork;
    
}
@property (nonatomic, strong) NSString *medicineIdString;
@end
