//
//  AddTaskTermsViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 19.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

@protocol AddTaskTermsViewModelDelegate;

@interface AddTaskTermsViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

// properties
@property (weak, nonatomic) id <AddTaskTermsViewModelDelegate> delegate;

// methods
- (void) updateStartDate: (NSDate*) startDate
          withFinishDate: (NSDate*) finishDate;

- (NSDate*) returnStartDate;

- (NSDate*) returnFinishDate;

- (NSUInteger) returnDuration;

@end

@protocol AddTaskTermsViewModelDelegate <NSObject>

- (void) reloadAddTaskTableView;

@end