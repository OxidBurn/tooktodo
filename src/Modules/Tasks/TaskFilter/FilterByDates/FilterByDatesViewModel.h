//
//  FilterByDatesViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 03.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks

// Classes
#import "TaskFilterConfiguration.h"
#import "ProjectsEnumerations.h"

@interface FilterByDatesViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

// properties
@property (nonatomic, copy) void(^handleTableViewHeight)(BOOL didExpanded);

@property (nonatomic, copy) void (^reloadTableView)();

// methods
- (void) fillFilterConfig: (TaskFilterConfiguration*)       filterConfig
       withControllerType: (FilterByDateViewControllerType) controllerType;

- (TermsData*) getTermsData;

- (void) setBeforeCurrentDate;

- (void) setAfterCurrentDate;

- (void) setLastWeek;

- (void) setCurrentWeek;

- (void) setLastMonth;

- (void) setCurrentMonth;

@end
