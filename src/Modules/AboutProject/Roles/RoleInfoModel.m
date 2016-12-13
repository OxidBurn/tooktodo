//
//  RoleInfoModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RoleInfoModel.h"

// Classes
#import "RolesService.h"

@interface RoleInfoModel()

// properties

@property (strong, nonatomic) NSArray* rolesItems;

// methods


@end

@implementation RoleInfoModel

#pragma mark - Public methods -

- (RACSignal*) updateInfo
{
    @weakify(self)
    
    RACSignal* fetchRolesSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[RolesService sharedInstance] getRolesOfTheSelectedProject] subscribeNext: ^(NSArray* roles) {
            
            @strongify(self)
            
            self.rolesItems = roles;
            
            [subscriber sendNext: nil];
            [subscriber sendCompleted];
            
        }];
        
        return nil;
    }];
    
    return fetchRolesSignal;
}

- (NSUInteger) countOfRoleItems
{
    return self.rolesItems.count;
}

- (ProjectRoles*) getRoleInfoAtIndex: (NSUInteger) index
{
    return self.rolesItems[index];
}



@end
