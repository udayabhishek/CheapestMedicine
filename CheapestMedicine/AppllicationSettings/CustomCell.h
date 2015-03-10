//
//  CustomCell.h
//  TableViewSelection
//
//  Created by dsp on 18/06/13.
//  Copyright (c) 2013 Enstrapp IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
{
    BOOL isSelected;
}
@property(nonatomic)BOOL isSelected;
-(void)setCellContent:(BOOL)selected;
@end
