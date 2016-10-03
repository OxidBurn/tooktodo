//
//  SelectResponsibleViewModel.h
//  TookTODO
//
//  Created by Глеб on 22.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

// Classes
#import "SelectResponsibleModel.h"

@interface SelectResponsibleViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// properties
@property (nonatomic, copy) void(^reloadTableView)();



// methods
- (void) updateInfoWithCompletion: (CompletionWithSuccess) completion;

- (void) fillContollerTypeSelection: (ControllerTypeSelection) controllerType;

- (ControllerTypeSelection) returnControllerType;

- (void) fillSelectedUsersInfo: (NSArray*) selectedUsers;

- (NSArray*) returnSelectedResponsibleArray;

- (NSArray*) returnSelectedClaimingArray;

- (NSArray*) returnSelectedObserversArray;

- (void) selectAll;

- (void) deselectAll;

@end
