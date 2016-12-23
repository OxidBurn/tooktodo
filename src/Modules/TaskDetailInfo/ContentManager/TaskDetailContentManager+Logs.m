//
//  TaskDetailContentManager+Logs.m
//  TookTODO
//
//  Created by Nikolay Chaban on 21.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDetailContentManager+Logs.h"

// Frameworks
#import <objc/runtime.h>

// Classes
#import "TaskLogInfo+CoreDataClass.h"
#import "TaskLogDataContent+CoreDataClass.h"
#import "LogsContent.h"

// Helpers
#import "NSDate+Helper.h"

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
        
//        NSArray* properties = [self getAllPropertiesForLogData: log.data];
//        
//        row.cellTypeIndex = [self determineCellIndexForProperties: properties];
        
        NSUInteger logType = log.logType.integerValue;
        
        switch ( logType )
        {
//            case LogCreatedTaskType:               // might be unnaccessary
//            {
//                logContent.logText = 
//            }
//                break;
               
//            case LogAddedAttachmentType:
//            {
//                
//            }
//                break;
                
//            case LogDeletedAttachmentType:
//            {
//                
//            }
//                break;
                
            case LogAddedUserWithRoleType:
            {
                logContent.userNewRoleType = log.data.taskRoleType;
                logContent.userNewId       = log.data.userId;
                
                row.cellTypeIndex = LogWithAssigneeCellType;
                
                logContent.actionType = AddedNewValueType;
            }
                break;
                
            case LogDeletedUserWithRoleType:
            {
                logContent.userNewRoleType = log.data.taskRoleType;
                logContent.userNewId       = log.data.userId;
                
                row.cellTypeIndex = LogWithAssigneeCellType;
                
                logContent.actionType = DeletedValueType;
            }
                break;
                
            case LogChangedTaskNameType:
            {
                logContent.oldTitle = log.data.oldTitle;
                logContent.titleNew = log.data.titleNew;
                
                row.cellTypeIndex = LogWithRenamedCellType;
            }
                break;
                
//            case LogAddedMarkType:
//            {
//                
//            }
//                break;
                
//            case LogDeletedMarkType:
//            {
//                
//            }
//                break;
                
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
            }
                break;
                
            case LogAddedCommentType:
            {
                logContent.commentId = log.data.commentId;
                
                row.cellTypeIndex = LogWithCommentCellType;
            }
                break;
                
            default:
                
                row.cellTypeIndex = LogDefaultCellType;
                
                break;
        }

        logContent.cellHeight = 70;
        
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


- (NSArray*) getAllPropertiesForLogData: (TaskLogDataContent*) logData
{
    id currentClass = [logData class];
    
    NSString* propertyName;
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList(currentClass, &outCount);
    
    NSMutableArray* propertiesArray = [NSMutableArray new];
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        propertyName = [NSString stringWithCString:property_getName(property)];
        
        if ( [logData valueForKey: propertyName] != nil )
        {
            [propertiesArray addObject: propertyName];
        }
    }
    
    return propertiesArray.copy;
}

- (TaskDetailTableViewCells) determineCellIndexForProperties: (NSArray*) properties
{
    NSUInteger index = LogDefaultCellType;
    
    if ( [properties containsObject: @"oldStatus"] )
    {
        index = LogWithChangedStatusCellType;
        return index;
    }
    
    if ( [properties containsObject: @"oldEndDate"] )
    {
        index = LogWithUpdatedStringValuesType;
        return index;
    }
    
    if ( [properties containsObject: @""] )
    {
        
    }
    
    return index;
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

- (CGFloat) countHeightForLogLabelWithString: (NSString*) string
                                    forFrame: (CGRect)    frame
{
    CGFloat height;
    
    UIFont* font = [UIFont fontWithName: @"SFUIText-Regular" size: 12.f];
    
    CGSize size = [Utils findHeightForText: string
                               havingWidth: frame.size.width - 69
                                   andFont: font];
    
    height = size.height;
    
    return height;
}



@end
