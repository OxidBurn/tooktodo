//
//  RolesViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RolesViewModel.h"

// Classes
#import "InviteInfo.h"
#import "RolesService.h"
#import "ProjectRoles.h"


@interface RolesViewModel()

@property (nonatomic, strong) NSArray         * rolesArray;
@property (strong, nonatomic) NSIndexPath     * lastIndexPath;
@property (nonatomic, strong) NSString        * chosenRole;
@property (nonatomic, strong) InviteInfo      * user;
@property (nonatomic, strong) UITableViewCell * cell;

@end

@implementation RolesViewModel

#pragma mark - Initialization -

- (instancetype) init
{
    if ( self = [super init] )
    {
        
    }
    
    return self;
}

#pragma mark - Properties -

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



- (InviteInfo*) user
{
    if (_user == nil)
    {
        _user = [[InviteInfo alloc] init];
    }
    
    return _user;
}

#pragma mark - Public -

- (ProjectRoles*) getSelectedItem;
{
    if ( self.lastIndexPath.row < self.rolesArray.count )
        return self.rolesArray[self.lastIndexPath.row];
    else
        return nil;
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
    
    
    ProjectRoles* role = self.rolesArray[indexPath.row];
    
    self.cell.textLabel.text = role.title;
    
    UIFont* unselectedCustomFont = [UIFont fontWithName: @"SFUIText-Regular"
                                         size: 13.0f];
    
    UIFont* selectedCustomFont = [UIFont fontWithName: @"SFUIText-Medium"
                                                   size: 13.0f];
    
    if ([indexPath compare: self.lastIndexPath] == NSOrderedSame)
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
