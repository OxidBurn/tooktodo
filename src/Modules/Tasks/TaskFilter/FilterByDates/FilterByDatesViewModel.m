//
//  FilterByDatesViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 03.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByDatesViewModel.h"

// Classes
#import "FilterByDatesModel.h"
#import "FilterByDatesFactory.h"

@interface FilterByDatesViewModel()

// properties
@property (strong, nonatomic) FilterByDatesModel* model;

@property (strong, nonatomic) NSArray* expandedCellIndexes;

@property (assign, nonatomic) BOOL startDatePickerShowed;

@property (assign, nonatomic) BOOL endDatePickerShowed;

@property (assign, nonatomic) BOOL anyPickerShowed;

// methods


@end

@implementation FilterByDatesViewModel


#pragma mark - Properties -

- (FilterByDatesModel*) model
{
    if ( _model == nil )
    {
        _model = [FilterByDatesModel new];
    }
    
    return _model;
}

- (NSArray*) expandedCellIndexes
{
    if ( _expandedCellIndexes == nil )
    {
        _expandedCellIndexes = @[[NSIndexPath indexPathForRow: 1 inSection: 0],
                                 [NSIndexPath indexPathForRow: 3 inSection: 0]];
    }
    
    return _expandedCellIndexes;
}


#pragma mark - UITableView data sourse methods-

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 1;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return 4;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    FilterByDatesFactory* factory = [FilterByDatesFactory new];
    
    RowContent* content = [self.model getRowContentForIndexPath: indexPath];
    
    UITableViewCell* cell = [factory returnCellForTableView: tableView
                                              withIndexPath: indexPath
                                                withContent: content
                                               withDelegate: self];
    
    return cell;
}

- (CGFloat)    tableView: (UITableView*) tableView
 heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    CGFloat height;
    
    switch ( indexPath.row )
    {
        case 0:
        case 2:
            
            height = 42;
            
            break;
            
        case 1:
            
            height = self.startDatePickerShowed ? 216 : 0;
            
            break;
            
        case 3:
            
            height = self.endDatePickerShowed ? 216 : 0;;
            
            break;
            
        default:
            break;
    }
    
    return height;
}

#pragma mark - UITableView delegate methods -



- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    switch ( indexPath.row )
    {
        case 0:
            
            [self checkIfEndPickerIsExpandedForTableView: tableView];
            
            self.startDatePickerShowed = !self.startDatePickerShowed;
            
            [self checkIfAnyPickerShowed];
            
            [self reloadDatePickerCellsForTableView: tableView];
            
            break;
            
        case 2:
            
            [self checkIfStartPickerIsExpandedForTableView: tableView];
            
            self.endDatePickerShowed = !self.endDatePickerShowed;
            
            [self checkIfAnyPickerShowed];

            [self reloadDatePickerCellsForTableView: tableView];
            
            break;
            
        default:
            break;
    }
    
}


#pragma mark - Helpers -


- (void) checkIfEndPickerIsExpandedForTableView: (UITableView*) tableView
{
    if ( self.endDatePickerShowed )
    {
        self.endDatePickerShowed = NO;
        
        [self reloadDatePickerCellsForTableView: tableView];
    }
}

- (void) checkIfStartPickerIsExpandedForTableView: (UITableView*) tableView
{
    if ( self.startDatePickerShowed )
    {
        self.startDatePickerShowed = NO;
        
        //[self.model setDefaultStartDayIfNotSetByPicker];
        
        [self reloadDatePickerCellsForTableView: tableView];
    }
}

- (void) reloadDatePickerCellsForTableView: (UITableView*) tableView
{
    [tableView reloadRowsAtIndexPaths: self.expandedCellIndexes
                     withRowAnimation: UITableViewRowAnimationFade];
}

- (void) checkIfAnyPickerShowed
{
    if ( self.startDatePickerShowed || self.endDatePickerShowed )
    {
        self.anyPickerShowed = YES;
        
        if ( self.handleTableViewHeight )
            self.handleTableViewHeight (YES);
    }
    else
    {
        self.anyPickerShowed = NO;
        
        if ( self.handleTableViewHeight )
            self.handleTableViewHeight (NO);
    }
}

@end