//
//  JSONValueTransformer+CustomDate.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/20/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "JSONValueTransformer+CustomDate.h"

@implementation JSONValueTransformer (CustomDate)

- (NSDate*) NSDateFromNSString: (NSString*) string
{
    NSDateFormatter* formatter = [NSDateFormatter new];
    
    formatter.dateFormat = @"dd.mm.yyyy";
    
    return [formatter dateFromString:string];
}

@end
