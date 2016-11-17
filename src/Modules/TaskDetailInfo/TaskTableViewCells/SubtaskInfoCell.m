//
//  SubtaskInfoCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SubtaskInfoCell.h"

// Classes
#import "AvatarImageView.h"
#import "TaskMarkerComponent.h"
#import "StatusMarkerComponent.h"

// Helpers
#import "TaskStatusDefaultValues.h"

@interface SubtaskInfoCell()

// outlets
@property (weak, nonatomic) IBOutlet UILabel*               taskTermsLabel;
@property (weak, nonatomic) IBOutlet UIImageView*           isExpiredImageView;
@property (weak, nonatomic) IBOutlet StatusMarkerComponent* taskStatusMark;
@property (weak, nonatomic) IBOutlet UILabel*               workAreaShortTitle;
@property (weak, nonatomic) IBOutlet UIButton*              accessBtn;
@property (weak, nonatomic) IBOutlet UIButton*              statusBtn;
@property (weak, nonatomic) IBOutlet UILabel*               taskTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView*           changeStatusMarkImageView;
@property (weak, nonatomic) IBOutlet UILabel*               statusDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView*           statusExpandedImageView;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent*   subtaskMark;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent*   attachmentsMark;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent*   commentsMark;
@property (weak, nonatomic) IBOutlet UILabel*               roomNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView*           roomNumberMarkImageView;

// properties


// methods

- (IBAction) onHiddenTaskBtn:   (UIButton*) sender;

- (IBAction) onChangeStatusBtn: (UIButton*) sender;

@end

@implementation SubtaskInfoCell

#pragma mark - Actions -

- (IBAction) onHiddenTaskBtn: (UIButton*) sender
{
    
}

- (IBAction) onChangeStatusBtn: (UIButton*) sender
{
    
}

#pragma mark - Public -

- (void) fillCellWithContent: (TaskRowContent*) content
{
    [self.taskStatusMark setStatusString: content.taskTypeDescription
                                withType: content.taskType];
    
    self.taskTitleLabel.text = content.taskTitle;
    
    
    [self.subtaskMark setValue: content.subtasksNumber
                      withType: TaskMarkerSubtaskType];
    
    [self.attachmentsMark setValue: content.attachmentsNumber
                          withType: TaskMarkerAttachmentsType];
    
    [self.commentsMark setValue: content.commentsNumber
                       withType: TaskMarkerCommentsType];
    
     [self handleTaskStatusTypeBtn: content.status];
    
}

#pragma mark - Internal -



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

- (void) handleTaskStatusTypeBtn: (NSUInteger) taskStatusType
{
    self.changeStatusMarkImageView.image  = [[TaskStatusDefaultValues sharedInstance]
                                             returnIconImageForTaskStatus: taskStatusType];
    
    self.statusBtn.backgroundColor        = [[TaskStatusDefaultValues sharedInstance]
                                             returnColorForTaskStatus: taskStatusType];
    
    self.statusDescriptionLabel.text      = [[TaskStatusDefaultValues sharedInstance]
                                             returnTitleForTaskStatus: taskStatusType];
    
    self.statusExpandedImageView.image    = [[TaskStatusDefaultValues sharedInstance]
                                             returnArrowImageForTaskStatus: taskStatusType];
    
    self.statusDescriptionLabel.textColor = [[TaskStatusDefaultValues sharedInstance]
                                             returnFontColorForTaskStatus: taskStatusType];
}


@end
