//
//  DataManager+Team.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+Team.h"

// Classes
#import "TeamMemberObject.h"
#import "AvatarHelper.h"
#import "Utils.h"

// Categories
#import "DataManager+ProjectInfo.h"

@implementation DataManager (Team)


#pragma mark - Public methods -

- (void) persistTeamMemebers: (NSArray*)              teamList
                   inProject: (ProjectInfo*)          project
              withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        [teamList enumerateObjectsUsingBlock: ^(TeamMemberObject* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistNewTeamMember: obj
                             inProject: project
                             inContext: localContext];
            
        }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if (completion )
                              completion(contextDidSave);
                          
                      }];
}

- (NSArray*) getAllTeamInfo
{
    ProjectInfo* selectedProject = [DataManagerShared getSelectedProjectInfoInContext: [NSManagedObjectContext MR_defaultContext]];
    
    return selectedProject.team.allObjects;
}

- (void) changeItemSelectedState: (BOOL)        isSelected
                         forItem: (TeamMember*) member
{
    member.isSelected = @(isSelected);
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
}

- (TeamMember*) getSelectedItem
{
    TeamMember* member = [TeamMember MR_findFirstByAttribute: @"isSelected"
                                                   withValue: @(YES)
                                                   inContext: [NSManagedObjectContext MR_defaultContext]];
    
    return member;
}

#pragma mark - Internal methods -

- (void) persistNewTeamMember: (TeamMemberObject*)       object
                    inProject: (ProjectInfo*)            project
                    inContext: (NSManagedObjectContext*) context
{
    TeamMember* member = [self getMemberWithID: object.memberID
                                     inProject: project
                                     inContext: context];
    
    if ( member == nil )
    {
        member = [TeamMember MR_createEntityInContext: context];
        
        [self generateAvatarForMember: member
                             withInfo: object];
    }
    
    member.firstName             = object.firstName;
    member.lastName              = object.lastName;
    member.email                 = object.email;
    member.patronymicName        = object.patronymicName;
    member.comment               = object.comment;
    member.phoneNumber           = object.phoneNumber;
    member.additionalPhoneNumber = object.additionalPhoneNumber;
    member.comment               = object.comment;
    member.userID                = object.memberID;
    member.createrUserId         = object.createrUserId;
    member.project               = [self getSelectedProjectInfoInContext: context];
}

- (void) generateAvatarForMember: (TeamMember*)       member
                        withInfo: (TeamMemberObject*) info
{
    NSString* fullNameAbbreviation = [Utils getAbbreviationWithName: info.firstName
                                                        withSurname: info.lastName];
    NSString* fileName = (info.memberID.stringValue.length > 0) ? info.memberID.stringValue : [NSString stringWithFormat: @"%@%@", info.firstName, info.lastName];
    
    member.avatarPath              = [[AvatarHelper sharedInstance] generateAvatarForName: fileName
                                                                         withAbbreviation: fullNameAbbreviation
                                                                            withImageSize: CGSizeMake(20, 20)];
}

- (TeamMember*) getMemberWithID: (NSNumber*)               memberID
                      inProject: (ProjectInfo*)            project
                      inContext: (NSManagedObjectContext*) context
{
    return [TeamMember MR_findFirstByAttribute: @"userID"
                                     withValue: memberID
                                     inContext: context];
}

@end
