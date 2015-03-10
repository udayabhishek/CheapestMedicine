//
//  HelpViewController.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 16/07/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "DFPInterstitial.h"
#import "BaseUrl.h"
#import "GADBannerView.h"
@interface HelpViewController : UIViewController<iCarouselDataSource,iCarouselDataSource,UITextViewDelegate,GADBannerViewDelegate>
{
    IBOutlet iCarousel *carousel;
    GADBannerView *bannerView;
    UILabel *nameLabel;
    UITextView *descriptionTextview;
    NSArray *helpTextArray;
    UIImageView *userImageView;
    NSMutableArray *textArray;
}
@end
