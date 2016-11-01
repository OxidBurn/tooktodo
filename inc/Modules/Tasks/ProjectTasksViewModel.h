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

@interface ProjectTasksViewModel : NSObject <UITableViewDelegate, UITableViewDataSource, PopoverModelDelegate, PopoverModelDataSource>

// properties

@property (copy, nonatomic) void(^didShowTaskInfo)();

// methods

- (RACSignal*) updateContent;

@end
