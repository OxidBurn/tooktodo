//
//  DataManager+TaskComments.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+TaskComments.h"

// Classes
#import "CommentsModel.h"
#import "ProjectTask+CoreDataClass.h"
#import "TaskComment+CoreDataClass.h"

// Categories
#import "DataManager+Tasks.h"


@implementation DataManager (TaskComments)

- (void) persistNewCommentsForSelectedTasks: (NSArray*)              commentsList
                             withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        ProjectTask* selectedTask = [DataManagerShared getSelectedTaskInContext: localContext];
        
        [commentsList enumerateObjectsUsingBlock: ^(CommentsModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistNewComment: obj
                            forTask: selectedTask
                          inContext: localContext];
            
        }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (NSArray*) getAllCommentsForSelectedTask
{
    ProjectTask* selectedTask = [DataManagerShared getSelectedTask];
    
//    return selectedTask.comm
    
    return nil;
}
//
//- (NSArray*) getAllCommentsForTask: (ProjectTask*) task
//{
//    
//}


#pragma mark - Internal methods -

- (void) persistNewComment: (CommentsModel*)          info
                   forTask: (ProjectTask*)            task
                 inContext: (NSManagedObjectContext*) context
{
    TaskComment* newComment = [self getTaskCommentWithID: info.commentID
                                                  inTask: task
                                               inContext: context];
    
    if ( newComment == nil )
    {
        newComment = [TaskComment MR_createEntityInContext: context];
        
        newComment.commentID    = info.commentID;
        newComment.message      = info.message;
        newComment.author       = info.author;
        newComment.authorId     = info.authorId;
        newComment.avatarSrc    = info.avatarSrc;
        newComment.task         = task;
        newComment.date         = info.date;
    }
    else
    {
        newComment.message = info.message;
    }
}

- (TaskComment*) getTaskCommentWithID: (NSNumber*)               commentID
                               inTask: (ProjectTask*)            task
                            inContext: (NSManagedObjectContext*) context
{
    NSPredicate* findPredicate = [NSPredicate predicateWithFormat: @"commentID == %@ AND task == %@", commentID, task];
    
    TaskComment* comment = [TaskComment MR_findFirstWithPredicate: findPredicate
                                                        inContext: context ];
    
    return comment;
}

- (void) deletCommentWithID: (NSNumber*)               commentID
                     inTask: (ProjectTask*)            task
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * localContext) {
        [[self getTaskCommentWithID: commentID
                             inTask: task
                          inContext: localContext] MR_deleteEntityInContext : localContext];
    }];
}

@end
