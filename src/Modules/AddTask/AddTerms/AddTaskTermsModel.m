//
//  AddTaskTermsModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 19.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskTermsModel.h"

// Classes
#import "OSSwitchTableCellFactory.h"
#import "OSRightDetailCellFactory.h"
#import "OSDatePickerCellFactory.h"
#import "OSDatePickerCell.h"
#import "OSSwitchTableCell.h"
#import "RowContent.h"
#import "ProjectsEnumerations.h"
#import "Utils.h"

// Categories
#import "NSCalendar+WeedendsCounting.h"


typedef NS_ENUM(NSUInteger, TermsCellsId) {
    
    TermsRightDetailCell,
    TermsSwitchCell,
    DatePickerCell,
    
};

typedef NS_ENUM(NSUInteger, DatePickerTag) {
    
    StartDatePicker,
    EndDatePicker,
};

typedef NS_ENUM(NSUInteger, SwitchTag) {
    
    IncludingWeekendsSwitch,
    UrgentTaskSwitch,
};

typedef NS_ENUM(NSUInteger, TermsRowsStyles) {
    
    TermsStartDateInfoRow,
    TermsStartDatePickerRow,
    TermsEndDateInfoRow,
    TermEndDatePickerRow,
    TermsTaskDurationRow,
    TermsIncludingWeekendsRow,
    TermsIsUrgentRow,
};

static NSString* CellIdKey        = @"CellId";
static NSString* DetailTextKey    = @"DetailText";
static NSString* TitleTextKey     = @"TitleText";
static NSString* SwitchStateKey   = @"SwitchState";
static NSString* DatePickerTagKey = @"DatePickerTag";


@interface AddTaskTermsModel() <OSDatePickerCellDelegate, OSSwitchTableCellDelegate>

// properties
@property (strong, nonatomic) NSArray* tableViewContent;

@property (strong, nonatomic) NSArray* termsCellsInfo;

@property (strong, nonatomic) TermsData* terms;

// methods


@end

@implementation AddTaskTermsModel

#pragma mark - Properties -

- (NSArray*) tableViewContent
{
    if ( _tableViewContent == nil )
    {
        _tableViewContent = [self createTableViewContent];
    }
    
    return _tableViewContent;
}

- (NSArray*) termsCellsInfo
{
    if ( _termsCellsInfo == nil )
    {
        _termsCellsInfo = @[ @"RightDetailCellID", @"SwitchCellID", @"DatePickerCellID" ];
    }
    
    return _termsCellsInfo;
}

- (TermsData*) terms
{
    if ( _terms == nil )
    {
        _terms = [TermsData new];
    }
    
    return _terms;
}

#pragma mark - Public -

- (NSUInteger) getNumberOfRows
{
    return self.tableViewContent.count;
}

- (UITableViewCell*) returnCellForTableView: (UITableView*) tableView
                              withIndexPath: (NSIndexPath*) indexPath
{
    
    RowContent* content = self.tableViewContent[indexPath.row];
    
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    
    NSString* cellID = content.cellId;
    
    NSUInteger cellTypeIndex = [self.termsCellsInfo indexOfObject: cellID];
    
    switch ( cellTypeIndex )
    {
        case TermsRightDetailCell:
        {
            OSRightDetailCellFactory* factory = [OSRightDetailCellFactory new];
            
            cell = [factory returnRightDetailCellWithTitle: content.title
                                            withDetailText: content.detail
                                              forTableView: tableView];
            break;
        }
            
        case TermsSwitchCell:
        {
            OSSwitchTableCellFactory* factory = [OSSwitchTableCellFactory new];
            
            BOOL stateBoolValue = content.switchIsOn;
            
            cell = [factory returnSwitchCellWithTitle: content.title
                                              withTag: content.switchTag
                                      withSwitchState: stateBoolValue
                                         forTableView: tableView
                                         withDelegate: self];
        }
            
            break;
            
        case DatePickerCell:
        {
            OSDatePickerCellFactory* factory = [OSDatePickerCellFactory new];
                        
            NSUInteger tag = content.pickerTag;
            
            cell = [factory returnDatePickerCellWithTag: tag
                                         withDateToShow: content.dateToShow
                                        withMinimumDate: content.minimumDate
                                        withMaximumDate: content.maximumDate
                                           forTableView: tableView
                                           withDelegate: self];
            
        }
            break;
            
        default:
            break;
    }
    
    return cell;
    
}

