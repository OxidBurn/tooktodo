//
//  ProjectTasksViewModel.h
//  TookTODO
//
//  Created by Lera on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

//Frameworks
#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface ProjectTasksViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// methods

- (RACSignal*) updateContent;

@end
