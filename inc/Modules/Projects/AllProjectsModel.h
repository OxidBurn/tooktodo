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
#import "ProjectInfo.h"

@interface AllProjectsModel : NSObject

// properties


// methods

- (RACSignal*) getProjectsContent;

- (NSArray*) applyProjectsSortingType: (AllProjectsSortingType)     type
                              toArray: (NSArray*)                   array
                           isAcceding: (ContentAccedingSortingType) isAcceding;

- (AllProjectsSortingType) getProjectsSortedType;

- (ContentAccedingSortingType) getProjectsSortAccedingType;

- (NSArray*) getProjectsSortedPopoverContent;

- (NSArray*) filteredContentWithSearchText: (NSString*) searchText
                                   inArray: (NSArray*)  array;

- (void) markProjectAsSelected: (ProjectInfo*)          info
                withCompletion: (CompletionWithSuccess) completion;

@end
