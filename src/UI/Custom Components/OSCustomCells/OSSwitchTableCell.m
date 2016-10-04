//
//  SwitchTableCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSSwitchTableCell.h"

// Classes
#import "ProjectsEnumerations.h"

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
    switch ( sender.tag )
    {
        case AddTaskIsHiddenTaskSwitchTag:
        {
            if ( [self.delegate respondsToSelector: @selector( updateTaskHiddenProperty: )] )
            {
                [self.delegate updateTaskHiddenProperty: sender.isOn];
            }
        }
            break;
            
        case AddTermsIncludingWeekendsSwitchTag:
        case AddTermsIsUrgentTaskSwitchTag:
        {
            if ( [self.delegate respondsToSelector: @selector( updateTermsOption:forTag:)] )
            {
                [self.delegate updateTermsOption: sender.isOn
                                          forTag: sender.tag];
            }
        }
            break;

        default:
            break;
    }

}

#pragma mark - Public -

- (void) fillCellWithTitle: (NSString*)  titleText
                   withTag: (NSUInteger) tag
           withSwitchState: (BOOL)       isSelected
              withDelegate: (id)         delegate
{
    self.titleLabel.text  = titleText;
    
    self.switchControl.on = isSelected;
    
    self.delegate = delegate;
    
    self.switchControl.tag = tag;
}

@end
