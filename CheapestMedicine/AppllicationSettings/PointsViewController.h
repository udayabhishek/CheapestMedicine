//
//  PointsViewController.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 03/07/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"
#import "BaseUrl.h"
@interface PointsViewController : UIViewController<GADBannerViewDelegate,UIAlertViewDelegate>
{
    
    IBOutlet UILabel *pointsLabel;
    GADBannerView *bannerView;
}
@end
