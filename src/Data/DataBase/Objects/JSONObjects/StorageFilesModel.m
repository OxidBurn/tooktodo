//
//  StorageFilesModel.m
//  TookTODO
//
//  Created by Chaban Nikolay on 11/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "StorageFilesModel.h"

@implementation StorageFilesModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id" : @"storageFileID"}];
}

@end
