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
{
    self.titleLabel.text    = cellText;
    self.switchControll.tag = switchTag.integerValue;
}

#pragma mark - Actions -

- (IBAction) onSwitchBtn: (UISwitch*) sender
{
    NSLog(@"Switch nubmer %ld", (long)sender.tag);
}

@end
