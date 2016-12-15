//
//  TeamProfileInfoModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 06.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamProfileInfoModel.h"

// Classes
#import "ProjectRoleAssignments+CoreDataClass.h"
#import "ProjectTaskAssignee+CoreDataClass.h"
#import "ProjectInviteInfo+CoreDataClass.h"
#import "FilledTeamInfo.h"
#import "Utils.h"
#import "TeamService.h"
#import "ProjectsEnumerations.h"

// Categories
#import "DataManager+Tasks.h"
#import "DataManager+ProjectInfo.h"
#import "DataManager+Team.h"

typedef NS_ENUM(NSUInteger, ContactType)
{
    ContactPhoneNumberType,
    ContactAdditionalPhoneNumberType,
    ContactEmailType,
};

@interface TeamProfileInfoModel ()

// properties
@property (strong, nonatomic) ProjectRoleAssignments* assignment;

@property (nonatomic, strong) FilledTeamInfo* memberInfo;

@property (nonatomic, strong) NSArray* contactsContent;

@property (strong, nonatomic) NSArray* roleCellsContent;

@property (strong, nonatomic) NSArray* detailLabelsContent;

@end


@implementation TeamProfileInfoModel

#pragma mark - Properties -

- (NSArray*) roleCellsContent
{
    if ( _roleCellsContent == nil )
    {
        _roleCellsContent = @[@"Роль в проекте", @"Права доступа"];
    }
    
    return _roleCellsContent;
}

- (NSArray*) detailLabelsContent
{
    if (_detailLabelsContent == nil)
    {
        _detailLabelsContent = @[ self.memberInfo.role ? self.memberInfo.role : @"",
                                 [self setPermission: self.memberInfo.projectPermission.integerValue]];
    }
    
    return _detailLabelsContent;
}

- (ProjectRoles*) getCurrentMemberRoleForIndexPath: (NSIndexPath*) indexPath
{
    ProjectRoles* role = self.detailLabelsContent[1][0];
    
    return role;
}

- (void) reloadContent
{
    self.detailLabelsContent = nil;
}

- (NSArray*) contactsContent
{
    if (_contactsContent == nil)
    {
        _contactsContent = [self returnContactsInfo];
    }
    
    return _contactsContent;
}

- (ProjectRoleAssignments*) assignment
{
    if (_assignment == nil)
    {
        _assignment = [DataManagerShared getSelectedProjectRoleAssignment];
    }
    
    return _assignment;
}


#pragma mark - Public methods -

- (RACSignal*) updateUserInfo
{
    @weakify(self)
    
    RACSignal* updateUserInfo = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[RACScheduler mainThreadScheduler] schedule: ^{
            
            @strongify(self)
            
            [subscriber sendNext: self.memberInfo];
            [subscriber sendCompleted];
            
        }];
        
        return nil;
    }];
    
    return updateUserInfo;
}

- (NSInteger) countOfContactsContent
{
    return self.contactsContent.count;
}

- (NSInteger) secondSectionRowCount
{
    if ([self checkIfTeamMemberBlockedOrInvited] == YES)
    {
        return 1;
    }
   
    else return 2;
}

- (NSString*) getEmail
{
    return self.memberInfo.email ? self.memberInfo.email : @"";
}

- (NSString*) getPhone
{
    return self.memberInfo.phoneNumber ? self.memberInfo.phoneNumber : @"";
}

- (NSString*) getAdditionalPhone
{
    return self.memberInfo.additionalPhoneNumber ? self.memberInfo.additionalPhoneNumber : @"";
}


- (NSString*) getMemberName
{
    return [NSString stringWithFormat: @"%@ %@", self.memberInfo.firstName, self.memberInfo.lastName];
}

- (NSString*) getAvatar
{
    return self.memberInfo.avatarSrc;
}

- (NSString*) getRole
{
    return self.memberInfo.role ? self.memberInfo.role : @"";
}

- (NSNumber*) getPermissions
{
    return self.memberInfo.projectPermission ? self.memberInfo.projectPermission : @(-2);
}

- (NSArray*) returnContactsInfo
{
    NSMutableArray* tmp = [NSMutableArray new];
    
    if ([self getPhone] && ![[self getPhone] isEqualToString: @""])
    {
        NSDictionary* dic = @{ @"Contact" : [self getPhone],
                               @"Action"  : @(ContactPhoneNumberType),
                               @"Btn"     : [UIImage imageNamed: @"Phone"]};
        [tmp addObject: dic];
        
    };
    
    
    if ([self getAdditionalPhone] && ![[self getAdditionalPhone] isEqualToString: @""])
    {
        NSDictionary* dic = @{ @"Contact" : [self getAdditionalPhone],
                               @"Action"  : @(ContactAdditionalPhoneNumberType),
                               @"Btn"     : [UIImage imageNamed: @"Phone"]};
        [tmp addObject: dic];
        
    };
    
    if ([self getEmail] )
    {
        NSDictionary* dic = @{ @"Contact" : [self getEmail],
                               @"Action"  : @(ContactEmailType),
                               @"Btn"     : [UIImage imageNamed: @"Mail"]};
        
        if (![dic[@"Contact"] isEqualToString: @""])
        {
            [tmp addObject: dic];
        }
    };
    
    return tmp.copy;
    
}

