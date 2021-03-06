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
#import "ProjectTaskWorkArea+CoreDataClass.h"
#import "ProjectTaskResponsible+CoreDataClass.h"
#import "ProjectTaskAssignee+CoreDataClass.h"
#import "ProjectsEnumerations.h"
#import "ProjectTaskOwner+CoreDataProperties.h"

// Categories
#import "UIImageView+WebCache.h"
#import "NSDate+Helper.h"

// Helpers
#import "TaskStatusDefaultValues.h"

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
@property (weak, nonatomic) IBOutlet UIImageView* roomMarkImage;
@property (weak, nonatomic) IBOutlet UIButton* taskAccess;

// Task status UI
@property (weak, nonatomic) IBOutlet UIButton *taskStatusBtn;
@property (weak, nonatomic) IBOutlet UIImageView *taskStatusImageIcon;
@property (weak, nonatomic) IBOutlet UILabel *taskStatusTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *taskStatusChangeIcon;

// methods

- (IBAction) onChangeTaskStatus: (UIButton*) sender;
- (IBAction) onShowTaskDetail: (UIButton*) sender;

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

- (void) fillInfoForCell: (ProjectTask*) taskInfo
{
    self.titleTaskLabel.text     = taskInfo.title;
    self.executionDateLabel.text = [self executionDateString: taskInfo];
    self.systemLabel.text        = taskInfo.workArea.shortTitle;
    
    [self.amountTaskMarkerComponent setValue: taskInfo.subTasks.count
                                    withType: TaskMarkerSubtaskType];
    [self.attachmantsMarkerComponent setValue: taskInfo.attachments.integerValue
                                     withType: TaskMarkerAttachmentsType];
    [self.commentsMarkerComponent setValue: taskInfo.commentsCount.integerValue
                                  withType: TaskMarkerCommentsType];
    
    // Setting avatar url
    // first time it will be loaded from web and then grab from cache
    if (taskInfo.responsible.avatarSrc)
        [self.avatarImage sd_setImageWithURL: [NSURL URLWithString: taskInfo.responsible.avatarSrc]];
    
    else if (taskInfo.responsible.assignee.avatarSrc)
        [self.avatarImage sd_setImageWithURL: [NSURL URLWithString: taskInfo.responsible.assignee.avatarSrc]];
    
    else
        self.avatarImage.image = [UIImage imageNamed: @"emptyAvatarIcon"];
    
    // Room info
    ProjectTaskRoom* room = taskInfo.rooms.firstObject;
    
    self.roomNumbersLabel.text = room.number.stringValue;
    
    self.roomMarkImage.hidden = room.roomID ? NO : YES;
    
    if ([taskInfo.access isEqual: @(0)])
    {
        [self.taskAccess setImage: [UIImage imageNamed: @"closedEyes"] forState: UIControlStateNormal];
    }
    
    else if ([taskInfo.access isEqual: @(1)])
        [self.taskAccess setImage: [UIImage imageNamed: @"Eye"] forState: UIControlStateNormal];
   
    
    // Type of subtask
    [self.typeTaskMarkerView setStatusString: taskInfo.taskTypeDescription
                                    withType: taskInfo.taskType.integerValue];
    
    // Setup task status
    [self setupStatusTypeButton: taskInfo];
}


#pragma mark - Internal methods -

- (NSString*) executionDateString: (ProjectTask*) task
{
    NSString* executionDateValue = [self createTermsLabelTextForStartDate: task.startDay
                                                           withFinishDate: task.closedDate];
    
    return executionDateValue;
}

- (void) setupStatusTypeButton: (ProjectTask*) task
{
    self.taskStatusBtn.backgroundColor = [[TaskStatusDefaultValues sharedInstance]
                                          returnColorForTaskStatus: task.status.integerValue];
    
    self.taskStatusTitleLabel.text      = [[TaskStatusDefaultValues sharedInstance]
                                           returnTitleForTaskStatus: task.status.integerValue];
    
    self.taskStatusImageIcon.image      = [[TaskStatusDefaultValues sharedInstance]
                                           returnIconImageForTaskStatus: task.status.integerValue];
    
    self.taskStatusChangeIcon.image     = [[TaskStatusDefaultValues sharedInstance]
                                           returnArrowImageForTaskStatus: task.status.integerValue];
    
    self.taskStatusTitleLabel.textColor = [[TaskStatusDefaultValues sharedInstance]
                                           returnFontColorForTaskStatus: task.status.integerValue];
}


#pragma mark - Actions -

- (IBAction) onChangeTaskStatus: (UIButton*) sender
{
    if ([self.delegate respondsToSelector:@selector(performSegueToChangeStatusWithID:)])
    {
        [self.delegate performSegueToChangeStatusWithID: @"ShowStatusList"];
    }
}

- (IBAction) onShowTaskDetail: (UIButton*) sender
{
    
}


#pragma mark - Helpers -

- (NSString*) createTermsLabelTextForStartDate: (NSDate*) startDate
                                withFinishDate: (NSDate*) finishDate
{
    NSString* startDateString = [NSDate stringFromDate: startDate withFormat: @"dd.MM.yyyy"];
    NSString* endDateString   = [NSDate stringFromDate: finishDate withFormat: @"dd.MM.yyyy"];
    
    NSString* detailString = [NSString string];
    
    if ( startDateString )
    {
        if ( endDateString )
        {
            detailString = [NSString stringWithFormat: @"%@ — %@",
                            startDateString,
                            endDateString];
        }
        else
            detailString = [NSString stringWithFormat: @"%@ —", startDateString];
    }
    else
    {
        if ( endDateString)
        {
            detailString = [NSString stringWithFormat: @"— %@", endDateString];
        }
        else
            detailString = @"";
    }
    
    return detailString;
}

@end
