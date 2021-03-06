//
//  RightDetailWithCustomExpandedIconCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RightDetailWithCustomExpandedIconCell.h"

@interface RightDetailWithCustomExpandedIconCell()

// outlets
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;

@property (weak, nonatomic) IBOutlet UILabel* detailInfoLabel;

// properties


// methods


@end

@implementation RightDetailWithCustomExpandedIconCell


#pragma mark - Public -

- (void) fillCellWithTitle: (NSString*) titleText
                withDetail: (NSString*) detailText
{
    self.titleLabel.text      = titleText;
    self.detailInfoLabel.text = detailText;
}


@end
