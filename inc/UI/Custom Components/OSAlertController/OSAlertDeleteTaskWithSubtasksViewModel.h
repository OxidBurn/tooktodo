//
//  OSAlertDeleteTaskViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSAlertDeleteTaskWithSubtasksViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// properties
@property (nonatomic, copy) void(^dismissAlert)();

@property (nonatomic, copy) void(^deleteTaskWithSubtasks)(BOOL withSubtasks);

@end
