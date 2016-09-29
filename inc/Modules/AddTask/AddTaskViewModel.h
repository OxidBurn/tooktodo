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
#import "ReactiveCocoa/ReactiveCocoa.h"

//Classes
#import "NewTask.h"

@protocol AddTaskViewModelDelegate;

@interface AddTaskViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// properties

@property (weak, nonatomic) id <AddTaskViewModelDelegate> delegate;
@property (strong, nonatomic) RACCommand* enableAllButtonsCommand;
@property (strong, nonatomic) RACSignal*  enableConfirmButtons;
@property (nonatomic, strong) NSString* taskNameText;

//methods

- (NewTask*) getNewTask;

- (NSArray*) returnAllSeguesArray;

- (id) returnModel;

@end

@protocol AddTaskViewModelDelegate <NSObject>

- (void) performSegueWithSegueId: (NSString*) segueId;

- (void) reloadAddTaskTableView;

@end
