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
@property (weak, nonatomic) IBOutlet UIImageView*           isUrgentImageView;
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

// constraints

// float elements widths

@property (weak, nonatomic) IBOutlet NSLayoutConstraint* taskStatusMarkWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* taskTermsWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* shortTitleWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* roomNumberLabelWidth;

// horizontal constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* termsLabelLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* termsToRoomMark;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* roomNumberToTaskType;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* dateToTypeHorizontalConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* taskTypeToShortAreaTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* areaShortTitleToAccessBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* shortTitleTrailing;

// properties
@property (strong, nonatomic) NSArray* topElementsWidthsArray;

@property (strong, nonatomic) NSArray* topElementsHorizontalConstraints;

// methods

- (IBAction) onHiddenTaskBtn:   (UIButton*) sender;

- (IBAction) onChangeStatusBtn: (UIButton*) sender;

@end

@implementation SubtaskInfoCell


#pragma mark - Initialization -

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    [self handleUIForiPhone5AndLess];
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
    
    [self handleUrgentMark: content.isUrgent];
    
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
    
    // changing terms label font color if task is expired
    if ( content.isExpired )
    {
        self.taskTermsLabel.textColor = [UIColor colorWithRed: 270.0/256.0
                                                        green: 70.0/256.0
                                                         blue: 70.0/256.0
                                                        alpha: 1.f];
    }
    else
        self.taskTermsLabel.textColor = [UIColor blackColor];
    
    // handling room number label if it's not selected
    if ( content.roomNumber == 0 )
    {
        [self.roomNumberLabel removeFromSuperview];
        
        [self.roomNumberMarkImageView removeFromSuperview];
    }
    else
        self.roomNumberLabel.text = [NSString stringWithFormat: @"%ld", content.roomNumber];
    
    
    //Uncomment when responsible won't be nil
    
//    ProjectTaskResponsible* responsible = content.responsibleUser.firstObject;
//    [self.avatarImage sd_setImageWithURL: [NSURL URLWithString: responsible.avatarSrc]];
    
    
    //Delete when responsible won't be nil
    ProjectTaskOwner* owner = content.ownerUser.firstObject;
    
    [self.avatarImage sd_setImageWithURL: [NSURL URLWithString: owner.avatarSrc]];
    
    [self handleElementsWidthsForContent: content];
    
    [self handleHorizontalConstraintsForContent: content];
    
}


#pragma mark - Handling UI elements -

- (void) handleUIForiPhone5AndLess
{
    if ( IS_IPHONE_5  || IS_IPHONE_4_OR_LESS )
    {
        [self.accessBtn removeFromSuperview];
        
        self.shortTitleTrailing.constant = 15.f;
    }
}

- (void) handleElementsWidthsForContent: (TaskRowContent*) content
{
    // counting of terms label required width
    NSDictionary* termsAtributes = @{NSFontAttributeName : [UIFont fontWithName: self.taskTermsLabel.font.fontName
                                                                           size: self.taskTermsLabel.font.pointSize]};
    
    CGSize termsLabelSize = [self.taskTermsLabel.text sizeWithAttributes: termsAtributes];
    
    self.taskTermsWidth.constant = termsLabelSize.width + 3;
    
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
    
    self.shortTitleWidth.constant = areaShortTitleSize.width + 3;
    
    // counting of room number label width if it's selected
    if ( content.roomNumber != 0 )
    {
        NSDictionary* roomNumberAtributes = @{NSFontAttributeName : [UIFont fontWithName: self.roomNumberLabel.font.fontName
                                                                                        size: self.roomNumberLabel.font.pointSize]};
        
        CGSize roomNumberSize = [self.roomNumberLabel.text sizeWithAttributes: roomNumberAtributes];
        
        self.roomNumberLabelWidth.constant = roomNumberSize.width;
    }
    
    // handling UI according to content
    [self createUIInfoAccordingToIdiomForContent: content];
    
    [self handleHorizontalConstraintsForContent: content];
}

- (void) createUIInfoAccordingToIdiomForContent: (TaskRowContent*) content
{
    if ( IS_IPHONE_5  || IS_IPHONE_4_OR_LESS )
    {
        // case for iPhone 4 or 5 when room is selected
        if ( content.roomNumber != 0 )
        {
            self.topElementsWidthsArray = @[ @(self.taskTermsWidth.constant),
                                             @(self.roomNumberLabelWidth.constant),
                                             @(self.taskStatusMarkWidth.constant),
                                             @(self.shortTitleWidth.constant) ];
            
            self.topElementsHorizontalConstraints = @[ self.termsToRoomMark,
                                                       self.roomNumberToTaskType,
                                                       self.taskTypeToShortAreaTitle];
        }
        // case for iPhone 4 or 5 when room is not selected
        else
        {
            self.topElementsWidthsArray = @[ @(self.taskTermsWidth.constant),
                                             @(self.taskStatusMarkWidth.constant),
                                             @(self.shortTitleWidth.constant) ];
            
            self.topElementsHorizontalConstraints = @[ self.dateToTypeHorizontalConstraint,
                                                       self.taskTypeToShortAreaTitle];
        }
    }
    // case for all other devices when room is selected
    else
    {
        if ( content.roomNumber != 0 )
        {
            self.topElementsWidthsArray = @[ @(self.taskTermsWidth.constant),
                                             @(self.roomNumberLabelWidth.constant),
                                             @(self.taskStatusMarkWidth.constant),
                                             @(self.shortTitleWidth.constant) ];
            
            self.topElementsHorizontalConstraints = @[ self.termsToRoomMark,
                                                       self.roomNumberToTaskType,
                                                       self.taskTypeToShortAreaTitle,
                                                       self.areaShortTitleToAccessBtn ];
        }
        // case for all other devices when room is not selected
        else
        {
            self.topElementsWidthsArray = @[ @(self.taskTermsWidth.constant),
                                             @(self.taskStatusMarkWidth.constant),
                                             @(self.shortTitleWidth.constant) ];
            
            self.topElementsHorizontalConstraints = @[ self.dateToTypeHorizontalConstraint,
                                                       self.taskTypeToShortAreaTitle,
                                                       self.areaShortTitleToAccessBtn ];
        }
        
        
        
    }
}

- (void) handleHorizontalConstraintsForContent: (TaskRowContent*) content
{
    __block CGFloat allElementsWidths = 0;
    
    CGFloat emptySpace = 0;
    
    CGFloat floatDistanceBetweenElements = 0;
    
    // counting all floating elements widthes
    [self.topElementsWidthsArray enumerateObjectsUsingBlock: ^(NSNumber* width, NSUInteger idx, BOOL * _Nonnull stop) {
        
        allElementsWidths += width.floatValue;
        
    }];
    
    // adding width of room mark plus it's constraints values
    if ( content.roomNumber != 0 )
    {
        allElementsWidths += self.roomNumberMarkImageView.frame.size.width + 2.5;
    }
    
    allElementsWidths += self.termsLabelLeading.constant;
    
    if ( IS_IPHONE_5 || IS_IPHONE_4_OR_LESS )
    {
        allElementsWidths += 15; // 15 - area short title trailing to right edge
    }
    else
    {
        allElementsWidths += self.accessBtn.frame.size.width;
    }
    
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



#pragma mark - Internal -

- (void) handleUrgentMark: (BOOL) isUrgent
{
    self.isUrgentImageView.hidden = isUrgent? NO : YES;
    
    self.termsLabelLeading.constant = isUrgent? 32 : 15;
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
