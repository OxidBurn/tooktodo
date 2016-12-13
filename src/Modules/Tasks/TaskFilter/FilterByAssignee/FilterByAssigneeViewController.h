//
//  FilterByAssigneeViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 24.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "ProjectsEnumerations.h"
#import "BaseMainViewController.h"
#import "TaskFilterConfiguration.h"

@protocol FilterByAssigneeViewControllerDelegate;

@interface FilterByAssigneeViewController : BaseMainViewController

// properties
@property (weak, nonatomic) id <FilterByAssigneeViewControllerDelegate> delegate;

// methods
- (void) updateFilterType: (FilterByAssigneeType) filterType
             withDelegate: (id)                   delegate;

- (void) fillSelectedUsersInfoFromConfig: (TaskFilterConfiguration*) filterConfig;

@end


@protocol FilterByAssigneeViewControllerDelegate <NSObject>

- (void) returnSelectedAssigneesArray: (NSArray*)             selectedAssignees
                       withFilterType: (FilterByAssigneeType) filterType
                          withIndexes: (NSArray*)             indexesArray;

@end
