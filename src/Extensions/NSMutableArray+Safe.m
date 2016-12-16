//
//  NSMutableArray+Safe.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "NSMutableArray+Safe.h"

@implementation NSMutableArray (Safe)

- (void) safeRemoveObjectAtIndex: (NSUInteger) index
{
    if ( self.count > index )
    {
        [self removeObjectAtIndex: index];
    }
}

- (void) safeRemoveObject: (id) object
{
    if ( [self containsObject: object] )
    {
        [self removeObject: object];
    }
}

- (void) safeAddObject: (id) object
{
    if ( object )
    {
        [self addObject: object];
    }
}

@end
