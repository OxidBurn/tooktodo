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
@property (weak, nonatomic) IBOutlet UISwitch *switchControl;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


// methods
- (IBAction)onSwitchControl:(UISwitch *)sender;


@end

@implementation OSSwitchTableCell

- (IBAction) onSwitchControl: (UISwitch*) sender
{
    
}
@end
