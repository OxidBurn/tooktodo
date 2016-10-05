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

@interface ProjectTasksViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// properties

@property (copy, nonatomic) void(^didShowTaskInfo)();

// methods

- (RACSignal*) updateContent;

@end
