//
//  StorageFilesModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 11/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

// Classes
#import "StorageFileDirectoryModel.h"
#import "ProjectTaskModel.h"
#import "FileDataModel.h"
#import "UserInfoData.h"

@protocol StorageFilesModel;

@interface StorageFilesModel : JSONModel

@property (strong, nonatomic) NSString *                            storageFileID;
@property (strong, nonatomic) NSString *                            title;
@property (strong, nonatomic) NSDate   *                            createdDate;
@property (strong, nonatomic) NSDate   *                            lastModifiedDate;
@property (strong, nonatomic) StorageFileDirectoryModel<Optional> * directory;
@property (strong, nonatomic) FileDataModel<Optional> *             fileData;
@property (strong, nonatomic) UserInfoData *                        author;
@property (strong, nonatomic) ProjectTaskModel<Optional> *          task;

@end
