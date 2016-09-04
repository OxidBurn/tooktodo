//
//  SystemsInfoViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

@interface SystemsInfoViewModel : NSObject <UITableViewDataSource>

// methods

- (RACSignal*) updateInfo;

@end
