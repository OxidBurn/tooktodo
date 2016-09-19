//
//  OSLabelWithBorder.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSLabelWithBorder.h"

@implementation OSLabelWithBorder

#pragma mark - IB Designable -

- (void) setBorderWidth: (CGFloat) borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (void) setBorderColor: (UIColor*) borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

@end
