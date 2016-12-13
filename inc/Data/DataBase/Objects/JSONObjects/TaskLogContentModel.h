//
//  TaskLogContentModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

// Classes
#import "TaskLogDataContentModel.h"

@protocol TaskLogContentModel;

@interface TaskLogContentModel : JSONModel

@property (nonatomic, strong) NSDate*   createdDate;
@property (nonatomic, strong) NSString* userFullName;
@property (nonatomic, strong) NSString* userAvatar;
@property (nonatomic, strong) NSString* projectRoleTypeDescription;
@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) TaskLogDataContentModel<Optional>* data;

@end
