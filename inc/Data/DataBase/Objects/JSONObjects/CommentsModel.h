//
//  CommentsModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import <JSONModel/JSONModel.h>

// Classes
#import "StorageFilesModel.h"

@interface CommentsModel : JSONModel

@property (strong, nonatomic) NSNumber* commentID;
@property (strong, nonatomic) NSString* message;
@property (strong, nonatomic) NSString* author;
@property (strong, nonatomic) NSString* avatarSrc;
@property (strong, nonatomic) NSString* authorId;
@property (strong, nonatomic) NSDate* date;
@property (strong, nonatomic) NSArray<StorageFilesModel>* storageFiles;

@end
