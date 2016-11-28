//
//  FilterByTypesViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseMainViewController.h"
#import "TaskFilterConfiguration.h"
#import "ProjectsEnumerations.h"

@protocol FilterByTypesViewControllerDelegate;

@interface FilterByTypesViewController : BaseMainViewController

@property (nonatomic, weak) id <FilterByTypesViewControllerDelegate> delegate;

// methods

- (void) fillSelectedTypesInfoFromConfig: (TaskFilterConfiguration*) filterConfig;

@end

@protocol FilterByTypesViewControllerDelegate <NSObject>

- (void) returnSelectedTypesArray: (NSArray*) selectedTypes;

@end
