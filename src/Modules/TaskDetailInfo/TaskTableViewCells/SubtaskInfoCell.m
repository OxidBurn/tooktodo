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
#import "ProjectTaskResponsible+CoreDataClass.h"
#import "ProjectTaskOwner+CoreDataClass.h"
#import "SDWebImageCompat.h"
#import "UIImageView+WebCache.h"

// Helpers
#import "TaskStatusDefaultValues.h"
#import "NSDate+Helper.h"
#import "Utils.h"

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
@property (nonatomic, weak) IBOutlet AvatarImageView*       avatarImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint* dateToTypeHorizontalConstraint;

// properties


// methods

- (IBAction) onHiddenTaskBtn:   (UIButton*) sender;

- (IBAction) onChangeStatusBtn: (UIButton*) sender;

@end

@implementation SubtaskInfoCell


#pragma mark - Initialization -

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    if ( IS_IPHONE_5  || IS_IPHONE_4_OR_LESS )
    {
        [self.accessBtn removeFromSuperview];
        
        [self.roomNumberLabel removeFromSuperview];
        
        [self.roomNumberMarkImageView removeFromSuperview];
        
        self.dateToTypeHorizontalConstraint.constant = 10;
        
        self.dateToTypeHorizontalConstraint.priority = 1000;
    }
}


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
    
    self.taskTitleLabel.text = content.taskTitle;
    
    self.workAreaShortTitle.text = content.workAreaShortTitle;
    
    [self.subtaskMark setValue: content.subtasksNumber
                      withType: TaskMarkerSubtaskType];
    
    [self.attachmentsMark setValue: content.attachmentsNumber
                          withType: TaskMarkerAttachmentsType];
    
    [self.commentsMark setValue: content.commentsNumber
                       withType: TaskMarkerCommentsType];
    
    [self handleTaskStatusTypeBtn: content.status];
    
    [self.taskStatusMark setStatusString: content.taskTypeDescription
                                withType: content.taskType];
    
    self.taskTermsLabel.text = [Utils createTermsLabelTextForStartDate: content.taskStartDate
                                                        withFinishDate: content.taskEndDate
                                                            withFormat: @"dd.MM.yyyy"
                                                 withEmptyDetailString: @""];
    
    
    //Uncomment when responsible won't be nil
    
//    ProjectTaskResponsible* responsible = content.responsibleUser.firstObject;
//    [self.avatarImage sd_setImageWithURL: [NSURL URLWithString: responsible.avatarSrc]];
    
    
    //Delete when responsible won't be nil
    ProjectTaskOwner* owner = content.ownerUser.firstObject;
    
    [self.avatarImage sd_setImageWithURL: [NSURL URLWithString: owner.avatarSrc]];
    
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
