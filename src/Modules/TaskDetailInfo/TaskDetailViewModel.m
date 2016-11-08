//
//  TaskViewModel.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDetailViewModel.h"

// Classes
#import "TaskDetailModel.h"
#import "TaskDetailMainFactory.h"
#import "TaskDescriptionCell.h"
#import "TaskInfoHeaderView.h"
#import "TaskDetailInfoCell.h"
#import "FilterSubtasksCell.h"

// Helpers
#import "Utils.h"
#import "ProjectsEnumerations.h"

@interface TaskDetailViewModel() <TaskInfoFooterDelegate, TaskDetailCellDelegate, FilterSubtasksCellDelegate>

// properties
@property (strong, nonatomic) TaskDetailModel* model;

@property (strong, nonatomic) TaskDetailMainFactory* factory;

@property (strong, nonatomic) UITableView* tableView;

@property (strong, nonatomic) TaskInfoHeaderView* headerView;

@property (strong, nonatomic) NSArray* rowHeightsArray;

@end

@implementation TaskDetailViewModel

#pragma mark - Properties -

- (TaskDetailModel*) model
{
    if ( _model == nil )
    {
        _model = [TaskDetailModel new];
    }
    
    return _model;
}

- (TaskDetailMainFactory*) factory
{
    if ( _factory == nil )
    {
        _factory = [TaskDetailMainFactory new];
    }
    
    return _factory;
}

- (TaskInfoHeaderView*) headerView
{
    if ( _headerView == nil )
    {
        _headerView = [[MainBundle loadNibNamed: @"SubTaskInfoView"
                                          owner: self
                                        options: nil] firstObject];
       
        [_headerView fillViewWithInfo: [self.model returnHeaderNumbersInfo]
                         withDelegate: self];
    }
    
    return _headerView;
}

- (NSArray*) rowHeightsArray
{
    if ( _rowHeightsArray == nil )
    {
        // first number in each subarray is value for the first row in second section in table view
        // second number is default value for all other cells in section two
        _rowHeightsArray = @[@[ @(58), @(129) ],
                             @[ @(58), @(54)  ],
                             @[ @(61), @(129) ],
                             @[ @(59)         ]];
    }
    
    return _rowHeightsArray;
}

#pragma mark - Public -

- (TaskStatusType) getTaskStatus
{
    return [self.model getTaskStatus];
}

- (void) fillSelectedTask: (ProjectTask*) task
           withCompletion: (CompletionWithSuccess) completion
{
    [self.model fillSelectedTask: task
                  withCompletion: completion];
    
}

- (ProjectTaskStage*) getTaskStage
{
    return [self.model getTaskStage];
}

- (BOOL) getTaskState
{
    return [self.model getTaskState];
}

#pragma mark - UITableViewDataSourse methods -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 2;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model returnNumberOfRowsForIndexPath: section];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    if ( self.tableView == nil )
        self.tableView = tableView;
    
    UITableViewCell* cell = [self.factory createCellForTableView: tableView
                                                     withContent: [self.model getContentForIndexPath: indexPath]];
    
    if ([cell isKindOfClass: [TaskDetailInfoCell class]])
    {
       TaskDetailInfoCell* detailCell = (TaskDetailInfoCell*)cell;
        
        detailCell.delegate   = self;
    }
    
    if ([cell isKindOfClass: [FilterSubtasksCell class]])
    {
        FilterSubtasksCell* subtaskCell  = (FilterSubtasksCell*)cell;
        
        subtaskCell.delegate = self;
    }
    return cell;
}

- (CGFloat)   tableView: (UITableView*) tableView
heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    CGFloat height = 58;
    
    switch ( indexPath.section)
    {
        case SectionOne:
        {
            switch ( indexPath.row )
            {
                case 0:
                {
                    height = [self countHeightForTaskDetailCellForTableView: tableView];
                }
                
                    break;
                
                case 1:
                {
                    height = [self countHeightForTaskDescrioptionCellForTableView: tableView];
                }
                    break;
                    
                case 2:
                    height = 235;
                    break;
                    
                default:
                    break;
            }
            break;
        }
            
        case SectionTwo:
        {
            height = [self returnSecondSectionRowHeightForIndexPath: indexPath];
        }
            
        default:
            break;
    }

    return height;
}

