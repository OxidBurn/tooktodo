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
#import "ProjectInfo+CoreDataClass.h"
#import "ProjectsEnumerations.h"


@interface AllTasksModel : NSObject

// methods
- (instancetype) initWithDefaultSortParameters;

- (RACSignal*) updateContent;

- (NSUInteger) countOfSections;

- (NSUInteger) countOfRowsInSection: (NSUInteger) section;

- (CGFloat) getCellHeightAtIndexPath: (NSIndexPath*) path;

- (ProjectInfo*) getProjectInfoForSection: (NSUInteger) section;

- (void) markProjectAsExpanded: (NSUInteger)            projectIndex
                withCompletion: (CompletionWithSuccess) completion;

- (void) markStageAsExpandedAtIndexPath: (NSIndexPath*)          indexPath
                         withCompletion: (CompletionWithSuccess) completion;

- (NSString*) getCellIDAtIndexPath: (NSIndexPath*) path;

- (id) getInfoForCellAtIndexPath: (NSIndexPath*) path;

- (void) markTaskAsSelected: (NSIndexPath*)          index
             withCompletion: (CompletionWithSuccess) completion;

- (void) sortArrayForType: (TasksSortingType)           type
               isAcceding: (ContentAccedingSortingType) isAcceding;


@end
