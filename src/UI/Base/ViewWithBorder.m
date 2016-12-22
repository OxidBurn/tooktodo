//
//  ViewWithBorder.m
//  TookTODO
//
//  Created by Nikolay Chaban on 12/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ViewWithBorder.h"

IB_DESIGNABLE

@interface ViewWithBorder()

// properties

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

@property (strong, nonatomic) IBInspectable UIColor* borderColor;

// methods


@end

@implementation ViewWithBorder


#pragma mark - Properties -

- (void) setBorderWidth: (CGFloat) borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (void) setBorderColor: (UIColor*) borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}


@end
