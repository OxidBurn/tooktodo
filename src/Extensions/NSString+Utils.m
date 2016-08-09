//
//  NSString+Utils.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (BOOL) isEmailString
{
    NSRegularExpression* regularExp = [NSRegularExpression regularExpressionWithPattern: @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
                                                                                options: NSRegularExpressionCaseInsensitive
                                                                                  error: nil];
    
    NSArray* result = [regularExp matchesInString: self
                                          options: 0
                                            range: NSMakeRange(0, self.length)];
    
    return (result.count > 0);
}

@end
