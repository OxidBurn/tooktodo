//
//  TaskFiltersService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ReactiveCocoa.h"

@interface TaskFiltersService : NSObject

// methods

+ (instancetype) sharedInstance;

- (RACSignal*) loadAllTaskFiltersInfo: (NSNumber*) projectID;

@end
