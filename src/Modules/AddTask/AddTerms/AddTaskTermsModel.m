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
#import "RowContent.h"


typedef NS_ENUM(NSUInteger, TermsCellsId) {
    
    RightDetailCell,
    SwitchCell,
    DatePickerCell,
    
};

typedef NS_ENUM(NSUInteger, DatePickerTag) {
    
    StartDatePicker,
    EndDatePicker,
};


static NSString* CellIdKey        = @"CellId";
static NSString* DetailTextKey    = @"DetailText";
static NSString* TitleTextKey     = @"TitleText";
static NSString* SwitchStateKey   = @"SwitchState";
static NSString* DatePickerTagKey = @"DatePickerTag";


@interface AddTaskTermsModel() <OSDatePickerCellDelegate>

// properties
@property (strong, nonatomic) NSArray* tableViewContent;

@property (strong, nonatomic) NSArray* termsCellsInfo;

@property (strong, nonatomic) NSDate* startDate;

@property (strong, nonatomic) NSDate* finishDate;

@property (assign, nonatomic) NSUInteger duration;

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
        case RightDetailCell:
        {
            OSRightDetailCellFactory* factory = [OSRightDetailCellFactory new];
            
            cell = [factory returnRightDetailCellWithTitle: content.title
                                            withDetailText: content.detail
                                              forTableView: tableView];
            break;
        }
            
        case SwitchCell:
        {
            OSSwitchTableCellFactory* factory = [OSSwitchTableCellFactory new];
            
            BOOL stateBoolValue = content.switchIsOn;
            
            cell = [factory returnSwitchCellWithTitle: content.title
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
                                           forTableView: tableView
                                           withDelegate: self];
            
        }
            break;
            
        default:
            break;
    }
    
    return cell;
    
}

- (void) updateStartDate: (NSDate*) startDate
          withFinishDate: (NSDate*) finishDate
{
    if ( startDate )
    {
    RowContent* newStartRow = [self createRowForDate: startDate withTitle: @"Начало"];
    
    [self updateContentWithNewRow: newStartRow forIndex: 0];
        
    self.startDate  = startDate;

    }
    
    if ( finishDate )
    {
    RowContent* newFinishRow = [self createRowForDate: finishDate withTitle: @"Конец"];
    
    [self updateContentWithNewRow: newFinishRow forIndex: 2];
    
    self.finishDate = finishDate;
    }
}

- (NSDate*) returnStartDate
{
    return self.startDate;
}

- (NSDate*) returnFinishDate
{
    return self.finishDate;
}

- (NSUInteger) returnDuration
{
    return self.duration;
}

#pragma mark - Internal -

- (NSArray*) createTableViewContent
{
    RowContent* rowOne = [RowContent new];
    
    rowOne.cellId = self.termsCellsInfo[RightDetailCell];
    rowOne.detail = self.startDate ? [self getStringFromDate: self.startDate] : @"Не выбрано";
    rowOne.title  = @"Начало";
    
    RowContent* rowTwo = [RowContent new];
    
    rowTwo.cellId    = self.termsCellsInfo[DatePickerCell];
    rowTwo.pickerTag = StartDatePicker;
    
    RowContent* rowThree = [RowContent new];
    
    rowThree.cellId = self.termsCellsInfo[RightDetailCell];
    rowThree.detail = self.finishDate ? [self getStringFromDate: self.finishDate] : @"Не выбрано";
    rowThree.title  = @"Конец";

    RowContent* rowFour = [RowContent new];
    
    rowFour.cellId    = self.termsCellsInfo[DatePickerCell];
    rowFour.pickerTag = EndDatePicker;
    
    RowContent* rowFive = [RowContent new];
    
    rowFive.cellId = self.termsCellsInfo[RightDetailCell];
    rowFive.detail = @"0";
    rowFive.title  = @"Длительность";
    
    RowContent* rowSix = [RowContent new];
    rowSix.cellId     = self.termsCellsInfo[SwitchCell];
    rowSix.switchIsOn = NO;
    rowSix.title      = @"Включая выходные дни";
    
    RowContent* rowSeven = [RowContent new];
    
    rowSeven.cellId     = self.termsCellsInfo[SwitchCell];
    rowSeven.switchIsOn = YES;
    rowSeven.title      = @"Включая выходные дни";
    
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
                
                [self updateContentWithNewRow: newRow forIndex: 0];
                
                self.startDate = date;
                
                [self updateDuration];
            }
                break;
                
            case EndDatePicker:
            {
                RowContent* newRow = [self createRowForDate: date
                                                  withTitle: @"Конец"];
                
                [self updateContentWithNewRow: newRow forIndex: 2];
                
                self.finishDate = date;

                [self updateDuration];
            }
                
            default:
                break;
        }
    
        if ([self.delegate respondsToSelector: @selector(reloadTermsTableView)] )
            [self.delegate reloadTermsTableView];
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

    [contentCopy replaceObjectAtIndex: index withObject: newRow];
    
    self.tableViewContent = [contentCopy copy];
}

- (RowContent*) createRowForDate: (NSDate*) date
                       withTitle: (NSString*) title
{
    RowContent* newRow = [RowContent new];
    
    newRow.detail = [self getStringFromDate: date];
    newRow.title  = title;
    newRow.cellId = self.termsCellsInfo[RightDetailCell];
    
    return newRow;
}

- (void) updateDuration
{
    
}

@end
