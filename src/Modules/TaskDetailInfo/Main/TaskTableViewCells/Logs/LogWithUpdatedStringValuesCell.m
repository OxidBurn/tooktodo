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
@property (strong, nonatomic) UIColor* darkColor;

// methods


@end

@implementation LogWithUpdatedStringValuesCell


#pragma mark - Properties -

- (UIColor*) darkColor
{
    if ( _darkColor == nil )
    {
        _darkColor = [UIColor colorWithRed: 38.0/256.0
                                     green: 45.0/256.0
                                      blue: 55.0/256.0
                                     alpha: 1.f];
    }
    
    return _darkColor;
}


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
    // handling hidding of elements
    if ( actionType == EditedOldValueType )
    {
        self.arrowSendImageView.hidden   = NO;
        self.logSecondDetailLabel.hidden = NO;
    }
    else
    {
        self.arrowSendImageView.hidden   = YES;
        self.logSecondDetailLabel.hidden = YES;
    }
    
    switch ( actionType )
    {
        case AddedNewValueType:
        {
            self.logFirstDetailLabel.textColor = self.darkColor;
            
            self.logFirstDetailLabel.attributedText = logContent.oldTextValue;
        }
            break;
            
        case EditedOldValueType:
        {
            self.logFirstDetailLabel.textColor  = self.darkColor;
            self.logSecondDetailLabel.textColor = self.darkColor;
            
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
