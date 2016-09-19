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

@interface AddTaskViewModel()

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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 20, 10)];
    
    view.backgroundColor = [UIColor lightGrayColor];
    
    return view;
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
    NSString* segueID = [self.model getSegueIdForIndexPath: indexPath];
    
    if ( [self.delegate respondsToSelector: @selector(performSegueWithSegueId:)] )
    {
        [self.delegate performSegueWithSegueId: segueID];
    }
}
@end
