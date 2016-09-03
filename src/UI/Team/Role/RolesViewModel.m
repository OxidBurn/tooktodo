//
//  RolesViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RolesViewModel.h"
#import "InviteInfo.h"

@interface RolesViewModel()

@property (nonatomic, strong) NSArray* rolesArray;
@property (strong, nonatomic) NSIndexPath* lastIndexPath;
@property (nonatomic, strong) NSString* chosenRole;
@property (nonatomic, strong) InviteInfo* user;
@property (nonatomic, strong) UITableViewCell* cell;

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
    
    self.cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier
                                                forIndexPath: indexPath];
    if (self.cell == nil)
    {
        self.cell = [[UITableViewCell alloc] init];
    }
    
    
    NSString* role = self.rolesArray[indexPath.row];
    
    self.cell.textLabel.text = role;
    
    UIFont* unselectedCustomFont = [UIFont fontWithName: @"SFUIText-Regular"
                                         size: 13.0f];
    
    UIFont* selectedCustomFont = [UIFont fontWithName: @"SFUIText-Medium"
                                                   size: 13.0f];
    
    if ([indexPath compare:self.lastIndexPath] == NSOrderedSame)
    {
        self.cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.cell.textLabel.font = selectedCustomFont;
    }
    else
    {
        self.cell.accessoryType = UITableViewCellAccessoryNone;
        self.cell.textLabel.font = unselectedCustomFont;
    }
    
    return self.cell;
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
