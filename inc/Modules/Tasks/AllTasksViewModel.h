//
//  AllTasksViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"


@interface AllTasksViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

// properties

@property (copy, nonatomic) void(^didShowTaskInfo)();

// methods

- (RACSignal*) updateContent;


@end
