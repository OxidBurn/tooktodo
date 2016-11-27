//
//  FilterBySystemsViewController.h
//  TookTODO
//
//  Created by Lera on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseMainViewController.h"
#import "TaskFilterConfiguration.h"

@protocol FilterBySystemsViewControllerDelegate;

@interface FilterBySystemsViewController : BaseMainViewController

@property (nonatomic, weak) id <FilterBySystemsViewControllerDelegate> delegate;

- (void) fillSelectedSystemsInfoFromConfig: (TaskFilterConfiguration*) filterConfig;

@end

@protocol FilterBySystemsViewControllerDelegate <NSObject>

- (void) returnSelectedSystemsArray: (NSArray*) selectedSystems
                        withIndexes: (NSArray*) indexesArray;

@end
