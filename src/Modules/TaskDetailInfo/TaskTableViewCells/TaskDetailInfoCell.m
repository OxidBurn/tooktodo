//
//  TaskDetailInfoCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDetailInfoCell.h"

// Classes
#import "AvatarImageView.h"
#import "TaskMarkerComponent.h"
#import "StatusMarkerComponent.h"
#import "ProjectsEnumerations.h"

// Helpers
#import "NSDate+Helper.h"
#import "TaskStatusDefaultValues.h"


@interface TaskDetailInfoCell()

// outlets
@property (weak, nonatomic) IBOutlet UILabel*               taskTermsLabel;
@property (weak, nonatomic) IBOutlet UIImageView*           isExpiredImageView;
@property (weak, nonatomic) IBOutlet StatusMarkerComponent* taskStatusMark;
@property (weak, nonatomic) IBOutlet UILabel*               workAreaShortTitle;
@property (weak, nonatomic) IBOutlet UIButton*              showWorkAreaDecription;
@property (weak, nonatomic) IBOutlet UIButton*              accessBtn;
@property (weak, nonatomic) IBOutlet UIButton*              statusBtn;
@property (weak, nonatomic) IBOutlet UILabel*               taskTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView*           changeStatusMarkImageView;
@property (weak, nonatomic) IBOutlet UILabel*               statusDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView*           statusExpandedImageView;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent*   subtaskMark;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent*   attachmentsMark;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent*   commentsMark;
@property (weak, nonatomic) IBOutlet UIView*                roomInfoView;
@property (weak, nonatomic) IBOutlet UILabel*               roomNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView*           roomNumberMarkImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint*    taskTermsLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint*    temsHorizontalToStatusConstraint;

// properties


// methods
- (IBAction) onShowSystemDescriptionBtn: (UIButton*) sender;

- (IBAction) onHiddenTaskBtn:            (UIButton*) sender;

- (IBAction) onChangeStatusBtn:          (UIButton*) sender;

@end

@implementation TaskDetailInfoCell

#pragma mark - Actions -

- (IBAction) onShowSystemDescriptionBtn: (UIButton*) sender
{
    
}

- (IBAction) onHiddenTaskBtn: (UIButton*) sender
{
    
}

- (IBAction) onChangeStatusBtn: (UIButton*) sender
{
    if ([self.delegate respondsToSelector:@selector(performSegueWithID:)])
    {
        [self.delegate performSegueWithID: @"ShowStatusList"];
    }
    
}

#pragma mark - Public -

- (void) fillCellWithContent: (TaskRowContent*) content
{
    [self handleExpiredMark: content.isExpired];
    
    [self handleRoomInfoView: content.roomNumber];
    
    [self handleWorkAreaDescriptionBtn: content.workAreaShortTitle];
    
    [self handleTaskStatusTypeBtn: content.status];
    
    self.taskTermsLabel.text = [self createTermsLabelTextForStartDate: content.taskStartDate
                                                       withFinishDate: content.taskEndDate];
    
    [self.taskStatusMark setStatusString: content.taskTypeDescription
                                withType: content.taskType];
    
    self.taskTitleLabel.text = content.taskTitle;
    
    self.statusDescriptionLabel.text = content.statusDescription;
    
    [self.subtaskMark setValue: content.subtasksNumber
                      withType: TaskMarkerSubtaskType];
    
    [self.attachmentsMark setValue: content.attachmentsNumber
                          withType: TaskMarkerAttachmentsType];
    
    [self.commentsMark setValue: content.commentsNumber
                       withType: TaskMarkerCommentsType];
    
}

#pragma mark - Internal -

- (void) handleExpiredMark: (BOOL) isExpired
{
    self.isExpiredImageView.hidden = isExpired? NO : YES;
    
    self.taskTermsLeadingConstraint.constant = isExpired? 32 : 15;
}

- (void) handleRoomInfoView: (NSUInteger) roomNumber
{
    if ( roomNumber == 0 )
    {
        self.roomInfoView.hidden = YES;
        
        self.temsHorizontalToStatusConstraint.constant = 15;
        self.temsHorizontalToStatusConstraint.priority = 1000;
    } else
    {
        self.roomInfoView.hidden = NO;
        
        self.roomNumberLabel.text = [NSString stringWithFormat: @"%ld", (unsigned long)roomNumber];
        
        self.temsHorizontalToStatusConstraint.priority = 250;
    }

}

- (void) handleWorkAreaDescriptionBtn: (NSString*) workAreaShortTitle
{
    if ( workAreaShortTitle == nil )
    {
        self.showWorkAreaDecription.hidden = YES;
    }
    else
    {
        self.showWorkAreaDecription.hidden = NO;
        
        self.workAreaShortTitle.text = workAreaShortTitle;
    }
}

#pragma mark - Helpers -

- (UIImage*) getBackgroundImageForTaskAccess: (BOOL) isHiddenTask
{
    UIImage* image;
    
    if ( isHiddenTask )
    {
        image = [UIImage imageNamed: @"closedEyes"];
    }
    else
    {
        image = [UIImage imageNamed: @"Eye"];
    }
    
    return image;
}

- (NSString*) createTermsLabelTextForStartDate: (NSDate*) startDate
                                withFinishDate: (NSDate*) finishDate
{
    NSString* labelText;
    
    NSString* firstDate = [NSDate stringFromDate: startDate withFormat: @"dd.MM"];
        
    NSString* secondDate = [NSDate stringFromDate: finishDate withFormat: @"dd.MM.yyyy"];
        
    labelText = [NSString stringWithFormat: @"%@ - %@", firstDate, secondDate];

    return labelText;
}

- (void) handleTaskStatusTypeBtn: (NSUInteger) taskStatusType
{
    UIImage* statusTypeIcon = [[TaskStatusDefaultValues sharedInstance] returnIconImageForTaskStatus: taskStatusType];
    
    if ( statusTypeIcon )
        [self.changeStatusMarkImageView setImage: statusTypeIcon];
    
    self.statusBtn.backgroundColor = [[TaskStatusDefaultValues sharedInstance] returnColorForTaskStatus: taskStatusType];
}

@end