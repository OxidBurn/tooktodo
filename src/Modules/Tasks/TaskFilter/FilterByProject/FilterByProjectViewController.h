//
//  FilterByProjectViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 28.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseMainViewController.h"

@protocol FilterByProjectControllerDelegate;

@interface FilterByProjectViewController : BaseMainViewController

// properties
@property (weak, nonatomic) id <FilterByProjectControllerDelegate> delegate;

// methods
- (void) fillSelectedProjects: (NSArray*) projects
                  withIndexes: (NSArray*) indexes
                 withDelegate: (id)       deletate;

@end

@protocol FilterByProjectControllerDelegate <NSObject>

- (void) returnSelectedProjects: (NSArray*) selectedProjects
                    withIndexes: (NSArray*) selectedProjectsIndexes;

@end
