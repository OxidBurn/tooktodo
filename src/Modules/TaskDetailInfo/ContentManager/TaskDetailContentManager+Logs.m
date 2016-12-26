//
//  TaskDetailContentManager+Logs.m
//  TookTODO
//
//  Created by Nikolay Chaban on 21.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDetailContentManager+Logs.h"

// Classes
#import "TaskLogInfo+CoreDataClass.h"
#import "TaskLogDataContent+CoreDataClass.h"
#import "LogsContent.h"
#import "DataManager+TaskComments.h"
#import "DataManager+TaskLogs.h"
#import "FlexibleViewsContainer.h"
#import "AttachmentView.h"
#import "DataManager+Room.h"
#import "DataManager+Tasks.h"

// Helpers
#import "NSDate+Helper.h"

// 65 is width that we need to discount
// it contains width of avatar plus all horizontal costraints values
#define SUMMARY_WIDTH 65.f;

typedef NS_ENUM(NSUInteger, LogsWithUpdatedLabelsActionType)
{
    AddedDateType,
    ChangedDatesType,
    DeletedDateType,
    AddedRoomType,
    ChangedRoomType,
    DeletedRoomType,
    MovedTaskType,
};



@implementation TaskDetailContentManager (Logs)


#pragma mark - Public -

- (NSArray*) createLogsContentForTask: (ProjectTask*) task
{
    NSMutableArray* content = [NSMutableArray new];
    
    NSArray* allLogs = task.logs.array;
    
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"createdDate" ascending: NO];
    
    allLogs = [allLogs sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
    
    [allLogs enumerateObjectsUsingBlock: ^(TaskLogInfo* log, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TaskRowContent* row = [TaskRowContent new];
        
        LogsContent* logContent = [LogsContent new];
        
        [self fillBaseLogsDataForLog: log
                           toContent: logContent];
        
        // value of whole log cell height without heith of log text label
        CGFloat defaultCellHeight = 0;
        
        // value of height required for logs with variable content lenth
        // may contain height of main log text plus additional content height
        // for example new task title height
        CGFloat logContentHeight = 0;
        
        // value of main log text height
        CGFloat logTextHeight = [self countHeightForLogLabelWithString: logContent.logText
                                                              forFrame: self.tableViewFrame];
        
        
        // debug row
        NSLog(@"log name %@", logContent.logText);
        
        logContentHeight = logTextHeight;
        
        NSUInteger logType = log.logType.integerValue;
        
        switch ( logType )
        {
                // case for log of new task created
                // this case is equal the default case
                // uncomment and handle if additional data will come
//            case LogCreatedTaskType:
//            {
//
//            }
//                break;
               
            case LogAddedAttachmentType:
            {
                NSArray* storageFiles = (NSArray*)log.data.fileTitlesWithExtensions;
                
                NSArray* viewsArray = [self getArrayAttachmentsViewsWithTitles: storageFiles
                                                                     withType: AttachmentTitleDefault];
                
                CGFloat availableWidth = self.tableViewFrame.size.width - SUMMARY_WIDTH;
                
                CGRect rect = CGRectMake(0, 0, availableWidth, 16);
                
                FlexibleViewsContainer* container = [[FlexibleViewsContainer alloc] initWithFrame: rect];
                
                [container fillViewsContainerWithViews: viewsArray
                                              forWidth: availableWidth];
                
                logContent.attachmentsContainer = container;
                
                logContentHeight += container.frame.size.height;

                row.cellTypeIndex = LogWithAttachmentCellType;
            }
                break;
                
            case LogDeletedAttachmentType:
            {
                NSArray* storageFiles = (NSArray*)log.data.fileTitlesWithExtensions;
                
                NSArray* viewsArray = [self getArrayAttachmentsViewsWithTitles: storageFiles
                                                                      withType: AttachmentTitleStrikeout];
                
                CGFloat availableWidth = self.tableViewFrame.size.width - SUMMARY_WIDTH;
                
                CGRect rect = CGRectMake(0, 0, availableWidth, 16);
                
                FlexibleViewsContainer* container = [[FlexibleViewsContainer alloc] initWithFrame: rect];
                
                [container fillViewsContainerWithViews: viewsArray
                                              forWidth: availableWidth];
                
                logContent.attachmentsContainer = container;
                
                logContentHeight += container.frame.size.height;
                
                row.cellTypeIndex = LogWithAttachmentCellType;
            }
                break;
                
            case LogAddedUserWithRoleType:
            case LogDeletedUserWithRoleType:
            {
                logContent.userNewRoleType = log.data.taskRoleType;
                logContent.userNewId       = log.data.userId;
                
                row.cellTypeIndex = LogWithAssigneeCellType;
                
                logContent.actionType = AddedNewValueType;
                
                LogUserInfo* user = [DataManagerShared getUserWithID: log.data.userId];
                
                logContent.memberAvatarSrs = user.avatarSrc;
                logContent.userFullName    = user.userName;
            }
                break;
                
            case LogChangedTaskNameType:
            {
                logContent.oldTitle = log.data.oldTitle;
                logContent.titleNew = log.data.titleNew;
                
                row.cellTypeIndex = LogWithRenamedCellType;
                
                // counting content height to determine whole cell height
                CGFloat width = self.tableViewFrame.size.width - SUMMARY_WIDTH;
                
                UIFont* fontOfNewTitle = [UIFont fontWithName: @"SFUIText-Semibold"
                                                         size: 13.f];
                
                UIFont* fontOfOldTitle = [UIFont fontWithName: @"SFUIText-Regular"
                                                         size: 13.f];
                
                CGSize sizeOfOldTitle = [Utils findHeightForText: log.data.oldTitle
                                                     havingWidth: width
                                                         andFont: fontOfOldTitle];
                
                CGSize sizeOfNewTitle = [Utils findHeightForText: log.data.titleNew
                                                     havingWidth: width
                                                         andFont: fontOfNewTitle];
                
                logContentHeight += sizeOfNewTitle.height + sizeOfOldTitle.height;
            }
                break;
                
            case LogAddedMarkType:
            {
                row.cellTypeIndex = LogWithMarkCellType;
            }
                break;
                
            case LogDeletedMarkType:
            {
                row.cellTypeIndex = LogWithMarkCellType;
            }
                break;
                
            case LogAddedDatesType:
            {
                NSString* terms = [self createTermsLabelForStartDate: log.data.newStartDate
                                                                  andEndDate: log.data.newEndDate];
                
                logContent.oldTextValue = [self convertToAttributedString: terms];
                
                row.cellTypeIndex = LogWithUpdatedStringValuesType;
                
                logContent.actionType = AddedNewValueType;
            }
                break;
                
            case LogChangedDatesType:   
            {
                logContent.oldTitle = [self createTermsLabelForStartDate: log.data.oldStartDate
                                                              andEndDate: log.data.oldEndDate];
                
                logContent.titleNew = [self createTermsLabelForStartDate: log.data.newStartDate
                                                              andEndDate: log.data.newEndDate];
                
                logContent.actionType = EditedOldValueType;
                
                row.cellTypeIndex = LogWithUpdatedStringValuesType;
            }
                break;
                
            case LogDeletedDatesType:
            {
                NSLog( @"%@", log.data.debugDescription );
                
                logContent.actionType = DeletedValueType;
                
                row.cellTypeIndex = LogWithUpdatedStringValuesType;
            }
                break;
                
            case LogChangedDatesToNewValueType:
            {
                NSString* terms1 = [self createTermsLabelForStartDate: log.data.oldStartDate
                                                           andEndDate: log.data.oldEndDate];
                
                NSString* terms2 = [self createTermsLabelForStartDate: log.data.newStartDate
                                                           andEndDate: log.data.newEndDate];
                
                logContent.oldTextValue     = [self convertToAttributedString: terms1];
                logContent.updatedTextValue = [self convertToAttributedString: terms2];
                
                row.cellTypeIndex = LogWithUpdatedStringValuesType;
                
                logContent.actionType = EditedOldValueType;
            }
                break;
                
            case LogDeletedRoomType:
            {
                NSString* roomInfo = [self getRoomInfoForRoomId: log.data.oldRoomId];
                
                logContent.oldTextValue = [self convertToAttributedString: roomInfo];
                
                row.cellTypeIndex = LogWithUpdatedStringValuesType;
                
                logContent.actionType = DeletedValueType;
            }
                break;
                
                // ToDo: configurate attributed string with room title
            case LogAddedRoomType:
            {                
                NSString* roomInfo = [self getRoomInfoForRoomId: log.data.roomIdNew];
                
                logContent.oldTextValue = [self convertToAttributedString: roomInfo];
                
                row.cellTypeIndex = LogWithUpdatedStringValuesType;
                
                logContent.actionType = AddedNewValueType;
            }
                break;
                
                // ToDo: make two attributed strings with rooms info
            case LogChangedRoomType:
            {
                NSString* roomInfoOld = [self getRoomInfoForRoomId: log.data.oldRoomId];
                NSString* roomInfoNew = [self getRoomInfoForRoomId: log.data.roomIdNew];

                logContent.oldTextValue     = [self convertToAttributedString: roomInfoOld];
                logContent.updatedTextValue = [self convertToAttributedString: roomInfoNew];
                
                row.cellTypeIndex = LogWithUpdatedStringValuesType;
                
                logContent.actionType = EditedOldValueType;
            }
                break;
                
            case LogMovedTaskType:
            {
                NSString* stageOld = [DataManagerShared getTaskStageTitleByID: log.data.oldStageId];
                NSString* stageNew = [DataManagerShared getTaskStageTitleByID: log.data.stageIdNew];
                
                logContent.oldTextValue     = [self convertToAttributedString: stageOld];
                logContent.updatedTextValue = [self convertToAttributedString: stageNew];
                
                row.cellTypeIndex = LogWithUpdatedStringValuesType;
                
                logContent.actionType = EditedOldValueType;
            }
                break;
                
            case LogChangedTypeOfTaskType:
            {
                logContent.oldTaskType = log.data.oldType;
                logContent.taskTypeNew = log.data.typeNew;
                
                row.cellTypeIndex = LogWithTaskTypeCellType;
            }
                break;
                
            case LogChangedTaskStatusType:
            {
                logContent.oldTaskStatus     = log.data.oldStatus.integerValue;
                logContent.updatedTaskStatus = log.data.newStatus.integerValue;
                
                row.cellTypeIndex = LogWithChangedStatusCellType;
            }
                break;
                
            case LogAddedCommentType:
            {
                logContent.commentId = log.data.commentId;
                
                row.cellTypeIndex = LogWithCommentCellType;
                
                // counting content height to determine whole cell height
                CGFloat width = self.tableViewFrame.size.width - SUMMARY_WIDTH;
                
                UIFont* font = [UIFont fontWithName: @"SFUIText-Regular"
                                               size: 13.f];
                
                NSString* commentText = [DataManagerShared getCommentTextWithID: log.data.commentId
                                                                         inTask: task];
                
                // in case when comment was deleted from web version but log still exists
                // we reduce cell height to size of default log
                if ( commentText == nil )
                {
                    logContentHeight = -45.f;
                }
                
                CGSize size = [Utils findHeightForText: commentText
                                           havingWidth: width
                                               andFont: font];
                
                logContent.commentText        = commentText;
                logContent.sizeOfCommentLabel = size;
                
                logContentHeight += size.height;
            }
                break;
                
            default:
                
                row.cellTypeIndex = LogDefaultCellType;
                
                break;
        }
        
        defaultCellHeight = [self getDeafautCellHeightForCellType: row.cellTypeIndex];

        logContent.cellHeight = defaultCellHeight + logContentHeight;
        
        row.logContent = logContent;
        
        [content addObject: row];
        
    }];
    
    return content.copy;
}


