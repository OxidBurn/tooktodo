//
//  OSDatePickerCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 19.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSDatePickerCell.h"

// Categories
#import "NSDate-Utilities.h"

@interface OSDatePickerCell()

// properties
@property (weak, nonatomic) IBOutlet UIDatePicker* datePicker;

@property (assign, nonatomic) BOOL currentDateFlag;

// methods

- (IBAction) onDatePicker: (UIDatePicker*) sender;

@end

@implementation OSDatePickerCell

#pragma mark - Public -

- (void) setTagToDatePicker: (NSUInteger) tag
             withDateToShow: (NSDate*)    dateToShow
            withMinimumDate: (NSDate*)    minimumDate
            withMaximumDate: (NSDate*)    maximumDate
               withDelegate: (id)         delegate
{
    self.datePicker.tag  = tag;
    
    if ( self.currentDateFlag == NO )
        if ( dateToShow )
        {
            self.currentDateFlag = YES;
            
            [self.datePicker setDate: dateToShow];
        }
    
    if ( minimumDate )
    {
        if ( tag == 2 )
        {
            minimumDate = [minimumDate dateByAddingDays: 1];
        }
        
        if ( [self.datePicker.date isEarlierThanDate: minimumDate] )
            self.datePicker.date = minimumDate;
    }
    
    
    if ( maximumDate )
        [self.datePicker setMaximumDate: maximumDate];
    
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
