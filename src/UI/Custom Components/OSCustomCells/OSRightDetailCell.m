//
//  RightDetailCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSRightDetailCell.h"

@interface OSRightDetailCell()

// properties
@property (weak, nonatomic) IBOutlet UILabel* detailLabel;

@property (weak, nonatomic) IBOutlet UILabel* titleLabel;

// methods


@end

@implementation OSRightDetailCell

#pragma mark - Public -

- (void) fillCellWithTitle: (NSString*) titleText
                withDetail: (NSString*) detailText
          detailIsSelected: (BOOL)      isSelected
{
    self.titleLabel.text  = titleText;
    self.detailLabel.text = detailText;
    
    if ( isSelected == NO)
    {
        self.detailLabel.textColor = [UIColor colorWithRed: 166.0/256
                                                     green: 185.0/256
                                                      blue: 185.0/256
                                                     alpha: 1.f];
    }
}

@end
