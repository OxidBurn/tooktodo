//
//  FilterByRoleInProjectModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterByRoleInProjectModel : NSObject

// methods
- (NSString*) getTitleForIndexPath: (NSIndexPath*) indexPath;

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) indexPath;

- (BOOL) getSelectedStateForIndexPath: (NSIndexPath*) indexPath;

@end
