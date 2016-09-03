//
//  RolesAPIService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseAPIService.h"

@interface RolesAPIService : BaseAPIService

/**
 * gets singleton object.
 * @return singleton
 */
+ (RolesAPIService*) sharedInstance;

- (RACSignal*) loadProjectsRoles: (NSString*) requestURL;

@end
