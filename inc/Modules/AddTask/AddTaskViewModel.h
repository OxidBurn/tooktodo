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


@protocol AddTaskViewModelDelegate;

@interface AddTaskViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// properties
@property (weak, nonatomic) id <AddTaskViewModelDelegate> delegate;

//@property (strong, nonatomic) RACCommand* addTaskCommand;
//@property (strong, nonatomic) RACCommand* addTastAndCreateNewCommand;
//@property (strong, nonatomic) RACCommand* readyCommand;

@property (strong, nonatomic) RACCommand* enableAllButtonsCommand;

@property (strong, nonatomic) RACSignal*  enableConfirmButtons;

@property (nonatomic, strong) NSString* taskNameText;

@end

@protocol AddTaskViewModelDelegate <NSObject>

- (void) performSegueWithSegueId: (NSString*) segueId;

- (void) reloadAddTaskTableView;

@end
