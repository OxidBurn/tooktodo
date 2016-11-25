//
//  TaskFilterViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskFilterViewModel.h"

// Classes
#import "TaskFilterModel.h"
#import "TaskFilterMainFactory.h"
#import "FilterByTermsCell.h"
#import "FilterByAssigneeViewController.h"

typedef NS_ENUM(NSUInteger, SectionOneRows)
{
    FilterByCreatorsRow,
    FilterByResponsibleRow,
    FilterByApproversRow,
};

@interface TaskFilterViewModel() <FilterByTermsCellDelegate, FilterByAssigneeViewControllerDelegate>

// properties
@property (strong, nonatomic) TaskFilterModel* model;

@property (strong, nonatomic) NSArray* termsCellsIndexesArray;

// methods


@end

@implementation TaskFilterViewModel

#pragma mark - Properties -

- (TaskFilterModel*) model
{
    if ( _model == nil )
    {
        _model = [TaskFilterModel new];
    }
    
    return _model;
}

- (NSArray*) termsCellsIndexesArray
{
    if ( _termsCellsIndexesArray == nil )
    {
        _termsCellsIndexesArray = @[ [NSIndexPath indexPathForRow: 0 inSection: SectionTwo],
                                     [NSIndexPath indexPathForRow: 1 inSection: SectionTwo]];
    }
    
    return _termsCellsIndexesArray;
}


#pragma mark - UITableViewDataSource methods -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 4;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model getNumberOfRowsIsSection: section];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    UITableViewCell* cell = [UITableViewCell new];
    
    TaskFilterMainFactory* factory = [TaskFilterMainFactory new];
    
    TaskFilterRowContent* content = [self.model getRowContentForIndexPath: indexPath];
    
    cell = [factory createCellForTableView: tableView
                            withRowContent: content
                              withDelegate: self];
    
    return cell;
}

- (CGFloat)    tableView: (UITableView*) tableView
heightForHeaderInSection: (NSInteger)    section
{
    CGFloat height = 0;
    
    if ( section != SectionOne )
    {
        height = 10;
    }
    
    return height;
}

- (CGFloat)   tableView: (UITableView*) tableView
heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    CGFloat height = 41;
    
    if ( indexPath.section == SectionTwo )
        height = [self.model getRowHeightForRowAtIndexPath: indexPath];
    
    return height;
}


#pragma mark - UITableViewDelegate methods -

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    NSString* segueId = [self.model getSegueIdForIndexPath: indexPath];
    
    switch ( indexPath.section)
    {
        case SectionOne:
        {
            switch ( indexPath.row )
            {
                case FilterByCreatorsRow:
                {
                    if ( self.showFilterByAssigneeWithType )
                        self.showFilterByAssigneeWithType(FilterByCreator, segueId);
                }
                    break;
                    
                case FilterByResponsibleRow:
                {
                    if ( self.showFilterByAssigneeWithType )
                        self.showFilterByAssigneeWithType(FilterByResponsible, segueId);
                }
                    break;
                    
                case FilterByApproversRow:
                {
                    if ( self.showFilterByAssigneeWithType )
                        self.showFilterByAssigneeWithType(FilterByApprovers, segueId);
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
            
        case SectionTwo:
        {
            [self.model didSelectTermsCellForIndexPath: indexPath];
            
            [tableView reloadRowsAtIndexPaths: self.termsCellsIndexesArray
                             withRowAnimation: UITableViewRowAnimationFade];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Public -

- (void) fillFilterType: (TasksFilterType) filterType
{
    [self.model fillFilterType: filterType];
}

- (TaskFilterConfiguration*) getFilterConfig
{
    return [self.model getFilterConfig];
}


#pragma mark - FilterByTermsCellDelegate methods -

- (void) showFilterByDatesWithType: (FilterByDateViewControllerType) controllerType
{
    if ( self.showFilterByTermsWithType )
        self.showFilterByTermsWithType(controllerType);
    
    if ( self.reloadTableView )
        self.reloadTableView();
}


#pragma mark - FilterByAssigneeDelegate methods -

- (void) returnSelectedAssigneesArray: (NSArray*)             selectedAssignees
                       withFilterType: (FilterByAssigneeType) filterType
                          withIndexes: (NSArray*)             indexesArray
{
    [self.model fillSelectedAssigneesData: selectedAssignees
                              withIndexes: indexesArray
                            forFilterType: filterType];
    
    if ( self.reloadTableView )
        self.reloadTableView();
}


@end
