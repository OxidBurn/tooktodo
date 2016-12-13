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

// Classes
#import "TermsData.h"

@protocol AddTaskTermsViewModelDelegate;

@interface AddTaskTermsViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

// properties
@property (weak, nonatomic) id <AddTaskTermsViewModelDelegate> delegate;

// methods
- (void) updateTerms: (TermsData*) terms;

- (TermsData*) returnTerms;

@end

@protocol AddTaskTermsViewModelDelegate <NSObject>

- (void) reloadAddTaskTableView;

@end
