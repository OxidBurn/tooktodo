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
        
        row.logContent = [LogsContent new];
        
        [self fillBaseLogsDataForLog: log
                           toContent: row];
        
        NSArray* properties = [self getAllPropertiesForLogData: log.data];
        
        row.cellTypeIndex = [self determineCellIndexForProperties: properties];
                
        switch ( row.cellTypeIndex )
        {
            case LogWithChangedStatusCellType:
            {
                row.logContent.oldTaskStatus     = log.data.oldStatus.integerValue;
                row.logContent.updatedTaskStatus = log.data.newStatus.integerValue;
            }
                break;
                
            case LogWithUpdatedStringValuesType:
            {
                LogsWithUpdatedLabelsActionType actionType;
                
                switch ( actionType )
                {
                    case AddedDateType:
                    {
                        
                    }
                        break;
                        
                    case ChangedDatesType:
                    {
                        
                    }
                        break;
                        
                    case DeletedDateType:
                    {
                        
                    }
                        break;
                        
                    case AddedRoomType:
                    {
                        
                    }
                        break;
                        
                    case ChangedRoomType:
                    {
                        
                    }
                        break;
                        
                    case DeletedRoomType:
                    {
                        
                    }
                        break;
                        
                    case MovedTaskType:
                    {
                        
                    }
                        break;
                        
                    default:
                        break;
                }
                
                
                row.logContent.oldTextValue = [self createTermsLabelForStartDate: log.data.oldStartDate
                                                                      andEndDate: log.data.oldEndDate];
                
                row.logContent.updatedTextValue = [self createTermsLabelForStartDate: log.data.newStartDate
                                                                          andEndDate: log.data.newEndDate];
            }
                break;
                
            case LogDefaultCellType:
            {
                NSString* fullLogString = [log.userFullName stringByAppendingString: log.text];
                
                row.logContent.cellHeight = [self countHeightForLogLabelWithString: fullLogString
                                                                          forFrame: self.tableViewFrame];
            }
                
            default:
                break;
        }
        
        [content addObject: row];
        
    }];
    
    return content.copy;
}


#pragma mark - Helpers -

- (void) fillBaseLogsDataForLog: (TaskLogInfo*)    log
                      toContent: (TaskRowContent*) content
{
    content.logContent.logText = [self createLogWithAuthor: log.userFullName
                                           withLogText: log.text];
    
    content.logContent.createdDate = [self createLogDateWithDate: log.createdDate];
    
    content.logContent.avatarSrs = log.userAvatar;
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
