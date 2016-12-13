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
- (IBAction) onSwitchControl: (UISwitch*) sender;


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
            
        case FilterByDoneTasksTag:
        case FilterByOverdueTasksTag:
        case FilterByCanceledTasksTag:
        {
            if ( [self.delegate respondsToSelector:@selector(updateFilterParameterWithValue:forTag:)] )
                [self.delegate updateFilterParameterWithValue: sender.isOn
                                                       forTag: sender.tag];
        }

        default:
            break;
    }

}

#pragma mark - Public -

- (void) fillCellWithTitle: (NSString*)  titleText
                   withTag: (NSUInteger) tag
           withSwitchState: (BOOL)       isSelected
              withDelegate: (id)         delegate
          withEnabledState: (BOOL)       isEnabled
{
    self.titleLabel.text  = titleText;
    
    self.switchControl.on = isSelected;
    
    self.delegate = delegate;
    
    self.switchControl.tag = tag;
    
    self.switchControl.enabled = isEnabled;
}

- (void) resetValue
{
    if (self.switchControl.tag == 0)
    {
        [self.switchControl setOn: NO];
    }
}

@end
