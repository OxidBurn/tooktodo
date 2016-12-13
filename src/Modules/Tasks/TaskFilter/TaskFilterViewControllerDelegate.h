//
//  TaskFilterViewControllerDelegate.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TaskFilterViewControllerDelegate <NSObject>

// methods

- (void) applyFilterForTasks;

- (void) resetFilterForTasks;

@end
