//
//  SystemsAPIService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "BaseAPIService.h"

@interface SystemsAPIService : BaseAPIService

/**
 * gets singleton object.
 * @return singleton
 */
+ (SystemsAPIService*) sharedInstance;

- (RACSignal*) loadProjectSystemsInfo: (NSString*) requestString;

@end
