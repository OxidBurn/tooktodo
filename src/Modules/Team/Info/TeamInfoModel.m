//
//  TeamInfoModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamInfoModel.h"

// Classes
#import "TeamService.h"
#import "ProjectInfo+CoreDataClass.h"

// Categories
#import "DataManager+ProjectInfo.h"

@interface TeamInfoModel()

// properties

@property (strong, nonatomic) NSArray* teamList;

@property (strong, nonatomic) NSArray* filteringList;

@property (assign, nonatomic) FilteringMemebersState memberListState;

// methods


@end

@implementation TeamInfoModel

#pragma mark - Public methods -

- (NSString*) getProjectName
{
    ProjectInfo* projectInfo = [DataManagerShared getSelectedProjectInfo];
    
    return projectInfo.title;
}

- (void) updateTeamInfoWithCompletion: (CompletionWithSuccess) completion
{
    [[[[TeamService sharedInstance] getTeamInfo] subscribeOn: [RACScheduler mainThreadScheduler]]
    subscribeNext: ^(NSArray* teamInfo) {
        
        self.teamList = teamInfo;
        
        if ( completion )
            completion(YES);
        
    }
    error: ^(NSError *error) {
        
        if ( completion )
            completion(NO);
        
    }
    completed: ^{
        
        if ( completion )
            completion(YES);
        
    }];
}

- (NSUInteger) countOfItems
{
    switch (self.memberListState)
    {
        case TableNormalState:
        {
            return self.teamList.count;
            break;
        }
        case TableFilteringState:
        {
            return self.filteringList.count;
            break;
        }
    }
    
    return 0;
}

- (ProjectRoleAssignments*) teamMemberByIndex: (NSUInteger) index
{
    switch (self.memberListState)
    {
        case TableNormalState:
        {
            return self.teamList[index];
            break;
        }
        case TableFilteringState:
        {
            return self.filteringList[index];
            break;
        }
    }
    
    return nil;
}

- (NSString*) getEmailOfMemberAtIndex: (NSUInteger) index
{
    ProjectRoleAssignments* member = [self teamMemberByIndex: index];
    
    return @"";
}

- (void) handleCallForUserAtIndex: (NSUInteger) index
{
    TeamMember* teamMember = [self teamMemberByIndex: index];
    
    if ( teamMember.phoneNumber.length > 0 && teamMember.additionalPhoneNumber.length > 0 )
    {
        if ( [self.delegate respondsToSelector: @selector(returnPhoneNumbers:with:)] )
        {
            [self.delegate returnPhoneNumbers: teamMember.phoneNumber
                                         with: teamMember.additionalPhoneNumber];
        }
    }
    else
    {
        // call
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: [NSString stringWithFormat: @"tel://%@", teamMember.phoneNumber]]];
    }
    
}

- (void) markItemAsSelectedAtIndex: (NSUInteger) index
{
    TeamMember* member = [self teamMemberByIndex: index];
    
    [DataManagerShared changeItemSelectedState: YES
                                       forItem: member];
}


#pragma mark - Filtering -

- (void) stopFiltering
{
    self.filteringList   = nil;
    self.memberListState = TableNormalState;
}

- (void) startFiltering
{
    self.memberListState = TableFilteringState;
    self.filteringList   = self.teamList.copy;
}

- (BOOL) isEnableFiltering
{
    return (self.memberListState == TableFilteringState);
}

- (void) filteringWithKeyWord: (NSString*) keyWord
{
    if ( keyWord.length > 0 )
    {
        NSPredicate* filteredPredicate = [NSPredicate predicateWithFormat: [self getFilteringPredicateFormatString], keyWord, keyWord, keyWord, keyWord, keyWord];
        
        self.filteringList = [self.teamList filteredArrayUsingPredicate: filteredPredicate];
    }
    else
    {
        self.filteringList = self.teamList;
    }
}

- (NSString*) getFilteringPredicateFormatString
{
    return @"(SELF.firstName CONTAINS[c] %@) OR (SELF.lastName CONTAINS[c] %@) OR (SELF.phoneNumber CONTAINS[c] %@) OR (SELF.additionalPhoneNumber CONTAINS[c] %@) OR (SELF.email CONTAINS[c] %@)";
}

@end
