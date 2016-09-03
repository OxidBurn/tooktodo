//
//  TeamAPIService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseAPIService.h"

@interface TeamAPIService : BaseAPIService

/**
 * gets singleton object.
 * @return singleton
 */
+ (TeamAPIService*) sharedInstance;

@end
