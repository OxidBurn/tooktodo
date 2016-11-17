//
//  StorageFileDirectoryModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 11/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol StorageFileDirectoryModel;

@interface StorageFileDirectoryModel : JSONModel

@property (strong, nonatomic) NSArray<Optional>* childDirectories;
@property (strong, nonatomic) NSString* parentDirectoryId;
@property (strong, nonatomic) NSArray<StorageFileDirectoryModel>* parentDirectories;
@property (strong, nonatomic) NSString* author;
@property (strong, nonatomic) NSString* storageFileDirectoryID;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSNumber* accessType;
@property (strong, nonatomic) NSNumber* directoryType;
@property (strong, nonatomic) NSDate* createdDate;
@property (strong, nonatomic) NSDate* lastModifiedDate;
@property (strong, nonatomic) NSArray* availableActions;

@end
