//
//  RolesModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 02.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RolesModel.h"

@interface RolesModel ()

@property (nonatomic, strong) NSArray* rolesArray;

@property (strong, nonatomic) NSIndexPath* lastIndexPath;

@property (nonatomic, strong) NSString* selectedRoleTitle;

@end

@implementation RolesModel


#pragma mark - Public -

- (RACSignal*) updateRolesInfo
{
    @weakify(self)
    
    RACSignal* fetchRolesSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[RolesService sharedInstance] getRolesOfTheSelectedProject] subscribeNext: ^(NSArray* roles) {
            
            @strongify(self)
            
            if ( roles.count > 0 )
            {
                self.rolesArray = roles;
                
                [subscriber sendNext: nil];
                [subscriber sendCompleted];
            }
            else
            {
                [self loadDefaultRolesWithCompletion: ^(BOOL isSuccess) {
                    
                    [[[RolesService sharedInstance] getDefaultRoles] subscribeNext: ^(NSArray* roles) {
                        
                        self.rolesArray = roles;
                        
                        [subscriber sendNext: nil];
                        [subscriber sendCompleted];
                        
                    }];
                    
                }];
            }
        }];
        
        return nil;
    }];
    
    return fetchRolesSignal;
}


- (NSUInteger) countOfRows
{
    return self.rolesArray.count;
}

- (NSString*) getRoleNameByIndex: (NSIndexPath*) indexPath
{
    ProjectRoles* role  = self.rolesArray[indexPath.row];
    
    return role.title;
}

- (void) updateLastIndexPath: (NSIndexPath*)          indexPath
              withCompletion: (CompletionWithSuccess) completion
{
    self.lastIndexPath = indexPath;
    
    if ( completion )
        completion (YES);
}

- (BOOL) handleSelectedStateForRole: (NSIndexPath*) indexPath
{
    if ( [ indexPath isEqual: self.lastIndexPath] )
    {
        return YES;
    }
    
    else
        return NO;
}

- (ProjectRoles*) getSelectedItem
{
    if ( self.lastIndexPath )
        return self.rolesArray[self.lastIndexPath.row];
    else
        return nil;
}

- (void) fillSelectedRole: (NSString*) role
{
    self.selectedRoleTitle = role;
}

- (void) updateSelectedRole
{
        [self.rolesArray enumerateObjectsUsingBlock: ^(ProjectRoles*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
            if ([obj.title isEqualToString: self.selectedRoleTitle])
            {
                self.lastIndexPath = [NSIndexPath indexPathForRow: idx
                                                        inSection: 0];
            }
        }];
}

#pragma mark - Internal -

- (void) loadDefaultRolesWithCompletion: (CompletionWithSuccess) completion
{
    if ([UserDefaults boolForKey: @"isLoadedNewVersion"] == NO )
    {
        [[[RolesService sharedInstance] loadDefaultListOfRoles] subscribeNext: ^(id x) {
            
            [UserDefaults setBool: YES
                           forKey: @"isLoadedNewVersion"];
            [UserDefaults synchronize];
            
            if ( completion )
                completion(YES);
            
        }];
    }
    else
    {
        if ( completion )
            completion(YES);
    }
}

@end
