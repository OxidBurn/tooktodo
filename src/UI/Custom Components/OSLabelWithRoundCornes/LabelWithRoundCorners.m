//
//  LabelWithRoundCorners.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LabelWithRoundCorners.h"

@implementation LabelWithRoundCorners

#pragma mark - IB Designable -

- (void) setCornerRadius: (CGFloat) cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}

@end
