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


@end

@implementation OSDatePickerCell

#pragma mark - Public -

- (void) setTagToDatePicker: (NSUInteger) tag
{
    self.datePicker.tag = tag;
}

@end
