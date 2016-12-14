//
//  DataManager+TaskAvailableActions.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+TaskAvailableActions.h"

// Classes
#import "TaskAvailableActionsList+CoreDataClass.h"
#import "TaskAvailableAction+CoreDataClass.h"
#import "TaskAvailableStatusAction+CoreDataClass.h"
#import "TaskAvailableStagesAction+CoreDataClass.h"

#import "TaskActionModel.h"
#import "TaskStatusActionModel.h"
#import "TaskStagesActionModel.h"

#import "DataManager+Tasks.h"

@implementation DataManager (TaskAvailableActions)

- (void) persistTaskAvailableActionsForSelectedTask: (TaskAvailableActionsModel*) info
                                     withCompletion: (CompletionWithSuccess)      compltion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        [self persistAvailableActions: info
                            inContext: localContext];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( compltion )
                              compltion(contextDidSave);
                          
                      }];
}


#pragma mark - Storing methods -

- (void) persistAvailableActions: (TaskAvailableActionsModel*) info
                       inContext: (NSManagedObjectContext*)    context
{
    ProjectTask* task = [self getSelectedTaskInContext: context];
    
    task.availableActions = nil;
    
    NSPredicate* findPredicate = [NSPredicate predicateWithFormat: @"task == %@", task];
    
    TaskAvailableActionsList* availableActionsList = [TaskAvailableActionsList MR_findFirstWithPredicate: findPredicate
                                                                                               inContext: context];
    
    if ( availableActionsList == nil )
    {
        availableActionsList = [TaskAvailableActionsList MR_createEntityInContext: context];
    }
    
    availableActionsList.task = task;
    
    // store available actions
    [info.actions enumerateObjectsUsingBlock: ^(TaskActionModel* action, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self persistTaskAvailableAction: action
                     forAvailableActions: availableActionsList
                               inContext: context];
        
    }];
    
    // store status actions
    [info.statusActions enumerateObjectsUsingBlock: ^(TaskStatusActionModel* statusAction, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self persistTaskAvailableStatusAction: statusAction
                         forAvaiableActionList: availableActionsList
                                     inContext: context];
        
    }];
    
    // store stage actions
    [info.stages enumerateObjectsUsingBlock: ^(TaskStagesActionModel* stageAction, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self persistTaskAvailableStageAction: stageAction
                      forAvailableActionsList: availableActionsList
                                    inContext: context];
        
    }];
}

- (void) persistTaskAvailableAction: (TaskActionModel*)          info
                forAvailableActions: (TaskAvailableActionsList*) availableAction
                          inContext: (NSManagedObjectContext*)   context
{
    NSPredicate* findPredicate = [NSPredicate predicateWithFormat: @"actionID == %@ AND availableActionsList == %@", info.actionID, availableAction];
    
    TaskAvailableAction* taskAction = [TaskAvailableAction MR_findFirstWithPredicate: findPredicate
                                                                                inContext: context];
    
    if ( taskAction == nil )
    {
        taskAction = [TaskAvailableAction MR_createEntityInContext: context];
    }
    
    taskAction.actionID             = info.actionID;
    taskAction.actionDescription    = info.actionDescription;
    taskAction.availableActionsList = availableAction;
    
}

- (void) persistTaskAvailableStatusAction: (TaskStatusActionModel*)    info
                    forAvaiableActionList: (TaskAvailableActionsList*) availableAction
                                inContext: (NSManagedObjectContext*)   context
{
    NSPredicate* findPredicate = [NSPredicate predicateWithFormat: @"statusActionID == %@ AND availableActionsList == %@", info.statusActionID, availableAction];
    
    TaskAvailableStatusAction* availableStatusAction = [TaskAvailableStatusAction MR_findFirstWithPredicate: findPredicate
                                                                                                  inContext: context];
    
    if ( availableStatusAction == nil )
    {
        availableStatusAction = [TaskAvailableStatusAction MR_createEntityInContext: context];
    }
    
    availableStatusAction.statusActionID          = info.statusActionID;
    availableStatusAction.stautsActionDescription = info.stautsActionDescription;
    availableStatusAction.availableActionsList    = availableAction;
}

- (void) persistTaskAvailableStageAction: (TaskStagesActionModel*)    info
                 forAvailableActionsList: (TaskAvailableActionsList*) availableAction
                               inContext: (NSManagedObjectContext*)   context
{
    NSPredicate* findPredicate = [NSPredicate predicateWithFormat: @"stageActionID == %@ AND availableActionsList == %@", info.stageActionID, availableAction];
    
    TaskAvailableStagesAction* stageAction = [TaskAvailableStagesAction MR_findFirstWithPredicate: findPredicate
                                                                                        inContext: context];
    
    if ( stageAction == nil )
    {
        stageAction = [TaskAvailableStagesAction MR_createEntityInContext: context];
    }
    
    stageAction.stageActionID        = info.stageActionID;
    stageAction.title                = info.title;
    stageAction.isCommon             = info.isCommon;
    stageAction.availableActionsList = availableAction;
}

@end
