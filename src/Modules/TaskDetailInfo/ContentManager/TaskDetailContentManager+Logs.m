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
        
        logContentHeight = logTextHeight;
        
        NSUInteger logType = log.logType.integerValue;
        
        switch ( logType )
        {
//            case LogCreatedTaskType:               // might be unnaccessary
//            {
//                logContent.logText = 
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
                logContent.oldTextValue = [self createTermsLabelForStartDate: log.data.newStartDate
                                                                  andEndDate: log.data.newEndDate];
                
                row.cellTypeIndex = LogWithUpdatedStringValuesType;
                
                logContent.actionType = AddedNewValueType;
            }
                break;
                
//            case LogChangedDatesType:   // might be unnaccessary
//            {
//                
//            }
//                break;
//                
//            case LogDeletedDatesType:
//            {
//                
//            }
//                break;
                
            case LogChangedDatesToNewValueType:
            {
                NSString* terms1 = [self createTermsLabelForStartDate: log.data.oldStartDate
                                                           andEndDate: log.data.oldEndDate];
                
                NSString* terms2 = [self createTermsLabelForStartDate: log.data.newStartDate
                                                           andEndDate: log.data.newEndDate];
                
                logContent.oldTextValue     = terms1;
                logContent.updatedTextValue = terms2;
                
                row.cellTypeIndex = LogWithUpdatedStringValuesType;
                
                logContent.actionType = EditedOldValueType;
            }
                break;
                
//            case LogDeletedRoomType:
//            {
//                
//            }
//                break;
                
                // ToDo: configurate attributed string with room title
            case LogAddedRoomType:
            {
                logContent.oldTextValue = [NSString stringWithFormat: @"%@", log.data.roomIdNew.stringValue];
                
                row.cellTypeIndex = LogWithUpdatedStringValuesType;
                
                logContent.actionType = AddedNewValueType;
            }
                break;
                
                // ToDo: make two attributed strings with rooms info
            case LogChangedRoomType:
            {
                logContent.oldTextValue     = log.data.oldRoomId.stringValue;
                logContent.updatedTextValue = log.data.roomIdNew.stringValue;
                
                row.cellTypeIndex = LogWithUpdatedStringValuesType;
                
                logContent.actionType = EditedOldValueType;
            }
                break;
                
            case LogMovedTaskType:
            {
                logContent.oldTextValue     = log.data.oldStageId.stringValue;
                logContent.updatedTextValue = log.data.stageIdNew.stringValue;
                
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
                                  withFormat: @"dd.mm.yyyy"];
    
    NSString* end = [NSDate stringFromDate: endDate
                                withFormat: @"dd.mm.yyyy"];
    
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

@end
