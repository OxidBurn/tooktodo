//
//  RoleInfoViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

@interface RoleInfoViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

// properties


// methods

- (RACSignal*) updateInfo;


@end
