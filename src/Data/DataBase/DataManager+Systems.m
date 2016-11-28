//
//  DataManager+Systems.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+Systems.h"

// Classes
#import "ProjectSystemsModel.h"
#import "ProjectInfo+CoreDataClass.h"

// Categories
#import "DataManager+ProjectInfo.h"

@implementation DataManager (Systems)


#pragma mark - Public methods -

- (void) persistSystemsForProject: (NSArray*)              systems
                   withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
     
        ProjectInfo* currentProject = [DataManagerShared getSelectedProjectInfoInContext: localContext];
        
        [systems enumerateObjectsUsingBlock: ^(ProjectSystemsModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistNewSystemForProject: obj
                                  forProject: currentProject
                                   inContext: localContext];
            
        }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (NSArray*) getAllSystemsForCurrentProject
{
    ProjectInfo* currentProject = [DataManagerShared getSelectedProjectInfo];
    
    NSSortDescriptor* alphabeticalTitleSort      = [NSSortDescriptor sortDescriptorWithKey: @"title"
                                                                                 ascending: YES];
    NSSortDescriptor* alphabeticalShortTitleSort = [NSSortDescriptor sortDescriptorWithKey: @"shortTitle"
                                                                                 ascending: YES];
    
    NSArray* systems = [currentProject.systems.array sortedArrayUsingDescriptors: @[alphabeticalTitleSort, alphabeticalShortTitleSort]];
    
    return systems;
}


#pragma mark - Internal methods -

- (void) persistNewSystemForProject: (ProjectSystemsModel*)   info
                         forProject: (ProjectInfo*)            project
                          inContext: (NSManagedObjectContext*) context
{
    ProjectSystem* system = [self getSystemWithID: info.systemID
                                        inProject: project
                                        inContext: context];
    
    if ( system == nil )
    {
        system = [ProjectSystem MR_createEntityInContext: context];
        
        system.systemID   = info.systemID;
        system.title      = info.title;
        system.shortTitle = info.shortTitle;
        system.hasTasks   = @(info.hasTasks);
        system.project    = project;
    }
    else
    {
        system.title      = info.title;
        system.shortTitle = info.shortTitle;
        system.hasTasks   = @(info.hasTasks);
    }
}

- (ProjectSystem*) getSystemWithID: (NSNumber*)               systemID
                         inProject: (ProjectInfo*)            project
                         inContext: (NSManagedObjectContext*) context
{
    NSPredicate* findPredicate = [NSPredicate predicateWithFormat: @"systemID == %@ AND project == %@", systemID, project];
    
    ProjectSystem* system = [ProjectSystem MR_findFirstWithPredicate: findPredicate
                                                           inContext: context];
    
    return system;
}

@end
