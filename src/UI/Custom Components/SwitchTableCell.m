//
//  SwitchTableCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SwitchTableCell.h"

@interface SwitchTableCell()

// properties
@property (weak, nonatomic) IBOutlet UISwitch *switchControl;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


// methods
- (IBAction)onSwitchControl:(UISwitch *)sender;


@end

@implementation SwitchTableCell

- (IBAction)onSwitchControl:(UISwitch *)sender {
}
@end
