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
    if ( [self.delegate respondsToSelector: @selector( updateTaskState: )] )
    {
        [self.delegate updateTaskState: [sender isOn]];
    }
}

#pragma mark - Public -

- (void) fillCellWithTitle: (NSString*) titleText
           withSwitchState: (BOOL)      isSelected
              withDelegate: (id)        delegate
{
    self.titleLabel.text  = titleText;
    
    self.switchControl.on = isSelected;
    
    self.delegate = delegate;
}

@end
