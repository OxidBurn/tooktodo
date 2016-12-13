//
//  FilterByDatesModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 03.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "FilterByTermsContent.h"
#import "TaskFilterConfiguration.h"

@interface FilterByDatesModel : NSObject

// methods
- (FilterByTermsContent*) getRowContentForIndexPath: (NSIndexPath*) indexPath;

- (NSUInteger) getNumberOfRows;

- (void) setDefaultStartDayIfNotSetByPicker;

- (void)updateDateLabelWithDate: (NSDate*)    date
               forPickerWithTag: (NSUInteger) pickerTag;

- (void) fillFilterConfig: (TaskFilterConfiguration*)       filterConfig
       withControllerType: (FilterByDateViewControllerType) controllerType;

- (TermsData*) getTermsData;

- (void) setBeforeCurrentDate;

- (void) setAfterCurrentDate;

- (void) setLastWeek;

- (void) setCurrentWeek;

- (void) setLastMonth;

- (void) setCurrentMonth;

@end
