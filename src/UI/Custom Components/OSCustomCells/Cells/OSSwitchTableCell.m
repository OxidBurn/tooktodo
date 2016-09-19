//
//  SwitchTableCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSSwitchTableCell.h"

@interface OSSwitchTableCell()

// properties
@property (weak, nonatomic) IBOutlet UISwitch* switchControl;
@property (weak, nonatomic) IBOutlet UILabel*  titleLabel;


// methods
- (IBAction)onSwitchControl:(UISwitch *)sender;


@end

@implementation OSSwitchTableCell


#pragma mark - Actions -

- (IBAction) onSwitchControl: (UISwitch*) sender
{
    
}

#pragma mark - Public -

- (void) fillCellWithTitle: (NSString*) titleText
           withSwitchState: (BOOL)      isSelected
{
    self.titleLabel.text  = titleText;
    
    self.switchControl.on = !isSelected;
}

@end
