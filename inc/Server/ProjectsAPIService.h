//
//  ProjectsAPIService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "BaseAPIService.h"

@interface ProjectsAPIService : BaseAPIService

/**
 * gets singleton object.
 * @return singleton
 */
+ (ProjectsAPIService*) sharedInstance;

- (RACSignal*) getProjectsList: (NSDictionary*) parameters;

@end
