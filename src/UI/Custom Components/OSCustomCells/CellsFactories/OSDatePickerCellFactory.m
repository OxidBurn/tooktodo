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
                                    forTableView: (UITableView*) tableView
{
    OSDatePickerCell* cell = [tableView dequeueReusableCellWithIdentifier: @"DatePickerCellID"];
    
    [cell setTagToDatePicker: pickerTag];
    
    return cell;
}

@end
