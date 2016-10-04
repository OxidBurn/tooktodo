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
#import "FilledTeamInfo.h"

// Categories
#import "DataManager+ProjectInfo.h"
#import "DataManager+Tasks.h"
#import "NSString+Utils.h"
#import <NSString+AKNumericFormatter.h>

@interface TeamInfoModel()

// properties

@property (strong, nonatomic) NSArray* teamList;

@property (strong, nonatomic) NSArray* filteringList;

@property (nonatomic, strong) NSArray* rawTeamListData;

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
        
        __block NSMutableArray* tmpTeamList = [NSMutableArray array];
        
        [teamInfo enumerateObjectsUsingBlock: ^(ProjectRoleAssignments* obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            FilledTeamInfo* teamMemberInfo = [FilledTeamInfo new];
            
            [teamMemberInfo fillTeamInfo: obj];
            
            [tmpTeamList addObject: teamMemberInfo];
            
        }];
        
    
        self.teamList        = tmpTeamList.copy;
        self.rawTeamListData = teamInfo;
        
        tmpTeamList = nil;
        
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

- (FilledTeamInfo*) teamMemberByIndex: (NSUInteger) index
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
    FilledTeamInfo* assignment = [self teamMemberByIndex: index];
    
    return assignment.email;
}

- (void) handleCallForUserAtIndex: (NSUInteger) index
{
     FilledTeamInfo* member = [self teamMemberByIndex: index];
    
    
    if ( member.phoneNumber.length > 0 && member.additionalPhoneNumber.length > 0 )
    {
        if ( [self.delegate respondsToSelector: @selector(returnPhoneNumbers:with:)] )
        {
            [self.delegate returnPhoneNumbers: member.phoneNumber
                                         with: member.additionalPhoneNumber];
        }
    }
    else
    {
        // call
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: [NSString stringWithFormat: @"tel://%@", member.phoneNumber]]];
    }
    
}


- (void) markItemAsSelectedAtIndex: (NSUInteger) index
{
    ProjectRoleAssignments* roleAssignments = nil;
    FilledTeamInfo* memberInfo              = [self teamMemberByIndex: index];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"roleID == %@", memberInfo.roleID];
    
    roleAssignments = [[self.rawTeamListData filteredArrayUsingPredicate: predicate] firstObject];
    
    [DataManagerShared changeItemSelectedState: YES
                                       forItem: roleAssignments];
    
}


#pragma mark - Filtering -

- (void) stopFiltering
{
    self.filteringList    = nil;
    self.memberListState  = TableNormalState;
}

- (void) startFiltering
{
    self.memberListState  = TableFilteringState;
    self.filteringList    = self.teamList.copy;
}

- (BOOL) isEnableFiltering
{
    return (self.memberListState == TableFilteringState);
}

- (void) filteringWithKeyWord: (NSString*) keyWord
{
    if ( keyWord.length > 0 )
    {
        NSPredicate* filteredPredicate = [NSPredicate predicateWithBlock:^BOOL(FilledTeamInfo* evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) { 
            
            NSString* phoneNumber           = [evaluatedObject.phoneNumber stringContainingOnlyDecimalDigits];
            NSString* additionalPhoneNumber = [evaluatedObject.additionalPhoneNumber stringContainingOnlyDecimalDigits];
            
            return ([evaluatedObject.firstName containsString: keyWord] ||
                    [evaluatedObject.lastName containsString: keyWord] ||
                    [evaluatedObject.email containsString: keyWord] ||
                    [phoneNumber containsString: keyWord] ||
                    [additionalPhoneNumber containsString: keyWord]);
        }];
        
        self.filteringList = [self.teamList filteredArrayUsingPredicate: filteredPredicate];
    }
    else
    {
        self.filteringList = self.teamList;
    }
}

- (NSString*) getFilteringPredicateFormatString
{
    return @"(SELF.firstName CONTAINS[c] %@) OR (SELF.lastName CONTAINS[c] %@) OR (SELF.phoneNumber CONTAINS[cd] %@) OR (SELF.additionalPhoneNumber CONTAINS[c] %@) OR (SELF.email CONTAINS[c] %@)";
}

@end
