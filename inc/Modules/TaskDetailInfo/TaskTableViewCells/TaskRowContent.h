//
//  TaskRowContent.h
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "TaskMarkerComponent.h"
#import "FlexibleViewsContainer.h"

@interface TaskRowContent : NSObject

@property (strong, nonatomic) NSString* cellId;

@property (assign, nonatomic) NSUInteger cellTypeIndex;

@property (assign, nonatomic) CGFloat rowHeight;

@property (strong, nonatomic) NSString* taskTitle;

@property (strong, nonatomic) NSString* taskDescription;

@property (strong, nonatomic) NSDate* taskStartDate;

@property (strong, nonatomic) NSDate* taskEndDate;

@property (strong, nonatomic) NSDate* taskCloseDate;

@property (strong, nonatomic) NSString* descriptionValue;

@property (assign, nonatomic) NSUInteger taskDuration;

@property (assign, nonatomic) BOOL isExpired;

@property (assign, nonatomic) BOOL isIncludedRestDays;

@property (assign, nonatomic) BOOL isUrgent;

@property (assign, nonatomic) BOOL isHiddenTask;

@property (strong, nonatomic) NSString* mapPreviewImage;

@property (assign, nonatomic) NSUInteger ownerUserId;

@property (assign, nonatomic) NSUInteger status;

@property (strong, nonatomic) NSString* statusDescription; // инфо в кнопке , пример "в работе",

@property (assign, nonatomic) NSUInteger taskType; // enum для кружочка в верхней части ячейки, пример "согласование" - синий цвет

@property (strong, nonatomic) NSString* taskTypeDescription; // описание taskType пример "согласование"

@property (strong, nonatomic) NSArray* ownerUser;

@property (strong, nonatomic) NSArray* responsibleUser;

@property (strong, nonatomic) NSArray* claiming; // брать из NSSet<ProjectTaskRoleAssignments *> *taskRoleAssignments;

@property (strong, nonatomic) NSArray* observers; // фильтровать по соответствующим флагам

@property (strong, nonatomic) NSString* workAreaShortTitle; // пример "ОВКМС"

@property (strong, nonatomic) NSString* workAreaTitle;

@property (strong, nonatomic) NSString* taskStageTitle;

@property (assign, nonatomic) NSUInteger roomNumber; // брать из ProjectTaskRoom *room;

@property (assign, nonatomic) NSUInteger levelNumber; // брать из ProjectTaskRoomLevel *roomLevel;

@property (assign, nonatomic) NSUInteger subtasksNumber;

@property (assign, nonatomic) NSUInteger attachmentsNumber;

@property (assign, nonatomic) NSUInteger commentsNumber;

@property (strong, nonatomic) NSString* roomNumberMarkImageName;

@property (strong, nonatomic) NSString* changeStatusMarkImageName;

@property (assign, nonatomic) NSString* taskStatusMarkImageName;

@property (strong, nonatomic) FlexibleViewsContainer* containerView;

// properties for comments
@property (assign, nonatomic) CGFloat commentTextViewHeight;

@property (strong, nonatomic) NSString* attachmentTitle;

@property (strong, nonatomic) UIImage* attachmentImage;

@property (strong, nonatomic) NSString* commentAuthorName;

@property (strong, nonatomic) UIImage* commentAuthorAvatar;

@property (strong, nonatomic) NSString* commentAuthorAvatarSrc;

@property (strong, nonatomic) NSString* commentText;

@property (strong, nonatomic) NSDate* commentDate;

@property (strong, nonatomic) NSString* commentID;

// properties for logs

@property (strong, nonatomic) NSAttributedString* logText;

@property (strong, nonatomic) NSString* logDateInString;

@property (strong, nonatomic) NSString* logAuthorAvatarSrs;

@property (assign, nonatomic) NSUInteger oldStatusValue;

@property (assign, nonatomic) NSUInteger newStatusValue;

@property (strong, nonatomic) NSString* oldTerms;

@property (strong, nonatomic) NSString* newTermsValue;

@end
