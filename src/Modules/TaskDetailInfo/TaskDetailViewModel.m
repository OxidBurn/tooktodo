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
#import "CommentsCell.h"
#import "NSObject+Sorting.h"
#import "AddCommentCell.h"


// Helpers
#import "Utils.h"
#import "ProjectsEnumerations.h"

@interface TaskDetailViewModel() <TaskInfoFooterDelegate, TaskDetailCellDelegate, FilterSubtasksCellDelegate, CommentCellDelegate, AddCommentCellDelegate>

// properties
@property (strong, nonatomic) TaskDetailModel* model;

@property (strong, nonatomic) TaskDetailMainFactory* factory;

@property (strong, nonatomic) UITableView* tableView;

@property (strong, nonatomic) TaskInfoHeaderView* headerView;

@property (strong, nonatomic) NSArray* secondSectionRowHeightsArray;

@property (strong, nonatomic) AddCommentCell* addCommentCell;

@end

@implementation TaskDetailViewModel


#pragma mark - Properties -

- (TaskDetailModel*) model
{
    if ( _model == nil )
    {
        _model = [[TaskDetailModel alloc] init];
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

- (NSArray*) secondSectionRowHeightsArray
{
    if ( _secondSectionRowHeightsArray == nil )
    {
        // first number in each subarray is value for the first row in second section in table view
        // second number is default value for all other cells in section two
        _secondSectionRowHeightsArray = @[@[ @(58), @(129) ],
                                          @[ @(58), @(54)  ],
                                          @[ @(61), @(100) ],
                                          @[ @(59)         ]];
    }
    
    return _secondSectionRowHeightsArray;
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

- (void) reloadDataWithCompletion: (CompletionWithSuccess) completion
{
    [self.model reloadDataWithCompletion: completion];
}

- (ProjectTaskStage*) getTaskStage
{
    return [self.model getTaskStage];
}

- (BOOL) getTaskState
{
    return [self.model getTaskState];
}

- (ProjectTask*) getCurrentTask
{
    return [self.model getCurrentTask];
}


- (void) deselectTask
{
    [self.model deselectTask];
}

- (void) updateSecondSectionContentForType: (NSUInteger) typeIndex
{
    [self.model updateSecondSectionContentType: typeIndex];
    
    CGPoint offset = self.tableView.contentOffset;
    
    [self.tableView reloadData];
    
    [self.tableView layoutIfNeeded];
    
    [self.tableView setContentOffset: offset animated: NO];
}

- (void) updateTaskStatus
{
    [self.model updateTaskStatus];
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
    {
        self.tableView = tableView;
        
        [self.model createContentForTableViewWithFrame: tableView.frame];
    }
    
    UITableViewCell* cell = [self.factory createCellForTableView: tableView
                                                     withContent: [self.model getContentForIndexPath: indexPath]
                                                    withDelegate: self];
    
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

    if ([cell isKindOfClass:AddCommentCell.class])
    {
        self.addCommentCell             = (AddCommentCell*)cell;
        self.addCommentCell.delegate    = self;
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
                    height = [self countHeightForTaskDetailCellForTableView: tableView];
                
                    break;
                
                case 1:
                    height = [self countHeightForTaskDescrioptionCellForTableView: tableView];
                    
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
            if (indexPath.row == 0 && self.model.getSecondSectionContentType == CommentsContentType)
            {
                height = [self.addCommentCell.addCommentTextView sizeThatFits: CGSizeMake(UIScreen.mainScreen.bounds.size.width - 30, CGFLOAT_MAX)].height + 30;
                height = MIN(height, 152);
                if (height < 152)
                {
                    self.addCommentCell.addCommentTextView.scrollEnabled = false;
                    self.addCommentCell.addCommentTextView.contentOffset = CGPointZero;
                }
                else
                {
                    self.addCommentCell.addCommentTextView.scrollEnabled = true;
                }
            }
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


#pragma mark - CommentCellDelegate -

- (void) updateTableView
{
    [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: 1]
                  withRowAnimation: UITableViewRowAnimationFade];
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

- (void) showSortingPopoverWithFrame: (CGRect) frame
{
    CGRect rect = [self.tableView rectForRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 1]];
    
    CGPoint offset = self.tableView.contentOffset;
    
    frame.origin.y += rect.origin.y - offset.y + 60;
    
    if (self.showSortingPopoverBlock)
        self.showSortingPopoverBlock(frame);
}

#pragma mark - Helpers -

// This method counts second section cells heights according to cell types
- (CGFloat) returnSecondSectionRowHeightForIndexPath: (NSIndexPath*) indexPath
{
    CGFloat height;
    
    TaskInfoSecondSectionContentType contentType = [self.model getSecondSectionContentType];
    
    NSArray* heightsArrayForContentType = self.secondSectionRowHeightsArray[contentType];
    
    NSNumber* firstRowHeight = heightsArrayForContentType[0];
    
    NSNumber* defaultHeightValue = heightsArrayForContentType[1];

    switch ( indexPath.row )
    {
        case 0:
        {
                height = firstRowHeight.integerValue;
        }
            break;
            
        case 1:
        {
            if ( [self.model getSecondSectionContentType] == CommentsContentType )
            {
                height = [self.model countHeightForCommentCellForIndexPath: indexPath];
            }
            else
            {
                height = defaultHeightValue.integerValue;
            }
        }
            break;
            
        default:
        {
            if ( heightsArrayForContentType.count > 1 )
            {
                if ( [self.model getSecondSectionContentType] == CommentsContentType )
                    height = [self.model countHeightForCommentCellForIndexPath: indexPath];
                else
                    height = defaultHeightValue.integerValue;
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

#pragma mark - PopoverModelDelegate methods -

- (void) didDiminutionSortingAtIndex: (NSUInteger) index
{
    [self.model sortArrayForType: index
                      isAcceding: DiminutionSortingType];
    
    [UIView setAnimationsEnabled: NO];
    
    CGPoint offset = self.tableView.contentOffset;
    
    [self.tableView reloadRowsAtIndexPaths: [self.tableView indexPathsForVisibleRows]
                          withRowAnimation: UITableViewRowAnimationNone];
    
    [self.tableView setContentOffset: offset
                            animated: NO];
    
    [UIView setAnimationsEnabled: YES];
}

- (void) didGrowSortingAtIndex: (NSUInteger) index
{
    [self.model sortArrayForType: index
                      isAcceding: GrowsSortingType];
    
    [UIView setAnimationsEnabled: NO];
    
    CGPoint offset = self.tableView.contentOffset;
    
    [self.tableView reloadRowsAtIndexPaths: [self.tableView indexPathsForVisibleRows]
                          withRowAnimation: UITableViewRowAnimationNone];
    
    [self.tableView setContentOffset: offset
                            animated: NO];
    
    [UIView setAnimationsEnabled: YES];
}

#pragma mark - PopoverModelDataSource methods -

- (NSArray*) getPopoverContent
{
    return [self.model getPopoverContent];
}

- (NSUInteger) selectedItem
{
    return [self.model getTasksSortingType];
}

- (ContentAccedingSortingType) getProjectsSortAccedingType
{
    return [self.model getTasksSortingAscendingType];
}

#pragma mark -

- (void)    addCommentCell: (AddCommentCell*)addCommentCell
   newCommentTextDidChange: (UITextView*)sender
{
    CGRect frame = self.addCommentCell.frame;
    frame.size.height = [self.addCommentCell.addCommentTextView sizeThatFits: CGSizeMake(UIScreen.mainScreen.bounds.size.width - 30, CGFLOAT_MAX)].height + 30;
    frame.size.height = MIN(frame.size.height, 152);

    self.addCommentCell.addCommentTextView.scrollEnabled = !(frame.size.height < 152);

    if (self.addCommentCell.addCommentTextView.scrollEnabled)
    {
        return;
    }

    self.addCommentCell.addCommentTextView.contentOffset = CGPointZero;

    CGPoint contentOffset = self.tableView.contentOffset;
    [UIView setAnimationsEnabled: false];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    [UIView setAnimationsEnabled: true];
    self.tableView.contentOffset  = contentOffset;
}

@end
