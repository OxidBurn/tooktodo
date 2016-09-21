//
//  AddTaskViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

//Frameworks
@import UIKit;

@protocol AddTaskViewModelDelegate;

@interface AddTaskViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// properties
@property (weak, nonatomic) id <AddTaskViewModelDelegate> delegate;

@end

@protocol AddTaskViewModelDelegate <NSObject>

- (void) performSegueWithSegueId: (NSString*) segueId;

- (void) reloadAddTaskTableView;

@end
