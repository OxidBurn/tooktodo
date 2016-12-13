//
//  NSString+Utils.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

/**
 *  Check if value is email
 *
 *  @return is email bool state
 */
- (BOOL) isEmailString;

+ (NSString*) getStringWithoutWhiteSpacesAndNewLines: (NSString*) string;

@end
