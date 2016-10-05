//
//  RoomsAPIService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "BaseAPIService.h"

@interface RoomsAPIService : BaseAPIService

// methods

+ (instancetype) sharedInstance;

- (RACSignal*) fetchRoomsLevelInfoForProject: (NSString*) url;

@end
