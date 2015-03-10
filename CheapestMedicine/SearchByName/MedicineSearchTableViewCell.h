//
//  MedicineSearchTableViewCell.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 21/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicineSearchTableViewCell : UITableViewCell
{
}

@property (nonatomic, strong) IBOutlet UILabel *relatedSearch;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;
@property (nonatomic, strong) IBOutlet UIImageView *priceImageView;
@end
