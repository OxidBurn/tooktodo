//
//  ProjectTasksViewModel.h
//  TookTODO
//
// Created by Nikolay Chaban on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

//Frameworks
#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

//Classes
#import "PopoverViewController.h"
#import "ProjectTask+CoreDataClass.h"

@interface ProjectTasksViewModel : NSObject <UITableViewDelegate, UITableViewDataSource, PopoverModelDelegate, PopoverModelDataSource, UISearchBarDelegate>

// properties

@property (copy, nonatomic) void(^performSegue)(NSString* segueID);

@property (nonatomic, copy) void(^reloadTable)();

@property (copy, nonatomic) void(^endSearching)();

// methods

- (RACSignal*) updateContent;

- (RACSignal*) applyFilters;

- (ProjectTask*) getSelectedProjectTask;

- (void) updateTaskStatus;

@end
