//
//  AddTaskViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskViewModel.h"

// Classes
#import "AddTaskModel.h"
#import "OSFlexibleTextFieldCell.h"

@interface AddTaskViewModel() <OSFlexibleTextFieldCellDelegate>

// properties
@property (strong, nonatomic) AddTaskModel* model;

// methods


@end


@implementation AddTaskViewModel

#pragma mark - Properties -

- (AddTaskModel*) model
{
    if ( _model == nil )
    {
        _model = [AddTaskModel new];
    }
    
    return _model;
}

#pragma mark - UITableView data source -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 3;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model getNumberOfRowsForSection: section];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    return [self.model createCellForTableView: (UITableView*) tableView
                                 forIndexPath: (NSIndexPath*) indexPath];
}

- (UIView*)  tableView: (UITableView*) tableView
viewForHeaderInSection: (NSInteger)    section
{
    switch ( section )
    {
        case 0:
            
            return nil;
            
            break;
            
        case 1 ... 2:
        {
            
            UIView* view = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 20, 10)];
            
            view.backgroundColor = [UIColor lightGrayColor];
        }
            
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)    tableView: (UITableView*) tableView
heightForHeaderInSection: (NSInteger)   section
{
    CGFloat height = 0;
    
    switch ( section )
    {
        case 1 ... 2:
            height = 10;
            
            break;
            
        default:
            break;
    }
    return height;
}

#pragma mark - UITableView delegate -

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    NSString* segueID = [self.model getSegueIdForIndexPath: indexPath];
    
    if ( [self.delegate respondsToSelector: @selector(performSegueWithSegueId:)] )
    {
        [self.delegate performSegueWithSegueId: segueID];
    }
    
    if ( indexPath.section == 0 )
    {
        switch ( indexPath.row )
        {
            case 0:
            {
                OSFlexibleTextFieldCell* cell = [tableView cellForRowAtIndexPath: indexPath];
            
                cell = (OSFlexibleTextFieldCell*)cell;
            
                cell.delegate = self;
            
                [cell editTextLabel];
            }
                break;
            
            default:
                break;
        }
    }
}

#pragma mark - OSFlexibleTextFieldDelegate methods -

- (void) updateFlexibleTextFieldCellWithText: (NSString*) newTaskNameString
{
    [self.model updateTaskNameWithString: newTaskNameString];
    
    if ( [self.delegate respondsToSelector: @selector(reloadAddTaskTableView)] )
    {
        [self.delegate reloadAddTaskTableView];
    }
}


@end