- (UIView*)  tableView: (UITableView*) tableView
viewForHeaderInSection: (NSInteger)    section
{
    if ( section == 1 )
    {
        return self.headerView;
    }
    
    return nil;
}

- (CGFloat)    tableView: (UITableView*) tableView
heightForHeaderInSection: (NSInteger)    section
{
    CGFloat height = 0;
    
    if ( section == 1 )
    {
        height = 43;
    }
    
    return height;
}

#pragma mark - UITableViewDelegate methods -

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
}

#pragma mark - TaskInfoFooterDelegate -

- (void) updateSecondSectionContentType: (NSUInteger) typeIndex
{
    [self updateSecondSectionContentForType: typeIndex];
}


#pragma mark - Public -

- (void) deselectTask
{
    [self.model deselectTask];
}

- (void) updateSecondSectionContentForType: (NSUInteger) typeIndex
{
    [self.model updateSecondSectionContentType: typeIndex];
    
    [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: 1]
                  withRowAnimation: UITableViewRowAnimationFade];
}

- (void) updateTaskStatus
{
    [self.model updateTaskStatus];
}




#pragma mark - TaskDetailCellDelegate methods -

- (void) performSegueWithID: (NSString*) segueID
{
    if (self.performSegue)
        self.performSegue(segueID);
}

- (void) showPopover: (CGRect) senderFrame
{
    if (self.presentControllerAsPopover)
        self.presentControllerAsPopover(senderFrame);
}


#pragma mark - FilterSubtasksCellDelegate  methods -

- (void) performSegueToAddSubtaskWithID: (NSString*) segueID
{
    if (self.performSegue)
        self.performSegue(segueID);
}


#pragma mark - Helpers -

- (CGFloat) returnSecondSectionRowHeightForIndexPath: (NSIndexPath*) indexPath
{
    CGFloat height;
    
    TaskInfoSecondSectionContentType contentType = [self.model getSecondSectionContentType];
    
    NSArray* heightsArrayForContentType = self.rowHeightsArray[contentType];

    switch ( indexPath.row )
    {
        case 0:
        {
                NSNumber* heightNumberValue = heightsArrayForContentType[0];
                
                height = heightNumberValue.integerValue;
        }
            
            break;
            
        default:
        {
            if ( heightsArrayForContentType.count > 1 )
            {
                NSNumber* heightNumberValue = heightsArrayForContentType[1];
                
                height = heightNumberValue.integerValue;
            }
        }
            break;
    }
    
    return height;
}

- (CGFloat) countHeightForTaskDetailCellForTableView: (UITableView*) tableView
{
    // height without label in first cell is 119
    CGFloat height = 119;
    
    NSString* taskTitle = [self.model getTaskTitle];
    
    CGSize labelSize = [Utils findHeightForText: taskTitle
                                    havingWidth: tableView.frame.size.width - 30
                                        andFont: [UIFont fontWithName: @"SFUIDisplay-Regular"
                                                                 size: 22.f]];
    
    // limiting label height for 2 rows only
    if ( labelSize.height > 54 )
    {
        labelSize.height = 54;
    }
    
    height = height + labelSize.height;
    
    return height;
}

- (CGFloat) countHeightForTaskDescrioptionCellForTableView: (UITableView*) tableView
{
    // 54 - height without label is row height value if description value == nil
    CGFloat heightWithoutLabel = 54;
    
    NSString* desriptionValue = [self.model getTaskDescriptionValue];
    
    CGSize labelSize = [Utils findHeightForText: desriptionValue
                                    havingWidth: tableView.frame.size.width - 30
                                        andFont: [UIFont fontWithName: @"SFUIText-Regular"
                                                                 size: 13.f]];
    // 79pt - heihgt for 5 rows label with current font
    // if desciption is larger than 5 row we limit label height manually
    if ( labelSize.height > 79 )
        labelSize.height = 79;
    
    CGFloat height = labelSize.height + heightWithoutLabel;
    
    if ( desriptionValue == nil )
    {
        // 16 - height for one row
        height = height + 16;
    }
    
    return height;
}

@end