- (void) updateTerms: (TermsData*) terms
{
    self.terms = terms;
    
    if ( terms.startDate )
    {
        RowContent* newStartRow = [self createRowForDate: terms.startDate withTitle: @"Начало"];
    
        [self updateContentWithNewRow: newStartRow forIndex: TermsStartDateInfoRow];
        
        self.terms.startDate  = terms.startDate;

    }
    
    if ( terms.endDate )
    {
        RowContent* newEndRow = [self createRowForDate: terms.endDate withTitle: @"Конец"];
    
        [self updateContentWithNewRow: newEndRow forIndex: TermsEndDateInfoRow];
    
        self.terms.endDate = terms.endDate;
    }
}

- (TermsData*) returnTerms
{
    return self.terms;
}

- (void) setDefaultStartDayIfNotSetByPicker
{
    if ( self.terms.startDate == nil )
    {
        [self updateDateLabelWithDate: [NSDate date]
                     forPickerWithTag: 0];
    }
}

#pragma mark - Internal -

- (NSArray*) createTableViewContent
{
    RowContent* rowOne = [RowContent new];
    
    rowOne.cellId = self.termsCellsInfo[TermsRightDetailCell];
    rowOne.detail = self.terms.startDate ? [self getStringFromDate: self.terms.startDate] : @"Не выбрано";
    rowOne.title  = @"Начало";
    
    RowContent* rowTwo = [RowContent new];
    
    rowTwo.cellId      = self.termsCellsInfo[DatePickerCell];
    rowTwo.pickerTag   = StartDatePicker;
    rowTwo.dateToShow  = self.terms.startDate ? self.terms.startDate : [NSDate date];
    rowTwo.minimumDate = [NSDate date];
    rowTwo.maximumDate = self.terms.endDate;
    
    RowContent* rowThree = [RowContent new];
    
    rowThree.cellId = self.termsCellsInfo[TermsRightDetailCell];
    rowThree.detail = self.terms.endDate ? [self getStringFromDate: self.terms.endDate] : @"Не выбрано";
    rowThree.title  = @"Конец";

    RowContent* rowFour = [RowContent new];
    
    rowFour.cellId      = self.termsCellsInfo[DatePickerCell];
    rowFour.pickerTag   = EndDatePicker;
    rowFour.dateToShow  = self.terms.endDate;
    rowFour.minimumDate = self.terms.startDate? self.terms.startDate : [NSDate date];
    
    RowContent* rowFive = [RowContent new];
    
    rowFive.cellId = self.termsCellsInfo[TermsRightDetailCell];
    rowFive.detail = self.terms.duration ? [Utils generateStringOfDaysCount: self.terms.duration] : [Utils generateStringOfDaysCount: 0];
    rowFive.title  = @"Длительность";
    
    RowContent* rowSix = [RowContent new];
    
    rowSix.cellId      = self.termsCellsInfo[TermsSwitchCell];
    rowSix.switchIsOn  = self.terms.includingWeekends? self.terms.includingWeekends : NO;
    rowSix.switchTag   = AddTermsIncludingWeekendsSwitchTag;
    rowSix.title       = @"Включая выходные дни";
    
    RowContent* rowSeven = [RowContent new];
    
    rowSeven.cellId     = self.termsCellsInfo[TermsSwitchCell];
    rowSeven.switchIsOn = self.terms.isUrgent ? self.terms.isUrgent : NO;
    rowSeven.switchTag  = AddTermsIsUrgentTaskSwitchTag;
    rowSeven.title      = @"Срочная задача";
    
    return @[ rowOne, rowTwo, rowThree, rowFour, rowFive, rowSix, rowSeven ];
}

#pragma mark - OSDatePickerCellDelegate methods -

