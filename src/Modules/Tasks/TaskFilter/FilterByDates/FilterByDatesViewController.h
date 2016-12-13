//
//  FilterByDatesViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 03.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseMainViewController.h"

// Classes
#import "ProjectsEnumerations.h"
#import "TaskFilterConfiguration.h"
#import "TermsData.h"

@protocol FilterByDatesControllerDelegate;

@interface FilterByDatesViewController : BaseMainViewController

// properties
@property (weak, nonatomic) id <FilterByDatesControllerDelegate> delegate;

// methods
- (void) fillControllerType: (FilterByDateViewControllerType) controllerType
           withFilterConfig: (TaskFilterConfiguration*)       filterConfig
               withDelegate: (id)                             delegate;

@end

@protocol FilterByDatesControllerDelegate <NSObject>

- (void) updateConfigWithTerms: (TermsData*)                     terms
             forControllerType: (FilterByDateViewControllerType) controllerType;

@end
