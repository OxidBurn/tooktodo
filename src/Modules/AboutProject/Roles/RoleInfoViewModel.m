//
//  RoleInfoViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RoleInfoViewModel.h"

// Classes
#import "RoleInfoModel.h"
#import "ProjectRoles.h"

@interface RoleInfoViewModel()

// properties

@property (strong, nonatomic) RoleInfoModel* model;

// methods


@end

@implementation RoleInfoViewModel


#pragma mark - Properties -

- (RoleInfoModel*) model
{
    if ( _model == nil )
    {
        _model = [[RoleInfoModel alloc] init];
    }
    
    return _model;
}


#pragma mark - Public methods -

- (RACSignal*) updateInfo
{
    return [self.model updateInfo];
}


#pragma mark - UITable view data source methods -

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model countOfRoleItems];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"RoleCellID"];
    
    ProjectRoles* roleInfo = [self.model getRoleInfoAtIndex: indexPath.row];
    
    cell.textLabel.text = roleInfo.title;
    
    return cell;
}




@end
