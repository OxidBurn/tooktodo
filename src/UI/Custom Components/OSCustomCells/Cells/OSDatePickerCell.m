//
//  OSDatePickerCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 19.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSDatePickerCell.h"

@interface OSDatePickerCell()

// properties
@property (weak, nonatomic) IBOutlet UIDatePicker* datePicker;

// methods

- (IBAction) onDatePicker: (UIDatePicker*) sender;

@end

@implementation OSDatePickerCell

#pragma mark - Public -

- (void) setTagToDatePicker: (NSUInteger) tag
               withDelegate: (id)         delegate
{
    self.datePicker.tag = tag;
    
    self.delegate = delegate;
}

#pragma mark - Actions -

- (IBAction) onDatePicker: (UIDatePicker*) sender
{
    if ( [self.delegate respondsToSelector: @selector(updateDateLabelWithDate:forPickerWithTag:)] )
         [self.delegate updateDateLabelWithDate: sender.date
                               forPickerWithTag: sender.tag];
}

@end
