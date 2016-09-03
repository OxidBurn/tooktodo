//
//  SystemsService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ReactiveCocoa.h"

@interface SystemsService : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (SystemsService*) sharedInstance;

- (NSArray*) getCurrentProjectSystems;

- (RACSignal*) loadCurrentProjectSystems: (NSNumber*) projectID;

@end
