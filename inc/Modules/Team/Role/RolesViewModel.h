//
//  RolesViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "ProjectRoles.h"

@interface RolesViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

- (ProjectRoles*) getSelectedItem;

- (RACSignal*) updateRolesInfo;

@end