#pragma mark - Helpers -

- (void) fillBaseLogsDataForLog: (TaskLogInfo*) log
                      toContent: (LogsContent*) logContent
{
    logContent.logText = [self createLogWithAuthor: log.userFullName
                                       withLogText: log.text];
    
    logContent.createdDate = [self createLogDateWithDate: log.createdDate];
    
    logContent.avatarSrs = log.userAvatar;
}


- (NSAttributedString*) createLogWithAuthor: (NSString*) authorName
                                withLogText: (NSString*) logText
{
    NSDictionary* atributes = @{ NSFontAttributeName : [UIFont fontWithName: @"SFUIText-Regular"
                                                                       size: 12.0] };
    
    UIColor* authorClr = [UIColor colorWithRed:0.25 green:0.28 blue:0.31 alpha:1.00];
    NSRange authorRng  = NSMakeRange(0, authorName.length);
    
    NSString* str = [NSString stringWithFormat:@"%@ %@", authorName, logText];
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:str
                                                                                attributes:atributes];
    [attrStr addAttribute: NSForegroundColorAttributeName
                    value: authorClr
                    range: authorRng];
    
    return attrStr.copy;
}

- (NSString*) createLogDateWithDate: (NSDate*) date
{
    NSString* dateInString = [NSDate stringFromDate: date
                                         withFormat: @"dd MMMM"];
    
    NSString* time = [NSDate stringFromDate: date
                                 withFormat: @"hh:mm"];
    
    return [NSString stringWithFormat: @"%@ в %@", dateInString, time];
}

