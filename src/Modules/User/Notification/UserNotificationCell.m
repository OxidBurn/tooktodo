//
//  UserNotificationCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserNotificationCell.h"

@interface UserNotificationCell()

// properties
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;

@property (weak, nonatomic) IBOutlet UISwitch* switchControll;

// methods

- (IBAction) onSwitchBtn: (UISwitch*) sender;

@end

@implementation UserNotificationCell

#pragma mark - Public -

- (void) fillCellWithText: (NSString*) cellText
            withSwitchTag: (NSNumber*) switchTag
          withSwitchValue: (BOOL)      switchValue
{
    self.titleLabel.text    = cellText;
    self.switchControll.tag = switchTag.integerValue;
    self.switchControll.on  = switchValue;
    
}

#pragma mark - Actions -

- (IBAction) onSwitchBtn: (UISwitch*) sender
{
    if ( self.didChangeValue )
        self.didChangeValue(self.tag, sender.tag, sender.isOn);
}

@end
