//
//  FilterByDatesContentManager.m
//  TookTODO
//
//  Created by Nikolay Chaban on 04.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByDatesContentManager.h"

// Classes
#import "RowContent.h"
#import "ProjectsEnumerations.h"

@interface FilterByDatesContentManager()

// properties
@property (strong, nonatomic) NSArray* cellsIdArray;



// methods


@end

@implementation FilterByDatesContentManager


#pragma mark - Properties -

- (NSArray*) cellsIdArray
{
    if ( _cellsIdArray == nil )
    {
        _cellsIdArray = @[ @"RightDetailCellID",
                           @"DatePickerCellID" ];
    }
    
    return _cellsIdArray;
}


#pragma mark - Public -

- (NSArray*) getFilterByDatesContent
{
    RowContent* rowOne = [RowContent new];
    
    rowOne.cellId        = self.cellsIdArray[FilterByDatesRightDetailCell];
    rowOne.cellTypeIndex = FilterByDatesRightDetailCell;
    // the detail label text should be formated from date in filter configuration
    rowOne.detail        = @"Не выбрано";
    rowOne.title         = @"Начало";
    
    RowContent* rowTwo = [RowContent new];
    
    rowTwo.cellId        = self.cellsIdArray[FilterByDatesDatePickerCell];
    rowTwo.cellTypeIndex = FilterByDatesDatePickerCell;
    rowTwo.pickerTag     = FromDate;
    rowTwo.dateToShow    = [NSDate date];
    rowTwo.minimumDate   = [NSDate date];
    // maximum date should be same as date in BeforeDate picker
    //rowTwo.maximumDate = [NSData date];
    
    RowContent* rowThree = [RowContent new];
    
    rowThree.cellId        = self.cellsIdArray[FilterByDatesRightDetailCell];
    rowThree.cellTypeIndex = FilterByDatesRightDetailCell;
    // the detail label text should be formated from date in filter configuration
    rowThree.detail        = @"Не выбрано";
    rowThree.title         = @"Конец";
    
    RowContent* rowFour = [RowContent new];
    
    rowFour.cellId        = self.cellsIdArray[FilterByDatesDatePickerCell];
    rowFour.cellTypeIndex = FilterByDatesDatePickerCell;
    rowFour.pickerTag     = BeforeDate;
    rowFour.dateToShow    = [NSDate date];
    // the detail label text should be formated from date in filter configuration
    // rowFour.minimumDate = [NSDate date];
    
    NSArray* content = @[ rowOne, rowTwo, rowThree, rowFour ];
    
    return content;
}

@end
