//
//  DetailGenericViewController.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 09/07/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewMedicineDetailsRequestClass.h"
#import "NetworkChecking.h"
@interface DetailGenericViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MedicineDetailsSearchDelegate,UITextViewDelegate,UIAlertViewDelegate>
{
    
    NSString *medicineIdString;
    
    NSString *medicineNameString;
    NetworkChecking *checkNetwork;
    NSString *categoryString;
    NSString *packingString;
    NSString *sideEffectsString;
    NSString *descriptionString;
    NSString *contentsString;
    IBOutlet UITableView *genericTableView;
    IBOutlet UIActivityIndicatorView *spinnerView;
}

@property (nonatomic, strong)NSString *medicineIdString;
@end
