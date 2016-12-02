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
#import "ProjectTasksModel.h"

@interface ProjectTasksViewModel : NSObject <UITableViewDelegate, UITableViewDataSource, PopoverModelDelegate, PopoverModelDataSource, UISearchBarDelegate>

// properties

@property (copy, nonatomic) void(^performSegue)(NSString* segueID);

@property (nonatomic, copy) void(^reloadTable)();

@property (copy, nonatomic) void(^endSearching)();

@property (nonatomic, strong) NSString* countOfFoundTasksText;

@property (nonatomic, assign) NSUInteger foundedTasksHeigthConstraintConstant;

@property (nonatomic, strong) NSValue* searchBarBackgroungRectValue;

// methods

- (RACSignal*) updateContent;

- (RACSignal*) applyFilters;

- (ProjectTask*) getSelectedProjectTask;

- (SearchTableState) getSearchTableState;

- (NSUInteger) getCountOfFoundTaks;

@end
