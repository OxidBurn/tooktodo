//
//  PermissionAPIService.h
//  TookTODO
//
//  Created by Lera on 09.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseAPIService.h"

@interface PermissionAPIService : BaseAPIService

+ (PermissionAPIService*) sharedInstance;

- (RACSignal*) loadProjectsPermissions: (NSString*) requestURL;

@end
