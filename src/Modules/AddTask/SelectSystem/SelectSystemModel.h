//
//  SelectSystemModel.h
//  TookTODO
//
//  Created by Lera on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

//Classes
#import "ProjectSystem+CoreDataClass.h"

@interface SelectSystemModel : NSObject

// Methods
- (NSInteger) countOfRows;

- (NSArray*) getSystems;

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) indexPath;

- (void) updateLastIndexPath: (NSIndexPath*) indexPath;

- (NSIndexPath*) getLastIndexPath;

- (ProjectSystem*) getSelectedSystem;

- (void) fillSelectedSystem: (ProjectSystem*) system;

- (BOOL) systemsIsSelected: (ProjectSystem*) system;

@end
