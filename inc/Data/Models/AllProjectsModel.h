//
//  AllProjectsModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "ProjectsEnumerations.h"

@interface AllProjectsModel : NSObject

// properties


// methods

- (NSArray*) getProjectsContent;

- (NSArray*) applyProjectsSortingType: (AllProjectsSortingType) type
                              toArray: (NSArray*)               array;

- (NSUInteger) getProjectsSortedType;

- (NSArray*) getProjectsSortedPopoverContent;


@end
