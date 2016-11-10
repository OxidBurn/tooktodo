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
{
    self.titleLabel.text        = titleText;
    self.detailLabel.text       = detailText;
    self.userInteractionEnabled = YES;
    self.accessoryType          = UITableViewCellAccessoryDisclosureIndicator;
}

@end
