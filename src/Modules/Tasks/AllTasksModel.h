//
//  AllTasksModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "ProjectInfo.h"

@interface AllTasksModel : NSObject

// properties


// methods

- (RACSignal*) updateContent;

- (NSUInteger) countOfSections;

- (NSUInteger) countOfRowsInSection: (NSUInteger) section;

- (ProjectInfo*) getProjectInfoForSection: (NSUInteger) section;

- (void) markProjectAsExpanded: (NSUInteger)            projectIndex
                withCompletion: (CompletionWithSuccess) completion;


@end
