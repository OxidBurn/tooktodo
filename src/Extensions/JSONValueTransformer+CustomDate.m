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
    
    NSDate* date = [formatter dateFromString: string];
    
    if ( date == nil )
    {
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
        
        date = [formatter dateFromString: string];
    }
    
    if ( date == nil )
    {
        formatter.dateFormat = @"dd.MM.yyyy'T'HH:mm:ss.SSS";
        
        date = [formatter dateFromString: string];
    }
    
    if ( date == nil )
    {
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
        
        date = [formatter dateFromString: string];
    }
    
    if ( date == nil )
    {
        formatter.dateFormat = @"yyyy-MM-dd";
        
        date = [formatter dateFromString: string];
    }
    
    return date;
}

@end
