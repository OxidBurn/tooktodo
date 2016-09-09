//
//  PermissionService.h
//  TookTODO
//
//  Created by Lera on 09.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//



#import <Foundation/Foundation.h>

// Frameworks
#import "ReactiveCocoa.h"

//Classes

// Extensions
#import "DataManager+ProjectInfo.h"

@interface PermissionService : NSObject

+ (PermissionService*) sharedInstance;

- (RACSignal*) loadPermissionsForProject: (ProjectInfo*) project;

@end
