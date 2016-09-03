//
//  SystemsAPIService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemsAPIService : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (SystemsAPIService*) sharedInstance;

@end
