//
//  TasksListTableViewCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TasksListTableViewCell.h"

// Classes
#import "StatusMarkerComponent.h"
#import "TaskMarkerComponent.h"
#import "ProjectTask+CoreDataClass.h"
#import "ProjectTaskRoom+CoreDataClass.h"
#import "ProjectTaskWorkArea.h"
#import "ProjectTaskResponsible+CoreDataClass.h"
#import "ProjectTaskAssignee.h"
#import "ProjectsEnumerations.h"

// Categories
#import "UIImageView+WebCache.h"
#import "NSDate+Helper.h"

@interface TasksListTableViewCell()

// properties
@property (weak, nonatomic) IBOutlet UILabel* executionDateLabel;
@property (weak, nonatomic) IBOutlet UILabel* roomNumbersLabel;
@property (weak, nonatomic) IBOutlet StatusMarkerComponent* typeTaskMarkerView;
@property (weak, nonatomic) IBOutlet UILabel* systemLabel;
@property (weak, nonatomic) IBOutlet UILabel* titleTaskLabel;
@property (weak, nonatomic) IBOutlet UIImageView* avatarImage;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent* amountTaskMarkerComponent;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent* attachmantsMarkerComponent;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent* commentsMarkerComponent;

// Task status UI
@property (weak, nonatomic) IBOutlet UIButton *taskStatusBtn;
@property (weak, nonatomic) IBOutlet UIImageView *taskStatusImageIcon;
@property (weak, nonatomic) IBOutlet UILabel *taskStatusTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *taskStatusChangeIcon;

// methods

- (IBAction) onChangeTaskStatus: (UIButton*) sender;

@end

@implementation TasksListTableViewCell


#pragma mark - Initialization -

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    self.cellType = AllTasksTaskCellType;
}


#pragma mark - Delegate methods -

- (void) setSelected: (BOOL) selected
            animated: (BOOL) animated
{
    [super setSelected: selected
              animated: animated];
}


#pragma mark - Public methods -

- (void) fillInfoForCell: (id) info
{
    ProjectTask* taskInfo = (ProjectTask*)info;
    
    self.titleTaskLabel.text     = taskInfo.title;
    self.executionDateLabel.text = [self executionDateString: taskInfo];
    self.systemLabel.text        = taskInfo.workArea.shortTitle;
    
    [self.amountTaskMarkerComponent setValue: taskInfo.subTasks.count
                                    withType: TaskMarkerSubtaskType];
    [self.attachmantsMarkerComponent setValue: taskInfo.attachments.integerValue
                                     withType: TaskMarkerAttachmentsType];
    [self.commentsMarkerComponent setValue: 0
                                  withType: TaskMarkerCommentsType];
    
    // Setting avatar url
    // first time it will be loaded from web and then grab from cache
    [self.avatarImage sd_setImageWithURL: [NSURL URLWithString: taskInfo.responsible.avatarSrc]];
    
    // Room info
    ProjectTaskRoom* room = (ProjectTaskRoom*)taskInfo.room;
    
    self.roomNumbersLabel.text = room.number.stringValue;
    
    // Type of subtask
    [self.typeTaskMarkerView setStatusString: @"Замечание"
                                    withType: StatusMarkerOrangeType];
    
    // Setup task status
    [self setupStatusTypeButton: taskInfo];
}


#pragma mark - Internal methods -

- (NSString*) executionDateString: (ProjectTask*) task
{
    NSString* startDayString = [task.startDay stringWithFormat: @"dd.mm.yyyy"];
    NSString* closeDayString = [task.closedDate stringWithFormat: @"dd.mm.yyyy"];
    
    NSString* executionDateValue = [NSString stringWithFormat: @"%@ - %@", startDayString, closeDayString];
    
    return executionDateValue;
}

- (void) setupStatusTypeButton: (ProjectTask*) task
{
    UIColor* statusColor           = [UIColor clearColor];
    UIImage* statusChangeIconImage = nil;
    NSString* statusTitleString    = @"";
    UIImage* statusIconImage       = nil;
    UIColor* statusTitleFontColor  = [UIColor whiteColor];
    
    switch (task.status.integerValue)
    {
        case TaskWaitingStatusType:
        {
            statusColor           = [UIColor colorWithRed:1.00 green:0.89 blue:0.27 alpha:1.00];
            statusChangeIconImage = [UIImage imageNamed: @"TaskStatusExpandDarkIcon"];
            statusTitleString     = task.statusDescription;
            statusIconImage       = [UIImage imageNamed: @"TaskStatusWaitingIcon"];
            statusTitleFontColor  = [UIColor blackColor];
        }
            break;
        case TaskInProgressStatusType:
        {
            statusColor           = [UIColor colorWithRed:0.31 green:0.77 blue:0.18 alpha:1.00];
            statusChangeIconImage = [UIImage imageNamed: @"TaskStatusExpandWhiteIcon"];
            statusTitleString     = task.statusDescription;
            statusIconImage       = [UIImage imageNamed: @"TaskStatusInProgressIcon"];
            statusTitleFontColor  = [UIColor whiteColor];
        }
            break;
            
        case TaskCompletedStatusType:
        {
            statusColor           = [UIColor cyanColor];
            statusChangeIconImage = [UIImage imageNamed: @"TaskStatusExpandDarkIcon"];
            statusTitleString     = task.statusDescription;
            statusIconImage       = [UIImage imageNamed: @""];
            statusTitleFontColor  = [UIColor blackColor];
        }
            break;
            
        case TaskOnApprovingStatusType:
        {
            statusColor           = [UIColor colorWithRed:0.98 green:0.85 blue:0.25 alpha:1.00];
            statusChangeIconImage = [UIImage imageNamed: @"TaskStatusExpandDarkIcon"];
            statusTitleString     = task.statusDescription;
            statusIconImage       = [UIImage imageNamed: @"TaskStatusOnApproveIcon"];
            statusTitleFontColor  = [UIColor colorWithRed:0.15 green:0.18 blue:0.22 alpha:1.00];
        }
            break;
            
        case TaskOnCompletionStatusType:
        {
            statusColor           = [UIColor brownColor];
            statusChangeIconImage = [UIImage imageNamed: @"TaskStatusExpandDarkIcon"];
            statusTitleString     = task.statusDescription;
            statusIconImage       = [UIImage imageNamed: @""];
            statusTitleFontColor  = [UIColor blackColor];
        }
            break;
            
        case TaskCanceledStatusType:
        {
            statusColor           = [UIColor colorWithRed:1.00 green:0.27 blue:0.27 alpha:1.00];
            statusChangeIconImage = [UIImage imageNamed: @"TaskStatusExpandWhiteIcon"];
            statusTitleString     = task.statusDescription;
            statusIconImage       = [UIImage imageNamed: @"TaskStatusCanceledIcon"];
            statusTitleFontColor  = [UIColor whiteColor];
        }
            break;
    }
    
    [self.taskStatusBtn setBackgroundColor: statusColor];
    
    self.taskStatusTitleLabel.text      = statusTitleString;
    self.taskStatusImageIcon.image      = statusIconImage;
    self.taskStatusChangeIcon.image     = statusChangeIconImage;
    self.taskStatusTitleLabel.textColor = statusTitleFontColor;
}


#pragma mark - Actions -

- (IBAction) onChangeTaskStatus: (UIButton*) sender
{
    
}

@end
