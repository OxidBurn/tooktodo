//
//  RolesViewModel.m
//  TookTODO
//
//  Created by Lera on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RolesViewModel.h"
#import "InviteInfo.h"

@interface RolesViewModel()

@property (nonatomic, strong) NSArray* rolesArray;
@property (strong, nonatomic) NSIndexPath* lastIndexPath;
@property (nonatomic, strong) NSString* chosenRole;
@property (nonatomic, strong) InviteInfo* user;
@property (nonatomic, assign) NSUInteger index;

@end

@implementation RolesViewModel

#pragma mark - Properties -

- (NSArray*) rolesArray
{
    if (_rolesArray == nil)
    {
        _rolesArray = [NSArray arrayWithObjects: @"Архитектор", @"Генподрядчик", @"Дизайнер", @"Заказчик", @"Технадзор", @"Строитель", @"Прораб", @"Подрядчик", nil];
        
    }
    
    return _rolesArray;
}

- (InviteInfo*) user
{
    if (_user == nil)
    {
        _user = [[InviteInfo alloc] init];
    }
    
    return _user;
}

#pragma mark - Public -

- (NSString*) getSelectedItem;
{
    return self.rolesArray[self.lastIndexPath.row];
}

#pragma mark - Table view data source

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)section
{
    return self.rolesArray.count;
}

-(UITableViewCell*) tableView: (UITableView*) tableView
        cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    NSString* reuseIdentifier = @"cellID";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier
                                                            forIndexPath: indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] init];
    }
    
    NSString* role = self.rolesArray[indexPath.row];
    
    cell.textLabel.text = role;
    
    
    if ([indexPath compare:self.lastIndexPath] == NSOrderedSame)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - TableView Delegate methods -

- (void)        tableView: (UITableView*) tableView
  didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    self.lastIndexPath = indexPath;
    
    [tableView reloadData];
}


@end
