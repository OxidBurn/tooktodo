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
#import "FilterByStatusViewController.h"
#import "OSSwitchTableCell.h"

typedef NS_ENUM(NSUInteger, SectionOneRows)
{
    FilterByCreatorsRow,
    FilterByResponsibleRow,
    FilterByApproversRow,
    FilterByStatuses,
};

@interface TaskFilterViewModel() <FilterByTermsCellDelegate, FilterByAssigneeViewControllerDelegate, FilterByStatusControllerDelegate, OSSwitchTableCellDelegate>

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
    
    switch ( indexPath.section)
    {
        case SectionOne:
        {
            NSString* segueId = [self.model getSegueIdForIndexPath: indexPath];
            
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
                    
                case FilterByStatuses:
                {
                    if ( self.showControllerWithSegueId )
                        self.showControllerWithSegueId (segueId);
                }
                    
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
            
        case SectionThree:
        {
            NSString* segueId = [self.model getSegueIdForIndexPath: indexPath];
            
            if ( self.showControllerWithSegueId )
                self.showControllerWithSegueId(segueId);
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

- (void) saveFilterConfigurationWithCompletion: (CompletionWithSuccess) completion
{
    [self.model saveFilterConfigurationWithCompletion: completion];
}

- (void) resetFilterConfigurationForCurrentProject: (CompletionWithSuccess) completion
{
    [self.model resetFilterConfigurationForCurrentProject: completion];
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


#pragma mark - FilterByStatusDelegate methods -

- (void) returnSelectedStatusesArray: (NSArray*) selectedStatuses
{
    [self.model fillSelectedStatusesData: selectedStatuses];
    
    if ( self.reloadTableView )
        self.reloadTableView();
}


#pragma mark - OSSwitchTableCellDelegate methods -

- (void) updateFilterParameterWithValue: (BOOL)                           isOn
                                 forTag: (TaskFilterAditionalOptionsTags) tag
{
    [self.model fillSelectedAditionalTermsOptionsWithValue: isOn
                                                    forTag: tag];
}


#pragma mark - AddTaskType delegate methods -

- (void) didSelectedTaskType: (TaskType)  type
             withDescription: (NSString*) typeDescription
                   withColor: (UIColor*)  typeColor
{
    [self.model fillTaskType: type];
}



@end
