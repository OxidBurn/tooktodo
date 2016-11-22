//
//  TaskCommentsAPIService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "BaseAPIService.h"

@interface TaskCommentsAPIService : BaseAPIService

// methods

+ (instancetype) sharedInstance;

- (RACSignal*) loadAllCommentsForTask: (NSString*) url;
- (RACSignal*) postCommentforTask: (NSString*) requestString
                       withParams: (NSDictionary*) params;

@end
