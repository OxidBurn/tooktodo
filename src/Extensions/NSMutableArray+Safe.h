//
//  NSMutableArray+Safe.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Safe)

- (void) safeRemoveObjectAtIndex: (NSUInteger) index;

- (void) safeRemoveObject: (id) object;

- (void) safeAddObject: (id) object;

@end
