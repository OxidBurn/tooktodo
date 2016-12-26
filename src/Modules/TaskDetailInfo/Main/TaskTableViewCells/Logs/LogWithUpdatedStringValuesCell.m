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
            self.logFirstDetailLabel.attributedText = logContent.oldTextValue;
        }
            break;
            
        case EditedOldValueType:
        {
            // showing second label and arrow
            self.arrowSendImageView.hidden   = NO;
            self.logSecondDetailLabel.hidden = NO;
            
            self.logFirstDetailLabel.attributedText  = logContent.oldTextValue;
            self.logSecondDetailLabel.attributedText = logContent.updatedTextValue;
        }
            break;
            
        case DeletedValueType:
        {
            NSAttributedString* text;
            
            if ( logContent.oldTextValue )
                text = [Utils getStrikeoutStringForString: logContent.oldTextValue];
            
            self.logFirstDetailLabel.textColor = [UIColor colorWithRed: 38.0/256.0
                                                                 green: 45.0/256.0
                                                                  blue: 55.0/256.0
                                                                 alpha: 0.5f];
            
            self.logFirstDetailLabel.attributedText = text;
        }
            break;
            
        default:
            break;
    }
}



@end
