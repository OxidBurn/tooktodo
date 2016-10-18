//
//  TaskDetailMainFactory.m
//  TookTODO
//
//  Created by Глеб on 18.10.16.
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

@interface TaskDetailMainFactory()

// properties


// methods


@end

@implementation TaskDetailMainFactory

#pragma mark - Public -

- (UITableViewCell*) createCellForTableView: (UITableView*)    tableView
                                withContent: (TaskRowContent*) content
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
            
            cell = [factory returnCellectionCellForTableView: tableView];
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
                                               withContent: content];
        }
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
