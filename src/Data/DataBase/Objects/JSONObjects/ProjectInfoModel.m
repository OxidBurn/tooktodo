//
//  ProjectInfo.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectInfoModel.h"

#import "JSONValueTransformer+CustomDate.h"

@implementation ProjectInfoModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id"        : @"projectID",
                                                        @"lastVisit" : @"lastVisit"}];
}

//- (void) setLastVisitWithNSString: (NSString*) string
//{
//    self.lastVisit = [self NSDateFromNSString: string];
//}
//
//
//#pragma mark - Helpful methods -
//
//- (NSDate*) NSDateFromNSString: (NSString*) string
//{
//    NSDate* convertedDate = [NSDate dateFromString: string withFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSS"];
//    
//    return convertedDate;
//}

@end
