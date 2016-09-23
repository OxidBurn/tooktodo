//
//  SelectResponsibleModel.m
//  TookTODO
//
//  Created by Глеб on 22.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectResponsibleModel.h"


// Classes
#import "DataManager+Tasks.h"
#import "DataManager+ProjectInfo.h"
#import "TeamService.h"
#import "ProjectInfo+CoreDataClass.h"


@interface SelectResponsibleModel()

// properties
@property (strong, nonatomic) NSArray* membersArray;

@property (assign, nonatomic) BOOL isSelectedResponsible;

@property (assign, nonatomic) MarkOption controllerMarkOption;

// methods


@end

@implementation SelectResponsibleModel

#pragma mark - Properties -

- (NSArray*) membersArray
{
    if ( _membersArray == nil )
    {
        _membersArray = [NSArray new];
    }
    
    return _membersArray;
}


#pragma mark - Public -

- (void) fillContollerMarkOption: (MarkOption) controllerMarkOption
{
    self.controllerMarkOption = controllerMarkOption;
}

- (NSUInteger) getNumberOfRows
{
    return self.membersArray.count;
}

- (FilledTeamInfo*) returnFilledUserInfoForIndex: (NSUInteger) index
{
    return self.membersArray[index];
}

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) indexPath
{
    switch ( self.controllerMarkOption )
    {
        case SingleMark:
        {
            FilledTeamInfo* user = self.membersArray[indexPath.row];
            
            if ( user.isResponsible == NO)
            {
                if ( self.isSelectedResponsible )
                {
                    user.isResponsible = NO;
                }
                else
                {
                    user.isResponsible = YES;
                    
                    self.isSelectedResponsible = YES;
                }
            }
            else
                if ( user.isResponsible )
            {
                user.isResponsible = NO;
                
                self.isSelectedResponsible = NO;
            }
            
        }
            
            break;
            
        case MultipleMarks:
        {
            FilledTeamInfo* user = self.membersArray[indexPath.row];
            
            user.isResponsible = !user.isResponsible;
        }
            break;
            
        default:
            break;
    }
}

- (BOOL) getStateForMemberAtIndex: (NSUInteger) index
{
    FilledTeamInfo* memberInfo = self.membersArray[index];
    
    return memberInfo.isResponsible;
}

- (void) updateTeamInfoWithCompletion: (CompletionWithSuccess) completion
{
    [[[[TeamService sharedInstance] getTeamInfo] subscribeOn: [RACScheduler mainThreadScheduler]]
     subscribeNext: ^(NSArray* teamInfo)
    {
        
         __block NSMutableArray* tmpTeamList = [NSMutableArray array];
         
        [teamInfo enumerateObjectsUsingBlock: ^(ProjectRoleAssignments* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            FilledTeamInfo* teamMemberInfo = [FilledTeamInfo new];
            
            [teamMemberInfo fillTeamInfo: obj];
            
            [tmpTeamList addObject: teamMemberInfo];
            
        }];
         
         self.membersArray = tmpTeamList.copy;
         
         tmpTeamList = nil;
         
         if ( completion )
             completion (YES);
         
     }
     error: ^(NSError* error) {
         
         if ( completion )
             completion (NO);
     }
     completed: ^{
         
         if ( completion )
             completion (YES);
     }];
}

@end
