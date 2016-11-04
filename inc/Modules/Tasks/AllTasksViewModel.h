//
//  AllTasksViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"
#import "ProjectTask+CoreDataClass.h"
#import "PopoverModel.h"

@interface AllTasksViewModel : NSObject <UITableViewDataSource, UITableViewDelegate, PopoverModelDelegate, PopoverModelDataSource>

// properties

@property (copy, nonatomic) void(^didShowTaskInfo)();

@property (nonatomic, copy) void(^reloadTable)();

- (ProjectTask*) getSelectedProjectTask;

// methods

- (RACSignal*) updateContent;


@end