- (void) updateDateLabelWithDate: (NSDate*)    date
                forPickerWithTag: (NSUInteger) pickerTag
{
        switch ( pickerTag )
        {
            case StartDatePicker:
            {
                RowContent* newRow = [self createRowForDate: date
                                                  withTitle: @"Начало"];
                
                [self updateContentWithNewRow: newRow
                                     forIndex: TermsStartDateInfoRow];
                
                RowContent* updatedEndRowMinimumDate = self.tableViewContent[3];
                
                updatedEndRowMinimumDate.minimumDate = date;
                
                [self updateContentWithNewRow: updatedEndRowMinimumDate
                                     forIndex: TermEndDatePickerRow];
                
                self.terms.startDate = date;
                
                [self updateDuration];
                
                
            }
                break;
                
            case EndDatePicker:
            {
                date = [date dateByAddingTimeInterval: 2];
                
                RowContent* newRow = [self createRowForDate: date
                                                  withTitle: @"Конец"];
                
                newRow.dateToShow = date;
                
                [self updateContentWithNewRow: newRow
                                     forIndex: TermsEndDateInfoRow];
                
                self.terms.endDate = date;

                [self updateDuration];
            }
                
            default:
                break;
        }
    
        if ([self.delegate respondsToSelector: @selector(reloadTermsTableView)] )
            [self.delegate reloadTermsTableView];
}

#pragma mark - OSSwitchTableCellDelegate methds -

- (void) updateTermsOption: (BOOL)       isOn
                    forTag: (NSUInteger) tag
{
    switch ( tag )
    {
        case AddTermsIncludingWeekendsSwitchTag:
        {
            self.terms.includingWeekends = isOn;
            
            RowContent* newRow = self.tableViewContent[TermsIncludingWeekendsRow];
            
            newRow.switchIsOn = isOn;
            
            [self updateContentWithNewRow: newRow
                                 forIndex: TermsIncludingWeekendsRow];
            
            [self updateDuration];
        }
            break;
            
        case AddTermsIsUrgentTaskSwitchTag:
        {
            self.terms.isUrgent = isOn;
            
            RowContent* newRow = self.tableViewContent[TermsIsUrgentRow];
            
            newRow.switchIsOn = isOn;
            
            [self updateContentWithNewRow: newRow
                                 forIndex: TermsIsUrgentRow];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Helpers -

- (NSString*) getStringFromDate: (NSDate*) date
{
    NSDateFormatter* formatter = [NSDateFormatter new];
    
    [formatter setDateFormat: @"yyyy dd MM"];
    
    NSString* dateFromString = date ? [formatter stringFromDate: date] : @"Не выбрано";
    
    return dateFromString;
}

- (NSNumber*) getStateInNumber: (BOOL) boolValue
{
    return boolValue ? @(1) : @(0);
}

- (void) updateContentWithNewRow: (RowContent*) newRow
                        forIndex: (NSUInteger)  index
{
    NSMutableArray* contentCopy = [NSMutableArray arrayWithArray: self.tableViewContent];

    [contentCopy replaceObjectAtIndex: index
                           withObject: newRow];
    
    self.tableViewContent = [contentCopy copy];
}

- (RowContent*) createRowForDate: (NSDate*)   date
                       withTitle: (NSString*) title
{
    RowContent* newRow = [RowContent new];
    
    newRow.detail = [self getStringFromDate: date];
    newRow.title  = title;
    newRow.cellId = self.termsCellsInfo[TermsRightDetailCell];
    
    return newRow;
}

- (void) updateDuration
{
    if ( self.terms.startDate && self.terms.endDate )
    {
        NSCalendar* calendar = [NSCalendar autoupdatingCurrentCalendar];

        if ( self.terms.includingWeekends )
        {
            NSDateComponents* components = [calendar components: NSCalendarUnitDay
                                                       fromDate: self.terms.startDate
                                                         toDate: self.terms.endDate
                                                        options: 0];
            
            // Added one day, for correct counting value betweet two days with including end day to duration
            self.terms.duration = [components day] + 1;
        }
        else
        {
            self.terms.duration = [calendar countOfWorkdaysFromDate: self.terms.startDate
                                                 toAndIncludingDate: self.terms.endDate];
        }
        
        RowContent* newRow = self.tableViewContent[TermsTaskDurationRow];
        
        newRow.detail = [Utils generateStringOfDaysCount: self.terms.duration];
        
        [self updateContentWithNewRow: newRow
                             forIndex: TermsTaskDurationRow];
        
        if ([self.delegate respondsToSelector: @selector(reloadTermsTableView)] )
            [self.delegate reloadTermsTableView];
    }
}

@end
