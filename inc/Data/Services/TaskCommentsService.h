//
//  TaskCommentsService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ReactiveCocoa.h"

@interface TaskCommentsService : NSObject

// properties


// methods

+ (instancetype) sharedInstance;

- (RACSignal*) getCommentsForSelectedTask;
- (RACSignal*) postCommentForSelectedTask: (NSString *)comment;

@end
