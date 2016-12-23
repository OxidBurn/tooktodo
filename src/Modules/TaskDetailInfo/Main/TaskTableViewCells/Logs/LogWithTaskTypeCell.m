//
//  LogWithTaskTypeCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 22.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogWithTaskTypeCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "AvatarImageView.h"
#import "StatusMarkerComponent.h"

@interface LogWithTaskTypeCell()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* logInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel* logDateLabel;

@property (weak, nonatomic) IBOutlet StatusMarkerComponent* firstTaskTypeComponent;

@property (weak, nonatomic) IBOutlet StatusMarkerComponent* secondTaskTypeComponent;

@property (weak, nonatomic) IBOutlet UIImageView* arrowSendImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint* componentOneWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint* componentTwoWidthConstraint;

// properties


// methods


@end

@implementation LogWithTaskTypeCell


#pragma mark - Public -

- (void) fillLogCellWithContent: (LogsContent*) logContent
{
    self.logInfoLabel.attributedText = logContent.logText;
    self.logDateLabel.text           = logContent.createdDate;
    
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: logContent.avatarSrs]];
    
    NSString* oldType = [self getTaskTypeDescription: logContent.oldTaskType.integerValue];
    NSString* typeNew = [self getTaskTypeDescription: logContent.taskTypeNew.integerValue];
    
    [self.firstTaskTypeComponent setStatusString: oldType
                                        withType: logContent.oldTaskType.integerValue];
    
    [self.secondTaskTypeComponent setStatusString: typeNew
                                         withType: logContent.taskTypeNew.integerValue];
    
    self.componentOneWidthConstraint.constant = [self countTypeComponentWidthForComponent: self.firstTaskTypeComponent];
    
    self.componentTwoWidthConstraint.constant = [self countTypeComponentWidthForComponent: self.secondTaskTypeComponent];
}


#pragma mark - Helpers -

- (NSString*) getTaskTypeDescription: (TaskType) type
{
    NSString* typeDescription = @"";
    
    switch (type)
    {
        case TaskWorkType:
            typeDescription = @"Работа";
            break;
            
        case TaskAgreementType:
            typeDescription = @"Согласование";
            break;
            
        case TaskObservationType:
            typeDescription = @"Наблюдение";
            break;
            
        case TaskRemarkType:
            typeDescription = @"Замечание";
            break;
    }
    
    return typeDescription;
}

- (CGFloat) countTypeComponentWidthForComponent: (StatusMarkerComponent*) component
{
    // counting of task type view required width
    UILabel* taskTypeLabel = [component getStatusTextLabel];
    
    NSDictionary* taskTypeAtributes = @{NSFontAttributeName : [UIFont fontWithName: taskTypeLabel.font.fontName
                                                                              size: taskTypeLabel.font.pointSize]};
    
    CGSize taskStatusLabelSize = [taskTypeLabel.text sizeWithAttributes: taskTypeAtributes];
    
    // adding 16 - the width of status point mark + distance to label
    return  taskStatusLabelSize.width + 16;
}


@end
