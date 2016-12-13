//
//  DataManager+TaskApprovements.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+TaskApprovements.h"

// Classes
#import "TaskApprovments+CoreDataClass.h"

@implementation DataManager (TaskApprovements)

- (void) persistNewTaskApprovements: (TaskApprovementsModel*)  info
                            forTask: (ProjectTask*)            task
                          inContext: (NSManagedObjectContext*) context
{
    TaskApprovments* approvement = [self getTaskApprovementWithInfo: info
                                                             inTask: task
                                                          inContext: context];
    
    if ( approvement == nil )
    {
        approvement = [TaskApprovments MR_createEntityInContext: context];
        
        approvement.createDate     = info.createdDate;
        approvement.approverUserId = info.approverUserId;
        approvement.task           = task;
    }
}

- (TaskApprovments*) getTaskApprovementWithInfo: (TaskApprovementsModel*)  info
                                         inTask: (ProjectTask*)            task
                                      inContext: (NSManagedObjectContext*) context
{
    NSPredicate* findPredicate = [NSPredicate predicateWithFormat: @"createDate == %@ AND approverUserId == %@ AND task == %@", info.createdDate, info.approverUserId, task];
    
    TaskApprovments* approvement = [TaskApprovments MR_findFirstWithPredicate: findPredicate
                                                                    inContext: context];
    
    return approvement;
}

@end
