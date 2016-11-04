//
//  FilterByDatesModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 03.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "RowContent.h"

@interface FilterByDatesModel : NSObject

// methods
- (RowContent*) getRowContentForIndexPath: (NSIndexPath*) indexPath;

@end
