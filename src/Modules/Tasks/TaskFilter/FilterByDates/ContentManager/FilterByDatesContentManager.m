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

typedef NS_ENUM(NSUInteger, FilterByDatesRow)
{
    TermsStartDateInfoRow,
    TermsStartDatePickerRow,
    TermsEndDateInfoRow,
    TermEndDatePickerRow,
};


@interface FilterByDatesContentManager()

// properties
@property (strong, nonatomic) NSArray* cellsIdArray;

@property (strong, nonatomic) NSArray* content;

@property (strong, nonatomic) TermsData* terms;


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

- (NSArray*) getFilterByDatesContentForTerms: (TermsData*) terms
{
    self.terms = terms;
    
    RowContent* rowOne = [RowContent new];
    
    rowOne.cellId    = self.cellsIdArray[FilterByDatesRightDetailCell];
    rowOne.cellIndex = FilterByDatesRightDetailCell;
    rowOne.detail    = terms.startDateString ? terms.startDateString : @"Не выбрано";
    rowOne.title     = @"Начало";
    
    RowContent* rowTwo = [RowContent new];
    
    rowTwo.cellId      = self.cellsIdArray[FilterByDatesDatePickerCell];
    rowTwo.cellIndex   = FilterByDatesDatePickerCell;
    rowTwo.pickerTag   = StartDate;
    rowTwo.dateToShow  = terms.startDate ? terms.startDate : [NSDate date];
    rowTwo.minimumDate = [NSDate date];
    rowTwo.maximumDate = terms.endDate;
    
    RowContent* rowThree = [RowContent new];
    
    rowThree.cellId    = self.cellsIdArray[FilterByDatesRightDetailCell];
    rowThree.cellIndex = FilterByDatesRightDetailCell;
    rowThree.detail    = terms.endDateString ? terms.endDateString : @"Не выбрано";
    rowThree.title     = @"Конец";
    
    RowContent* rowFour = [RowContent new];
    
    rowFour.cellId       = self.cellsIdArray[FilterByDatesDatePickerCell];
    rowFour.cellIndex    = FilterByDatesDatePickerCell;
    rowFour.pickerTag    = EndDate;
    rowFour.dateToShow   = [NSDate date];
    rowFour.detail       = terms.endDateString;
     rowFour.minimumDate = [NSDate date];
    
    NSArray* content = @[ rowOne, rowTwo, rowThree, rowFour ];
    
    self.content = content;
    
    return content;
}

- (NSArray*) updateDateLabelContentWithDate: (NSDate*)    date
                           forPickerWithTag: (NSUInteger) pickerTag
{
    switch ( pickerTag )
    {
        case StartDate:
        {
            self.terms.startDate = date;
            
            RowContent* newRow = [self createRowForDate: date
                                              withTitle: @"Начало"];
            
            self.terms.startDateString = newRow.detail;
            newRow.pickerTag           = StartDate;
            
            [self updateContentWithNewRow: newRow
                                 forIndex: TermsStartDateInfoRow];
            
            RowContent* updatedEndRowMinimumDate = self.content[3];
            
            updatedEndRowMinimumDate.minimumDate = date;
            
            [self updateContentWithNewRow: updatedEndRowMinimumDate
                                 forIndex: TermEndDatePickerRow];
        }
            break;
            
        case EndDate:
        {
            self.terms.endDate = date;
            
            date = [date dateByAddingTimeInterval: 2];
            
            RowContent* newRow = [self createRowForDate: date
                                              withTitle: @"Конец"];
            
            newRow.dateToShow = date;
            newRow.pickerTag  = EndDate;
            
            
            self.terms.endDateString = newRow.detail;
            
            [self updateContentWithNewRow: newRow
                                 forIndex: TermsEndDateInfoRow];
        }
            break;
        default:
            break;
    }
        
    return self.content;
}


- (void) updateContentWithNewRow: (RowContent*) newRow
                        forIndex: (NSUInteger)  index
{
    NSMutableArray* contentCopy = [NSMutableArray arrayWithArray: self.content];
    
    [contentCopy replaceObjectAtIndex: index
                           withObject: newRow];
    
    self.content = [contentCopy copy];
}

- (RowContent*) createRowForDate: (NSDate*)   date
                       withTitle: (NSString*) title
{
    RowContent* newRow = [RowContent new];
    
    newRow.detail    = [self getStringFromDate: date];
    newRow.title     = title;
    newRow.cellId    = self.cellsIdArray[FilterByDatesRightDetailCell];
    newRow.cellIndex = FilterByDatesRightDetailCell;
    
    return newRow;
}

- (NSString*) getStringFromDate: (NSDate*) date
{
    NSDateFormatter* formatter = [NSDateFormatter new];
    
    [formatter setDateFormat: @"yyyy dd MM"];
    
    NSString* dateFromString = date ? [formatter stringFromDate: date] : @"Не выбрано";
    
    return dateFromString;
}

@end