- (NSString*) createTermsLabelForStartDate: (NSDate*) startDate
                                andEndDate: (NSDate*) endDate
{
    NSString* start = [NSDate stringFromDate: startDate
                                  withFormat: @"dd.MM.YY"];
    
    NSString* end = [NSDate stringFromDate: endDate
                                withFormat: @"dd.MM.YY"];
    
    NSString* terms = [NSString stringWithFormat: @"%@ - %@", start, end];
    
    return terms;
}

- (CGFloat) countHeightForLogLabelWithString: (NSAttributedString*) string
                                    forFrame: (CGRect)              frame
{
    CGFloat height;
    
    CGFloat requiredWidth = frame.size.width - SUMMARY_WIDTH;
    
    CGSize size = [Utils getAttributedTextSize: string
                                  withMaxWidth: requiredWidth];
    
    height = size.height;
    
    return height;
}

- (CGFloat) getDeafautCellHeightForCellType: (TaskDetailTableViewCells) cellIndex
{
    CGFloat height = 0;
    
    switch ( cellIndex )
    {
        case LogDefaultCellType:
        case LogWithMarkCellType:
            
            height = 46.5f;
            
            break;
        case LogWithUpdatedStringValuesType:
        case LogWithTaskTypeCellType:
            
            height = 81.f;
            
            break;
            
        case LogWithChangedStatusCellType:
            
            height = 95;
            
            break;
            
        case LogWithAssigneeCellType:
            
            height = 88;
            
            break;
            
        case LogWithRenamedCellType:
            
            height = 70;
            
            break;
            
        case LogWithErrorCellType:
            
            height = 61;
            
            break;
            
        case LogWithAttachmentCellType:
            
            height = 62;
            
            break;
            
        case LogWithCommentCellType:
            
            height = 104;
            
            break;
            
        default:
            
            height = 60.f;
            break;
    }
    
    return height;
}

- (NSArray*) getArrayAttachmentsViewsWithTitles: (NSArray*)                titles
                                       withType: (AttachmentViewTitleType) type
{
    __block NSMutableArray* viewsArray = [NSMutableArray new];
    
    [titles enumerateObjectsUsingBlock: ^(NSString* title, NSUInteger idx, BOOL * _Nonnull stop) {
        
        AttachmentView* view = [[[NSBundle mainBundle] loadNibNamed: @"AttachmentView"
                                                              owner: nil
                                                            options: nil] lastObject];
        
        UIFont* labelFont = [UIFont fontWithName: @"SFUIText-Regular" size: 13];
        
        [view fillViewWithAttachmentName: title
                                withFont: labelFont
                                withType: type];
        
        [viewsArray addObject: view];
    }];
    
    return viewsArray.copy;
}

- (NSString*) getRoomInfoForRoomId: (NSNumber*) roomId
{
    NSString* roomInfo = [DataManagerShared getRoomTitleWithID: roomId];
    
    return roomInfo;
}

- (NSAttributedString*) convertToAttributedString: (NSString*) string
{
    if ( string )
    {
        NSAttributedString* attString = [[NSAttributedString alloc] initWithString: string];
        
        return attString;
    }
    
    return nil;
}

@end
