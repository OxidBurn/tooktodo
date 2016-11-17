//
//  StorageFileDirectoryModel.m
//  TookTODO
//
//  Created by Chaban Nikolay on 11/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "StorageFileDirectoryModel.h"

@implementation StorageFileDirectoryModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id" : @"storageFileDirectoryID"}];
}

@end
