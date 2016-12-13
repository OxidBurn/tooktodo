//
//  FilterByProjectViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 28.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

@interface FilterByProjectViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// properties
@property (nonatomic, copy) void(^reloadTableView)();

// methods
- (NSArray*) getSelectedProjectsArray;

- (NSArray*) getSelectedProjectsIndexes;

- (void) selectAll;

- (void) deselectAll;

- (void) fillSelectedProjects: (NSArray*) projects
                  withIndexes: (NSArray*) indexes;

- (BOOL) checkIfAllSelected;

@end
