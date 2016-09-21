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
    
    NSDictionary* content = self.tableViewContent[indexPath.row];
    
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    
    NSString* cellID = content[CellIdKey];
    
    NSUInteger cellTypeIndex = [self.termsCellsInfo indexOfObject: cellID];
    
    switch ( cellTypeIndex )
    {
        case RightDetailCell:
        {
            OSRightDetailCellFactory* factory = [OSRightDetailCellFactory new];
            
            cell = [factory returnRightDetailCellWithTitle: content[TitleTextKey]
                                            withDetailText: content[DetailTextKey]
                                              forTableView: tableView];
            break;
        }
            
        case SwitchCell:
        {
            OSSwitchTableCellFactory* factory = [OSSwitchTableCellFactory new];
            
            NSNumber* stateNumberValue = content[SwitchStateKey];
            
            BOOL stateBoolValue = stateNumberValue.boolValue;
            
            cell = [factory returnSwitchCellWithTitle: content[TitleTextKey]
                                      withSwitchState: stateBoolValue
                                         forTableView: tableView];
        }
            
            break;
            
        case DatePickerCell:
        {
            OSDatePickerCellFactory* factory = [OSDatePickerCellFactory new];
            
            NSNumber* tagInNumber = content[DatePickerTagKey];
            
            NSUInteger tag = tagInNumber.integerValue;
            
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

#pragma mark - Internal -

- (NSArray*) createTableViewContent
{
    NSDictionary* rowOne   = @{ CellIdKey       : self.termsCellsInfo[RightDetailCell],
                                DetailTextKey   : @"Не выбрано",
                                TitleTextKey    : @"Начало" };
    
    NSDictionary* rowTwo   = @{ CellIdKey       : self.termsCellsInfo[DatePickerCell],
                                DatePickerTagKey: @(StartDatePicker)};
    
    NSDictionary* rowThree = @{ CellIdKey       : self.termsCellsInfo[RightDetailCell],
                                DetailTextKey   : @"Не выбрано",
                                TitleTextKey    : @"Конец" };
    
    NSDictionary* rowFour  = @{ CellIdKey       : self.termsCellsInfo[DatePickerCell],
                                DatePickerTagKey: @(EndDatePicker) };
    
    NSDictionary* rowFive  = @{ CellIdKey       : self.termsCellsInfo[RightDetailCell],
                                DetailTextKey   : @"0",
                                TitleTextKey    : @"Длительность" };
    
    NSDictionary* rowSix   = @{ CellIdKey       : self.termsCellsInfo[SwitchCell],
                                SwitchStateKey  : @(0),
                                TitleTextKey    : @"Включая выходные дни"};
    
    NSDictionary* rowSeven = @{ CellIdKey       : self.termsCellsInfo[SwitchCell],
                                SwitchStateKey  : @(1),
                                TitleTextKey    : @"Срочная задача" };
    
    return @[ rowOne, rowTwo, rowThree, rowFour, rowFive, rowSix, rowSeven ];
}

#pragma mark - OSDatePickerCellDelegate methods -

- (void) updateDateLabelWithDate: (NSDate*)    date
                forPickerWithTag: (NSUInteger) pickerTag
{
    NSMutableArray* contentCopy = [NSMutableArray arrayWithArray: self.tableViewContent];
        
        switch ( pickerTag )
        {
            case StartDatePicker:
            {
                
                NSString* stringDate = [self getStringFromDate: date];
                
                NSDictionary* newRow = @{ CellIdKey     : self.termsCellsInfo[RightDetailCell],
                                          DetailTextKey : stringDate,
                                          TitleTextKey  : @"Начало" };
                
                [contentCopy removeObjectAtIndex: 0];
                
                [contentCopy insertObject: newRow atIndex: 0];
            }
                break;
                
            case EndDatePicker:
            {
                NSString* stringDate = [self getStringFromDate: date];
                
                NSDictionary* newRow = @{ CellIdKey     : self.termsCellsInfo[RightDetailCell],
                                          DetailTextKey : stringDate,
                                          TitleTextKey  : @"Конец" };
                
                [contentCopy replaceObjectAtIndex: 2 withObject: newRow];
            }
                
            default:
                break;
        }
        
        self.tableViewContent = [contentCopy copy];
        
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

@end
