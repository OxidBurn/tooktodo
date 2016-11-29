//
//  RolesViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RolesViewModel.h"

// Classes
#import "OSCellWithCheckmark.h"
#import "InviteInfo.h"
#import "RolesModel.h"

@interface RolesViewModel()

@property (strong, nonatomic) NSIndexPath     * lastIndexPath;
@property (nonatomic, strong) RolesModel      * model;
@property (nonatomic, strong) NSArray* indexesArray;

@end

@implementation RolesViewModel


#pragma mark - Properties -

- (RolesModel*) model
{
    if (_model == nil)
    {
        _model = [RolesModel new];
    }
    
    return _model;
}

- (RACSignal*) updateRolesInfo
{
    return [self.model updateRolesInfo];
}

- (NSArray*) indexesArray
{
    if ( _indexesArray == nil || _indexesArray.count == 0 )
    {
        NSUInteger numberOfRows = [self.model countOfRows];
        
        NSMutableArray* tmp = [NSMutableArray array];
        
        for (NSUInteger i; i < numberOfRows; i++)
        {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow: i
                                                        inSection: 0];
            
            [tmp addObject: indexPath];
            
        }
        
        _indexesArray = tmp.copy;
        tmp = nil;
    }
    
    return _indexesArray;
}

#pragma mark - Public -

- (ProjectRoles*) getSelectedItem;
{
  return [self.model getSelectedItem];
}


#pragma mark - Table view data source

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)section
{
    return [self.model countOfRows];
}

-(UITableViewCell*) tableView: (UITableView*) tableView
        cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    NSString* reuseIdentifier = @"checkMarkCellID";
    
    OSCellWithCheckmark* cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier];
    
    [cell fillCellWithContent: [self.model getRoleNameByIndex: indexPath]
            withSelectedState: [self.model handleSelectedStateForRole: indexPath]];
    
    return cell;
}

#pragma mark - TableView Delegate methods -

- (void)        tableView: (UITableView*) tableView
  didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    [self.model updateLastIndexPath: indexPath];
    
//    [tableView reloadData];
    
    [tableView reloadRowsAtIndexPaths: self.indexesArray
                     withRowAnimation: UITableViewRowAnimationFade];
}




@end
