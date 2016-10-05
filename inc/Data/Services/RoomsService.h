//
//  RoomsService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

@interface RoomsService : NSObject

// methods

+ (instancetype) sharedInstance;

- (RACSignal*) getRoomLevelsForSelectedProjectWithID: (NSNumber*) projectID;

@end
