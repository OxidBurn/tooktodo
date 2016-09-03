//
//  OfflineTableViewCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OfflineTableViewCell.h"

@interface OfflineTableViewCell()

// properties

@property (weak, nonatomic) IBOutlet UILabel *settingTitle;

@property (weak, nonatomic) IBOutlet UILabel *settingSize;

// methods

- (IBAction) onToggleEnableState: (UISwitch*) sender;

@end

@implementation OfflineTableViewCell

#pragma mark - Public methods -

- (void) fillTitleValue: (NSString*) title
          withSizeValue: (NSString*) size
{
    self.settingTitle.text = title;
    self.settingSize.text  = size;
}

#pragma mark - Actions -

- (IBAction) onToggleEnableState: (UISwitch*) sender
{
    if ( self.didToggleEnableState )
        self.didToggleEnableState(sender.isOn);
}

@end
