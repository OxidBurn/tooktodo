//
//  AboutProjectModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 28.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AboutProjectModel : NSObject

// methods
- (NSUInteger) getNumberOfSections;

- (NSUInteger) getNumberOfRowsForSection: (NSUInteger) section;

- (NSString*) getCellTitleForIndexPath: (NSIndexPath*) indexPath;

- (NSString*) getCellDetailForIndexPath: (NSIndexPath*) indexPath;

- (void) updateProjectInfo;

@end
