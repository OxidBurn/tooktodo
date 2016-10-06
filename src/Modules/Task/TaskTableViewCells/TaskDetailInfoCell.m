//
//  TaskDetailInfoCell.m
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDetailInfoCell.h"

// Classes
#import "AvatarImageView.h"
#import "TaskMarkerComponent.h"
#import "StatusMarkerComponent.h"

@interface TaskDetailInfoCell()

// outlets
@property (weak, nonatomic) IBOutlet UILabel* taskTermsLabel;
@property (weak, nonatomic) IBOutlet UILabel* taskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel* systemDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel* roomNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel* statusNameLabel;

@property (weak, nonatomic) IBOutlet UIButton* hiddenTaskMarkBtn;
@property (weak, nonatomic) IBOutlet UIButton* showSystemDescriptionBtn;
@property (weak, nonatomic) IBOutlet UIButton* changeStatusBtn;

@property (weak, nonatomic) IBOutlet UIImageView* overdueMarkImageView;
@property (weak, nonatomic) IBOutlet UIImageView* roomNumberMarkImageView;
@property (weak, nonatomic) IBOutlet UIImageView* changeStatusMarkImageView;
@property (weak, nonatomic) IBOutlet UIImageView* statusExpandedImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint* taskTermsLeadingConstraint;

@property (weak, nonatomic) IBOutlet TaskMarkerComponent* subtaskNumberMark;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent* documentsNumberMark;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent* commentsNumberMark;

@property (weak, nonatomic) IBOutlet StatusMarkerComponent* taskStatusMark;

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
    
}

#pragma mark - Public -

- (void) fillCellWithContent: (TaskRowContent*) content
{
    self.taskNameLabel.text   = content.title;
    self.roomNumberLabel.text = [NSString stringWithFormat: @"%ld", content.roomNumber];
    [self.hiddenTaskMarkBtn setImage: [self getBackgroundImageForTaskAccess: content.isHiddenTask]
                                      forState: UIControlStateNormal];
    self.systemDescriptionLabel.text = content.workArea;
    [self.taskStatusMark setStatusString: content.taskStatusDescription withType: 0];
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
@end
