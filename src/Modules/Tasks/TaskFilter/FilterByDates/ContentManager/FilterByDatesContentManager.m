//
//  FilterByDatesContentManager.m
//  TookTODO
//
//  Created by Nikolay Chaban on 04.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByDatesContentManager.h"

// Classes
#import "FilterByTermsContent.h"
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

- (TermsData*) terms
{
    if ( _terms == nil )
    {
        _terms = [TermsData new];
    }
    
    return _terms;
}

#pragma mark - Public -

- (NSArray*) getFilterByDatesContentForTerms: (TermsData*) terms
{
    self.terms = terms;
    
    FilterByTermsContent* rowOne = [FilterByTermsContent new];
    
    rowOne.cellIdIndex = FilterByDatesRightDetailCell;
    rowOne.detail      = terms.startDateString ? terms.startDateString : @"Не выбрано";
    rowOne.title       = @"Начало";
    
    FilterByTermsContent* rowTwo = [FilterByTermsContent new];
    
    rowTwo.cellIdIndex   = FilterByDatesDatePickerCell;
    rowTwo.pickerTag     = StartDate;
    rowTwo.dateToShow    = terms.startDate ? terms.startDate : [NSDate date];
    if (terms.endDate)
        rowTwo.maximumDate   = terms.endDate;
    
    FilterByTermsContent* rowThree = [FilterByTermsContent new];
    
    rowThree.cellIdIndex = FilterByDatesRightDetailCell;
    rowThree.detail      = terms.endDateString ? terms.endDateString : @"Не выбрано";
    rowThree.title       = @"Конец";
    
    FilterByTermsContent* rowFour = [FilterByTermsContent new];
    
    rowFour.cellIdIndex    = FilterByDatesDatePickerCell;
    rowFour.pickerTag      = EndDate;
    rowFour.dateToShow     = terms.endDate? terms.endDate : terms.startDate;
    rowFour.minimumDate    = rowTwo.dateToShow;
    
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
            FilterByTermsContent* row = self.content[0];
            
            // updating right detail cell for start date
            self.terms.startDate = date;
            
            NSString* newDetailText = [self getStringFromDate: date];
            
            row.detail = newDetailText;
            
            self.terms.startDateString = newDetailText;
            
            [self updateContentWithNewRow: row
                                 forIndex: TermsStartDateInfoRow];
            
            // updating start picker dateToShow
            FilterByTermsContent* startPickerRow = self.content[1];
            
            startPickerRow.dateToShow = date;
            
            [self updateContentWithNewRow: startPickerRow
                                 forIndex: TermsStartDatePickerRow];
            
            // updating minimum date for second picker
            // it can not be less than date to show in first picker
            FilterByTermsContent* updatedEndRowMinimumDate = self.content[3];
            
            updatedEndRowMinimumDate.minimumDate = date;
            
            [self updateContentWithNewRow: updatedEndRowMinimumDate
                                 forIndex: TermEndDatePickerRow];
        }
            break;
            
        case EndDate:
        {
            self.terms.endDate = date;
            
            date = [date dateByAddingTimeInterval: 2];
            
            FilterByTermsContent* newRow = self.content[2];
            
            newRow.dateToShow = date;
            
            NSString* newDetailText = [self getStringFromDate: date];
            
            newRow.detail = newDetailText;
            
            self.terms.endDateString = newDetailText;
            
            [self updateContentWithNewRow: newRow
                                 forIndex: TermsEndDateInfoRow];
        }
            break;
        default:
            break;
    }
        
    return self.content;
}

- (TermsData*) getTermsData
{
    return self.terms;
}

- (void) updateContentWithNewRow: (FilterByTermsContent*) newRow
                        forIndex: (NSUInteger)            index
{
    NSMutableArray* contentCopy = [NSMutableArray arrayWithArray: self.content];
    
    [contentCopy replaceObjectAtIndex: index
                           withObject: newRow];
    
    self.content = [contentCopy copy];
}

- (NSString*) getStringFromDate: (NSDate*) date
{
    NSDateFormatter* formatter = [NSDateFormatter new];
    
    [formatter setDateFormat: @"yyyy.dd.MM"];
    
    NSString* dateFromString = date ? [formatter stringFromDate: date] : @"Не выбрано";
    
    return dateFromString;
}

@end