- (void) updateMemberPermission: (NSInteger) permission
{
    [[[TeamService sharedInstance] updateSelectedUserPermission: permission
                                                  withProjectID: self.memberInfo.projectID
                                                     withUserID: self.memberInfo.memberID]
     subscribeNext: ^(id x) {
         
        
         
     }
     error: ^(NSError *error) {
         
         NSLog(@"Server error with updating user permission: %@", error.localizedDescription);
         
     }
     completed: ^{
         
         [DataManagerShared updateTeamMemberPermission: permission
                                        withCompletion:^(BOOL isSuccess) {
                                            
                                            self.memberInfo.projectPermission = @(permission);
                                            
                                        }];
     }];
    
    self.memberInfo.projectPermission = @(permission);
}

- (void) updateMemberRole: (ProjectRoles*)         role
           withCompletion: (CompletionWithSuccess) completion
{
    @weakify(self)
    
    [[[TeamService sharedInstance] updateSelectedUserRole: role
                                               withUserID: self.memberInfo.userId]
     subscribeNext: ^(id x) {
         
        @strongify(self)
        
        [DataManagerShared updateTeamMemberRole: role
                                    forAssignee: self.memberInfo.assignments
                                 withCompletion: ^(BOOL isSuccess) {
                                     
                                     self.memberInfo.role = role.title;
                                     
                                     if ( completion )
                                         completion(isSuccess);
                                 }];
        
    }
     
     error: ^(NSError *error) {
                                                                             
     }];
}

- (NSInteger) getCurrentUserPermission
{
    NSInteger permissionForProject = [DataManagerShared getSelectedProjectPermission];
    
    return permissionForProject;
    
}

- (NSString*) getContactValueForIndexPath: (NSIndexPath*) indexPath
{
    NSDictionary* temp = self.contactsContent[indexPath.row];
    
    return temp[@"Contact"];
}

- (UIImage*) getBtnImageForIndexPath: (NSIndexPath*) indexPath
{
    NSDictionary* temp = self.contactsContent[indexPath.row];
    
    return temp[@"Btn"];
}

- (void) performActionForIndex: (NSUInteger)index
{
    NSDictionary* dic = self.contactsContent[index];
    
    NSString* contact      = dic[@"Contact"];
    ContactType actionType = [dic[@"Action"] integerValue];
    
    switch (actionType)
    {
        case ContactPhoneNumberType:
        {
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: [NSString stringWithFormat: @"tel://%@", contact]]];
            break;
        }
        case ContactAdditionalPhoneNumberType:
        {
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: [NSString stringWithFormat: @"tel://%@", contact]]];
            break;
        }
        case ContactEmailType:
        {
            if ( [self.delegate respondsToSelector: @selector(sendEmailToAdress:)] )
            {
                [self.delegate sendEmailToAdress: contact];
            }
            break;
        }
    }
}

- (NSString*) getRoleInfoCellLabelTextForIndexPath: (NSIndexPath*) indexPath
{
    if ([self checkIfTeamMemberBlockedOrInvited] == YES)
    {
        NSMutableArray* tmpCellContentArray = self.roleCellsContent.mutableCopy;
        
        [tmpCellContentArray removeObject: @"Права доступа"];
        
        self.roleCellsContent = tmpCellContentArray.copy;
    }
    
    return self.roleCellsContent[indexPath.row];
}

- (NSString*) getDetailRoleCellLabelTextForIndexPath: (NSIndexPath*) indexPath
{
    return self.detailLabelsContent[indexPath.row];
}


- (NSString*) setPermission: (PermissionTypeList) permission
{
    switch (permission)
    {
        case SystemAdminPermission:
            return @"Системный администратор";
            break;
        case ParticipantPermission:
            return @"Участник проекта";
            break;
        case OwnerPermission:
            return @"Владелец";
            break;
        case AdminPermission:
            return @"Администратор";
            break;
            
        default:
            break;
    }
    
    return @"";
}

- (void) fillSelectedTeamMember: (FilledTeamInfo*) teamMember
{
    self.memberInfo = teamMember;
}

- (BOOL) checkIfTeamMemberBlockedOrInvited
{
    BOOL isBlocked = self.memberInfo.assignments.isBlocked.boolValue;
    BOOL isInvited = self.memberInfo.assignments.invite != nil;
    
    BOOL disabled = (isBlocked == YES || isInvited);
    
    return disabled;
}

@end
