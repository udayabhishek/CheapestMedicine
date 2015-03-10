//
//  MedicineDetailsViewController.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 25/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewMedicineDetailsRequestClass.h"
#import "NetworkChecking.h"

@interface MedicineDetailsViewController : UIViewController<MedicineDetailsSearchDelegate,UITextViewDelegate,UIAlertViewDelegate>
{
    NSString *medicineIdString;
    NSString *medicineNameString;
    NetworkChecking *checkNetwork;
    NSString *categoryString;
    NSString *packingString;
    NSString *sideEffectsString;
    NSString *descriptionString;
    NSString *contentsString;
    
    IBOutlet UIActivityIndicatorView *spinnerView;
    IBOutlet UITableView *detailedTableView;
}
@property (nonatomic, strong)NSString *medicineIdString;
@end
