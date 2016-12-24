//
//  TaskDetailMainFactory.m
//  TookTODO
//
//  Created by Chaban Nikolay on 18.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDetailMainFactory.h"

// Classes
#import "ProjectsEnumerations.h"

// Factories
#import "TaskDetailInfoFactory.h"
#import "TaskDescriptionFactory.h"
#import "CollectionCellFactory.h"
#import "FilterSubtaskCellFactory.h"
#import "FilterAttachmentsCellFactory.h"
#import "AddCommentCellFactory.h"
#import "SubtaskInfoFactory.h"
#import "AttachmentsCellFactory.h"
#import "CommentsCellFactory.h"
#import "LogDefaultCellFactory.h"
#import "LogWithUpdatedStringValuesFactory.h"
#import "LogWithChangedStatusFactory.h"
#import "LogWithAssigneeCellFactory.h"
#import "LogWithErrorCellFactory.h"
#import "LogWithCommentCellFactory.h"
#import "LogWithRenamedCellFactory.h"
#import "LogWithAttachmentCellFactory.h"
#import "LogWithTaskTypeCellFactrory.h"
#import "LogWithMarkCellFactory.h"


@implementation TaskDetailMainFactory

#pragma mark - Public -

- (UITableViewCell*) createCellForTableView: (UITableView*)    tableView
                                withContent: (TaskRowContent*) content
                               withDelegate: (id)              delegate
{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
        
    switch ( content.cellTypeIndex )
    {
        case TaskDetailCellType:
        {
            TaskDetailInfoFactory* factory = [TaskDetailInfoFactory new];
            
            cell = [factory returnTaskDetailCellWithContent: content
                                               forTableView: tableView];
            
        }
            break;
            
        case TaskDescriptionCellType:
        {
            TaskDescriptionFactory* factory = [TaskDescriptionFactory new];
            
            cell = [factory returnDescriptionCellWithContent: content
                                                forTableView: tableView];
        }
            break;
            
        case CollectionCellType:
        {
            CollectionCellFactory* factory = [CollectionCellFactory new];
            
            cell = [factory returnCollectionCellForTableView: tableView
                                                withDelegate: delegate];
            
            
            
        }
            break;
            
        case FilterSubtasksCellType:
        {
            FilterSubtaskCellFactory* factory = [FilterSubtaskCellFactory new];
            
            cell = [factory returnFilterSubtasksCellForTableView: tableView];
            
        }
            break;
            
        case FilterAttachmentsCellType:
        {
            FilterAttachmentsCellFactory* factory = [FilterAttachmentsCellFactory new];
            
            cell = [factory returnFilterAttachmentsCellForTableView: tableView];
        }
            break;
            
        case AddCommentCellType:
        {
            AddCommentCellFactory* factory = [AddCommentCellFactory new];
            
            cell = [factory returnAddCommentCellForTableView: tableView];
        }
            break;
            
        case SubtaskInfoCellType:
        {
            SubtaskInfoFactory* factory = [SubtaskInfoFactory new];
            
            cell = [factory returnSubtaskInfoCellForTableView: tableView
                                                  withContent: content];
            
        }
            break;
            
        case AttachmentsCellType:
        {
            AttachmentsCellFactory* factory = [AttachmentsCellFactory new];
            
            cell = [factory returnAttachmentsCellForTableView: tableView
                                                  withContent: content];
        }
            break;
            
        case CommentsCellType:
        {
            CommentsCellFactory* factory = [CommentsCellFactory new];
            
            cell = [factory returnCommentsCellForTableView: tableView
                                               withContent: content
                                              withDelegate: delegate];
        }
            break;
            
        case LogDefaultCellType:
        {
            LogDefaultCellFactory* factory = [LogDefaultCellFactory new];
            
            cell = [factory returnLogCellForTableView: tableView
                                          withContent: content];
        }
            break;
            
        case LogWithChangedStatusCellType:
        {
            LogWithChangedStatusFactory* factory = [LogWithChangedStatusFactory new];
            
            cell = [factory returnLogCellForTableView: tableView
                                          withContent: content];
        }
            break;
            
        case LogWithUpdatedStringValuesType:
        {
            LogWithUpdatedStringValuesFactory* factory = [LogWithUpdatedStringValuesFactory new];
            
            cell = [factory returnLogCellForTableView: tableView
                                          withContent: content];
        }
            break;
            
        case LogWithAssigneeCellType:
        {
            LogWithAssigneeCellFactory* factory = [LogWithAssigneeCellFactory new];
            
            cell = [factory returnLogCellForTableView: tableView
                                          withContent: content];
        }
            break;

        case LogWithTaskTypeCellType:
        {
            LogWithTaskTypeCellFactrory* factory = [LogWithTaskTypeCellFactrory new];
            
            cell = [factory returnLogCellForTableView: tableView
                                          withContent: content];
        }
            break;
            
        case LogWithRenamedCellType:
        {
            LogWithRenamedCellFactory* factory = [LogWithRenamedCellFactory new];
            
            cell = [factory returnLogCellForTableView: tableView
                                          withContent: content];
        }
            break;
            
        case LogWithMarkCellType:
        {
            LogWithMarkCellFactory* factory = [LogWithMarkCellFactory new];
            
            cell = [factory returnLogCellForTableView: tableView
                                          withContent: content];
        }
            break;
            
        case LogWithErrorCellType:
        {
            LogWithErrorCellFactory* factory = [LogWithErrorCellFactory new];
            
            cell = [factory returnLogCellForTableView: tableView
                                          withContent: content];
        }
            break;
            
        case LogWithCommentCellType:
        {
            LogWithCommentCellFactory* factory = [LogWithCommentCellFactory new];
            
            cell = [factory returnLogCellForTableView: tableView
                                          withContent: content];
        }
            break;
            
        case LogWithAttachmentCellType:
        {
            LogWithAttachmentCellFactory* factory = [LogWithAttachmentCellFactory new];
            
            cell = [factory returnLogCellForTableView: tableView
                                          withContent: content];
        }
            break;
            
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
