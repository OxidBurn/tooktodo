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
#import "ProjectTaskAssignee+CoreDataClass.h"
#import "ProjectsEnumerations.h"
#import "ProjectTaskOwner.h"

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
    [self.avatarImage sd_setImageWithURL: [NSURL URLWithString: taskInfo.ownerUser.avatarSrc]];
    
    // Room info
    ProjectTaskRoom* room = (ProjectTaskRoom*)taskInfo.room;
    
    self.roomNumbersLabel.text = room.number.stringValue;
    
    // Type of subtask
    [self.typeTaskMarkerView setStatusString: taskInfo.taskTypeDescription
                                    withType: taskInfo.taskType.integerValue];
    
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
    if ( self.didSelectedTaskAtIndex )
        self.didSelectedTaskAtIndex(self.cellIndexPath);
}

@end
