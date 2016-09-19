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
#import "DataManager+Team.h"

typedef NS_ENUM(NSUInteger, ContactType)
{
    ContactPhoneNumberType,
    ContactAdditionalPhoneNumberType,
    ContactEmailType,
};

@interface TeamProfileInfoModel ()

// properties
@property (strong, nonatomic) TeamMember* memberInfo;

@property (nonatomic, strong) NSArray* contactsContent;

@property (strong, nonatomic) NSArray* roleCellsContent;

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

- (NSArray*) contactsContent
{
    if (_contactsContent == nil)
    {
        _contactsContent = [self returnContactsInfo];
    }
    
    return _contactsContent;
}

- (TeamMember*) memberInfo
{
    if (_memberInfo == nil)
    {
        _memberInfo = [DataManagerShared getSelectedItem];
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
            
             self.memberInfo = [DataManagerShared getSelectedItem];
            
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
    return [UIImage imageWithContentsOfFile: [[Utils getAvatarsDirectoryPath] stringByAppendingString: self.memberInfo.avatarPath]];
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
@end
