//
//  MenuProjectCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "MenuProjectCell.h"

@interface MenuProjectCell()

// properties

@property (weak, nonatomic) IBOutlet UILabel* titleLabel;

@property (weak, nonatomic) IBOutlet UILabel* descriptionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *selectedStateImage;
@property (weak, nonatomic) IBOutlet UILabel *expiredTasksCount;

// methods


@end

@implementation MenuProjectCell

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    self.expiredTasksCount.clipsToBounds      = YES;
    self.expiredTasksCount.layer.cornerRadius = 11;
}

#pragma mark - Public methods -

- (void) fillInfo: (ProjectInfo*) info
{
    self.titleLabel.text           = info.title;
    self.descriptionLabel.text     = [NSString stringWithFormat: @"%@ %@ %@", (info.street) ? info.street : @"", (info.building) ? info.building : @"", (info.apartment) ? info.apartment : @""];
    
    // If used iPhone need to show selected checkmark image
    // in iPad case: fill background with lighter color
    if (IS_PHONE )
    {
        self.selectedStateImage.hidden = !info.isSelected.boolValue;
    }
    
    if ( info.isSelected.boolValue )
    {
        self.contentView.backgroundColor = [UIColor colorWithRed: 0.20 green: 0.25 blue: 0.31 alpha: 1.00];
    }
    else
    {
        self.contentView.backgroundColor = [UIColor colorWithRed:0.15 green:0.18 blue:0.22 alpha:1.00];
    }
}

@end
