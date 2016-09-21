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

typedef NS_ENUM(NSInteger, Permission)
{
    SystemAdministrator = -1,
    Participant         = 0,
    Owner               = 1,
    Administrator       = 2,
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
        _detailLabelsContent = @[self.memberInfo.role ? self.memberInfo.role : @"", [self setPermission: self.memberInfo.projectPermission.integerValue]];
    }
    
    return _detailLabelsContent;
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

- (FilledTeamInfo*) memberInfo
{
    if (_memberInfo == nil)
    {
        _memberInfo = [FilledTeamInfo new];
        [_memberInfo fillTeamInfo: self.assignment];
    }
    
    return _memberInfo;
}

#pragma mark - Public methods -

- (RACSignal*) updateUserInfo
{
    @weakify(self)
    
    RACSignal* updateUserInfo = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[RACScheduler mainThreadScheduler] schedule: ^{
            
            @strongify(self)
            
            self.assignment = [DataManagerShared getSelectedProjectRoleAssignment];
            
            [self.memberInfo fillTeamInfo: self.assignment];
            
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

- (UIImage*) getAvatar
{
    return [UIImage imageWithContentsOfFile: [[Utils getAvatarsDirectoryPath] stringByAppendingString: self.memberInfo.avatarSrc]];
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
    [DataManagerShared updateTeamMemberPermission: permission
                                   withCompletion: ^(BOOL isSuccess) {
                                       
                                       self.assignment.projectPermission = @(permission);
                                   }];
}

//- (void) updateMemberRole: (ProjectRoles*) role
//{
//    [DataManagerShared updateTeamMemberRole: role
//                             withCompletion:^(BOOL isSuccess) {
//                                 
//                                 FilledTeamInfo* teamMember = [FilledTeamInfo new];
//                                 [teamMember fillTeamInfo: self.assignment];
//                                 
//                                 teamMember.role = role.title;
//                                 
//                            }];
//}

- (void) updateMemberRole: (NSString*) role
{
    [DataManagerShared updateTeamMemberRole: role
                             withCompletion:^(BOOL isSuccess) {
                                 
                                 FilledTeamInfo* teamMember = [FilledTeamInfo new];
                                 [teamMember fillTeamInfo: self.assignment];
                                 
                                 teamMember.role = role;
                                 
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
    return self.roleCellsContent[indexPath.row];
}

- (NSString*) getDetailRoleCellLabelTextForIndexPath: (NSIndexPath*) indexPath
{
    return self.detailLabelsContent[indexPath.row];
}

- (NSString*) setPermission: (NSUInteger) permission
{
    switch (permission)
    {
        case SystemAdministrator:
            return @"Системный администратор";
            break;
        case Participant:
            return @"Участник проекта";
            break;
        case Owner:
            return @"Владелец";
            break;
        case Administrator:
            return @"Адмиистратор";
            break;
            
        default:
            break;
    }
    
    return @"";
}
@end
