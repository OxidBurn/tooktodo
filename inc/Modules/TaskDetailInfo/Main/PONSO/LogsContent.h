//
//  LogsContent.h
//  TookTODO
//
//  Created by Nikolay Chaban on 21.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "ProjectsEnumerations.h"

@interface LogsContent : NSObject


// base properties
@property (strong, nonatomic) NSNumber* logId;

@property (strong, nonatomic) NSString* userFullName;

@property (strong, nonatomic) NSString* createdDate;

@property (strong, nonatomic) NSString* avatarSrs;

@property (strong, nonatomic) NSAttributedString* logText;

@property (assign, nonatomic) CGFloat cellHeight;


// properties for logs with two updated labals
@property (strong, nonatomic) NSString* updatedTextValue;

@property (strong, nonatomic) NSString* oldTextValue;

@property (strong, nonatomic) NSAttributedString* oldRoomValue;

@property (strong, nonatomic) NSAttributedString* roomNewValue;

@property (assign, nonatomic) LogsActionType actionType;


// properties for logs with team members
@property (strong, nonatomic) NSNumber* userNewRoleType;

@property (strong, nonatomic) NSNumber* userNewId;

@property (strong, nonatomic) NSString* memberAvatarSrs;


// properties for logs with task statuses
@property (assign, nonatomic) NSUInteger oldTaskStatus;

@property (assign, nonatomic) NSUInteger updatedTaskStatus;


// properties for logs with tasks with changed titles
@property (strong, nonatomic) NSString* oldTitle;

@property (strong, nonatomic) NSString* titleNew;


// properties for logs with changed task type
@property (strong, nonatomic) NSNumber* oldTaskType;

@property (strong, nonatomic) NSNumber* taskTypeNew;

// properties for logs with new added comment
@property (strong, nonatomic) NSNumber* commentId;

@property (strong, nonatomic) NSString* commentText;

@property (assign, nonatomic) CGSize sizeOfCommentLabel;

// properties for logs with attachments
@property (strong, nonatomic) NSString* attachmentTitle;

// properties for logs with marks
@property (assign, nonatomic) BOOL isYes;

@end
