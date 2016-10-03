//
//  OSDatePickerCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 19.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSDatePickerCellFactory.h"

//Classes
#import "OSDatePickerCell.h"

@implementation OSDatePickerCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnDatePickerCellWithTag: (NSUInteger)   pickerTag
                                  withDateToShow: (NSDate*)      dateToShow
                                 withMinimumDate: (NSDate*)      minimumDate
                                 withMaximumDate: (NSDate*)      maximumDate
                                    forTableView: (UITableView*) tableView
                                    withDelegate: (id)           delegate
{
    OSDatePickerCell* cell = [tableView dequeueReusableCellWithIdentifier: @"DatePickerCellID"];
    
    [cell setTagToDatePicker: pickerTag
              withDateToShow: dateToShow
             withMinimumDate: minimumDate
             withMaximumDate: maximumDate
                withDelegate: delegate];
    
    return cell;
}

@end
