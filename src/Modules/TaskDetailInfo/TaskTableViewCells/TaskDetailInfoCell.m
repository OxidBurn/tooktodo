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
#import "Macroses.h"
#import "Utils.h"


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

// Constraints

// horizontal constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* taskTermsLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* temsHorizontalToStatusConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* expiredHorizontalToTerms;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* taskTypeHorizontalToWorkAreaShortTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* taskTypeHorizontalToAccessBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* shortAreaHorizontalToAccess;

// floating widths
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* taskStatusBtnWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* taskStatusMarkWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* taskTermsWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shortTitleWidth;





// properties
@property (strong, nonatomic) NSArray* topElementsWidthsArray;

@property (strong, nonatomic) NSArray* topElementsHorizontalConstraints;

// methods
- (IBAction) onShowSystemDescriptionBtn: (UIButton*) sender;

- (IBAction) onHiddenTaskBtn:            (UIButton*) sender;

- (IBAction) onChangeStatusBtn:          (UIButton*) sender;

@end

@implementation TaskDetailInfoCell


#pragma mark - Initialization -

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    [self handleUIForiPhone5AndLess];
}


#pragma mark - Actions -

- (IBAction) onShowSystemDescriptionBtn: (UIButton*) sender
{
    if ([self.delegate respondsToSelector:@selector(showPopover:)])
    {
        [self.delegate showPopover: sender.frame];
    }
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
    
    self.taskTermsLabel.text = [Utils createTermsLabelTextForStartDate: content.taskStartDate
                                                        withFinishDate: content.taskEndDate
                                                            withFormat: @"dd.MM.yyyy"
                                                 withEmptyDetailString: @""];
    
    // changing terms label font color if task is expired
    if ( content.isExpired )
    {
        self.taskTermsLabel.textColor = [UIColor colorWithRed: 270.0/256.0
                                                        green: 70.0/256.0
                                                         blue: 70.0/256.0
                                                        alpha: 1.f];
    }
    
    [self.taskStatusMark setStatusString: content.taskTypeDescription
                                withType: content.taskType];

    
    self.taskTitleLabel.text = content.taskTitle;
        
    [self.subtaskMark setValue: content.subtasksNumber
                      withType: TaskMarkerSubtaskType];
    
    [self.attachmentsMark setValue: content.attachmentsNumber
                          withType: TaskMarkerAttachmentsType];
    
    [self.commentsMark setValue: content.commentsNumber
                       withType: TaskMarkerCommentsType];
    
    [self handleBackgroundImageForTaskAccess: content.isHiddenTask];
    
    [self handleElementsWidthsForContent: content];
    
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
        self.temsHorizontalToStatusConstraint.constant = 15;
        
        // conditional operation is needed in cases when user scrolls table view
        // cell starts to redraw UI and app crashes when prioraty repeatedly is seted to high
        if ( self.temsHorizontalToStatusConstraint.priority != 1000 )
        self.temsHorizontalToStatusConstraint.priority = 1000;
    } else
    {
        //self.roomNumberLabel.text = [NSString stringWithFormat: @"%ld", (unsigned long)roomNumber];
        
        if ( self.temsHorizontalToStatusConstraint.priority != 250 )
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


#pragma mark - Handling UI elements -

- (void) handleUIForiPhone5AndLess
{
    if ( IS_IPHONE_5  || IS_IPHONE_4_OR_LESS )
    {
        self.taskStatusBtnWidthConstraint.constant = 164;
        
        [self.showWorkAreaDecription removeFromSuperview];
    }
}

- (void) handleElementsWidthsForContent: (TaskRowContent*) content
{
    // counting of terms label required width
    NSDictionary* termsAtributes = @{NSFontAttributeName : [UIFont fontWithName: self.taskTermsLabel.font.fontName
                                                                           size: self.taskTermsLabel.font.pointSize]};
    
    CGSize termsLabelSize = [self.taskTermsLabel.text sizeWithAttributes: termsAtributes];
    
    self.taskTermsWidth.constant = termsLabelSize.width;
    
    // counting of task type view required width
    
    UILabel* taskTypeLabel = [self.taskStatusMark getStatusTextLabel];
    
    NSDictionary* taskTypeAtributes = @{NSFontAttributeName : [UIFont fontWithName: taskTypeLabel.font.fontName
                                                                              size: taskTypeLabel.font.pointSize]};
    
    CGSize taskStatusLabelSize = [taskTypeLabel.text sizeWithAttributes: taskTypeAtributes];
    
    // adding 16 - the width of status point mark + distance to label
    self.taskStatusMarkWidth.constant = taskStatusLabelSize.width + 16;
    
    // counting of task short area required width
    NSDictionary* areaShortTitleAtributes = @{NSFontAttributeName : [UIFont fontWithName: self.workAreaShortTitle.font.fontName
                                                                                    size: self.workAreaShortTitle.font.pointSize]};
    
    CGSize areaShortTitleSize = [self.workAreaShortTitle.text sizeWithAttributes: areaShortTitleAtributes];
    
    self.shortTitleWidth.constant = areaShortTitleSize.width;

    [self createUIInfoAccordingToIdiomForContent: content];
    
    [self handleHorizontalConstraintsForContent: content];
    
}

- (void) createUIInfoAccordingToIdiomForContent: (TaskRowContent*) content
{
    if ( IS_IPHONE_5  || IS_IPHONE_4_OR_LESS )
    {
        self.topElementsWidthsArray = @[ @(self.taskTermsWidth.constant),
                                         @(self.taskStatusMarkWidth.constant),
                                         @(self.shortTitleWidth.constant) ];
        
        self.topElementsHorizontalConstraints = @[ self.temsHorizontalToStatusConstraint,
                                                   self.taskTypeHorizontalToWorkAreaShortTitle,
                                                   self.taskTypeHorizontalToAccessBtn];
    }
    else
    {
        self.topElementsWidthsArray = @[ @(self.taskTermsWidth.constant),
                                         @(self.taskStatusMarkWidth.constant),
                                         @(self.shortTitleWidth.constant),
                                         @(CGRectGetWidth(self.showWorkAreaDecription.frame))];
        
        self.topElementsHorizontalConstraints = @[ self.temsHorizontalToStatusConstraint,
                                                   self.taskTypeHorizontalToWorkAreaShortTitle,
                                                   self.shortAreaHorizontalToAccess];
    }
}

- (void) handleHorizontalConstraintsForContent: (TaskRowContent*) content
{
    __block CGFloat allElementsWidths = 0;
    
    CGFloat emptySpace = 0;
    
    CGFloat floatDistanceBetweenElements = 0;
    
    [self.topElementsWidthsArray enumerateObjectsUsingBlock: ^(NSNumber* width, NSUInteger idx, BOOL * _Nonnull stop) {
        
        allElementsWidths += width.floatValue;
        
    }];
    
    allElementsWidths += self.taskTermsLeadingConstraint.constant + self.accessBtn.frame.size.width;

    if ( IS_IPHONE_5 || IS_IPHONE_4_OR_LESS )
    {
        
    }
    else
        allElementsWidths += self.showWorkAreaDecription.frame.size.width + 2.5;

    emptySpace = content.contentWidth - allElementsWidths;

    floatDistanceBetweenElements = emptySpace / self.topElementsHorizontalConstraints.count;
    
    if ( floatDistanceBetweenElements < 5 )
    {
        floatDistanceBetweenElements = 5;
    }

    [self.topElementsHorizontalConstraints enumerateObjectsUsingBlock: ^(NSLayoutConstraint* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.constant = floatDistanceBetweenElements;
        
    }];
}


#pragma mark - Helpers -

- (void) handleBackgroundImageForTaskAccess: (BOOL) isHiddenTask
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
    
    [self.accessBtn setImage: image
                    forState: UIControlStateNormal];
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
