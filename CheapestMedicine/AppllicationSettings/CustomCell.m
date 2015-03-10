//
//  CustomCell.m
//  TableViewSelection
//
//  Created by dsp on 18/06/13.
//  Copyright (c) 2013 Enstrapp IT Solutions. All rights reserved.
// 

#import "CustomCell.h"

@implementation CustomCell
@synthesize isSelected;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        UIImageView *radioImage = [[UIImageView alloc] initWithFrame:CGRectMake(70,8, 30, 30)];
        [radioImage setTag:1];
        [radioImage setImage:[UIImage imageNamed:@"ticknone.png"]];
        [self.contentView addSubview:radioImage];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

   
}
-(void)setCellContent:(BOOL)selected
{
    if (selected) {
        [(UIImageView*)[self.contentView viewWithTag:1] setImage:[UIImage imageNamed:@"tick-yes.png"]];
    }
    else{
        [(UIImageView*)[self.contentView viewWithTag:1] setImage:[UIImage imageNamed:@"ticknone.png"]];

    }
}
@end
