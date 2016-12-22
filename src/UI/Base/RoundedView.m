//
//  RoundedView.m
//  TookTODO
//
//  Created by Nikolay Chaban on 12/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RoundedView.h"

IB_DESIGNABLE

@interface RoundedView()

// properties

@property (nonatomic, assign) IBInspectable CGFloat roundCorner;

// methods


@end

@implementation RoundedView


#pragma mark - Properties -

- (void) setRoundCorner: (CGFloat) roundCorner
{
    self.layer.cornerRadius = roundCorner;
}

@end
