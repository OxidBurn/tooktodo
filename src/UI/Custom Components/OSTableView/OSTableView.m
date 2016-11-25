//
//  OSTableView.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSTableView.h"

@implementation OSTableView

- (void)setOffsetShift: (CGFloat) offsetShift
{
    _offsetShift = offsetShift;

    self.contentOffset = CGPointZero;
}

- (void)setContentOffset: (CGPoint) contentOffset
{
    if (self.blockScroll) {
        [super setContentOffset: CGPointMake(0, self.offsetShift)];
        return;
    }

    [super setContentOffset: contentOffset];
}

@end
