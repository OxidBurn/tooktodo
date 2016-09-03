//
//  TeamService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamService : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (TeamService*) sharedInstance;

@end
