//
//  LogWithUpdatedStringValuesCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogWithUpdatedStringValuesCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "AvatarImageView.h"
#import "ProjectsEnumerations.h"

@interface LogWithUpdatedStringValuesCell()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* logInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel* logDateLabel;

@property (weak, nonatomic) IBOutlet UILabel* logFirstDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel* logSecondDetailLabel;

@property (weak, nonatomic) IBOutlet UIImageView* arrowSendImageView;

// properties


// methods


@end

@implementation LogWithUpdatedStringValuesCell


#pragma mark - Public -

- (void) fillLogCellWithContent: (LogsContent*) logContent
{
    self.logInfoLabel.attributedText = logContent.logText;
    self.logDateLabel.text           = logContent.createdDate;
    
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: logContent.avatarSrs]];
    
    [self handleUIAccordingToActionType: logContent.actionType
                         withLogContent: logContent];
}


#pragma mark - Internal -

- (void) handleUIAccordingToActionType: (LogsActionType) actionType
                        withLogContent: (LogsContent*) logContent
{
    switch ( actionType )
    {
        case AddedNewValueType:
        {
            self.logFirstDetailLabel.text = logContent.oldTextValue;
        }
            break;
            
        case EditedOldValueType:
        {
            // showing second label and arrow
            self.arrowSendImageView.hidden   = NO;
            self.logSecondDetailLabel.hidden = NO;
            
            self.logFirstDetailLabel.text  = logContent.oldTextValue;
            self.logSecondDetailLabel.text = logContent.updatedTextValue;
        }
            break;
            
        case DeletedValueType:
        {
            self.logFirstDetailLabel.text = logContent.oldTextValue;
            
            // ToDo: edit font for current case
        }
            break;
            
        default:
            break;
    }
}



@end
