//
//  AddTaskTermsViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 19.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskTermsViewModel.h"

// Classes
#import "AddTaskTermsModel.h"

@interface AddTaskTermsViewModel() <AddTaskTermsModelDelegate>

// properties
@property (strong, nonatomic) AddTaskTermsModel* model;

@property (strong, nonatomic) NSArray* expandedCellIndexes;

@property (assign, nonatomic) BOOL startDatePickerShowed;

@property (assign, nonatomic) BOOL endDatePickerShowed;

// methods


@end

@implementation AddTaskTermsViewModel

#pragma mark - Properties -

- (AddTaskTermsModel*) model
{
    if ( _model == nil )
    {
        _model = [AddTaskTermsModel new];
        
        _model.delegate = self;
        
        self.startDatePickerShowed = NO;
        self.endDatePickerShowed   = NO;
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

#pragma mark - UITableViewDataSource methods -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 1;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger) section
{
    return [self.model getNumberOfRows];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    return [self.model returnCellForTableView: (UITableView*) tableView
                                withIndexPath: (NSIndexPath*) indexPath];
}
- (CGFloat)    tableView: (UITableView*) tableView
 heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    CGFloat height;
    
    switch ( indexPath.row )
    {
        case 0:
        case 2:
        case 4 ... 6:
            
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

#pragma mark - UITableViewDelegate methods -

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
            
            [self reloadDatePickerCellsForTableView: tableView];
            
            break;
            
        case 2:
            
            [self checkIfStartPickerIsExpandedForTableView: tableView];
            
            self.endDatePickerShowed = !self.endDatePickerShowed;
            
            [self reloadDatePickerCellsForTableView: tableView];
            
            break;
            
        default:
            break;
    }
    
}

#pragma mark - Public -

- (void) updateTerms: (TermsData*) terms
{
    [self.model updateTerms: terms];
}

- (TermsData*) returnTerms
{
    return [self.model returnTerms];
}

#pragma mark - AddTaskTermsModelDelegate methods -

- (void) reloadTermsTableView
{
    if ( [self.delegate respondsToSelector: @selector(reloadAddTaskTableView)] )
         [self.delegate reloadAddTaskTableView];
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
        
        [self.model setDefaultStartDayIfNotSetByPicker];
        
        [self reloadDatePickerCellsForTableView: tableView];
    }
}

- (void) reloadDatePickerCellsForTableView: (UITableView*) tableView
{
    [tableView reloadRowsAtIndexPaths: self.expandedCellIndexes
                     withRowAnimation: UITableViewRowAnimationFade];
}


@end
