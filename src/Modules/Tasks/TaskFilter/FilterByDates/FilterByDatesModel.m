//
//  FilterByDatesModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 03.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByDatesModel.h"

// Classes
#import "FilterByDatesContentManager.h"
#import "TermsData.h"
#import "Utils.h"

// Categories
#import "NSDate+Helper.h"
#import "NSDate-Utilities.h"

@interface FilterByDatesModel()

// properties
@property (strong, nonatomic) FilterByDatesContentManager* contentManager;

@property (strong, nonatomic) NSArray* tableViewContent;

@property (strong, nonatomic) TermsData* terms;

@property (strong, nonatomic) TaskFilterConfiguration* filterConfig;

@property (assign, nonatomic) FilterByDateViewControllerType controllerType;

// methods


@end

@implementation FilterByDatesModel


#pragma mark - Properties -

- (FilterByDatesContentManager*) contentManager
{
    if ( _contentManager == nil )
    {
        _contentManager = [FilterByDatesContentManager new];
    }
    
    return _contentManager;
}

- (NSArray*) tableViewContent
{
    if ( _tableViewContent == nil )
    {
        switch ( self.controllerType )
        {
            case ByTermsBeginning:
            {
                _tableViewContent = [self.contentManager getFilterByDatesContentForTerms: self.filterConfig.byTermsStart];
            }
                break;
                
            case ByTermsEnding:
            {
                _tableViewContent = [self.contentManager getFilterByDatesContentForTerms: self.filterConfig.byTermsEnd];
            }
                break;
                
            case ByFactTermsBeginning:
            {
                _tableViewContent = [self.contentManager getFilterByDatesContentForTerms: self.filterConfig.byFactTermsStart];
            }
                break;
                
            case ByFactTermsEnding:
            {
                _tableViewContent = [self.contentManager getFilterByDatesContentForTerms: self.filterConfig.byFactTermsEnd];
            }
                break;
                
            default:
                break;
        }
    }
    
    return _tableViewContent;
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

- (void) fillFilterConfig: (TaskFilterConfiguration*)       filterConfig
       withControllerType: (FilterByDateViewControllerType) controllerType
{
    self.filterConfig = filterConfig;
    
    self.controllerType = controllerType;
}

- (NSUInteger) getNumberOfRows
{
    return self.tableViewContent.count;
}

- (FilterByTermsContent*) getRowContentForIndexPath: (NSIndexPath*) indexPath
{
    return self.tableViewContent[indexPath.row];
}

- (void) setDefaultStartDayIfNotSetByPicker
{
    if ( self.terms.startDate == nil )
    {
        [self updateDateLabelWithDate: [NSDate date]
                     forPickerWithTag: 1];
    }
}

- (void) updateDateLabelWithDate: (NSDate*)    date
                forPickerWithTag: (NSUInteger) pickerTag
{
    self.tableViewContent = [self.contentManager updateDateLabelContentWithDate: date
                                                               forPickerWithTag: pickerTag];
}

- (TermsData*) getTermsData
{
    return [self.contentManager getTermsData];
}

- (void) setBeforeCurrentDate
{
    self.terms.endDate = [NSDate date];
    
    self.terms.endDateString = [self.contentManager getStringFromDate: [NSDate date]];
    
    [self.contentManager fillTerms: self.terms];
}

- (void) setAfterCurrentDate
{
    self.terms.startDate = [NSDate date];
    
    self.terms.startDateString = [self.contentManager getStringFromDate: [NSDate date]];
    
    [self.contentManager fillTerms: self.terms];
}

- (void) setLastWeek
{
    NSDate* firstDateOfCurrentWeek = [Utils getFirstDateOfPrevWeek];
    NSDate* lastDateOfCurrentWeek  = [Utils getLastDayOfPrevWeek];
    
    self.terms.startDate = firstDateOfCurrentWeek;
    self.terms.endDate   = lastDateOfCurrentWeek;
    
    self.terms.startDateString = [self.contentManager getStringFromDate: firstDateOfCurrentWeek];
    self.terms.endDateString   = [self.contentManager getStringFromDate: lastDateOfCurrentWeek];
    
    [self.contentManager fillTerms: self.terms];
}

- (void) setCurrentWeek
{
    NSDate* firstDateOfCurrentWeek = [Utils getFistDayOfCurrentWeeak];
    NSDate* lastDateOfCurrentWeek  = [Utils getLastDayOfCurrentWeek];
    
    self.terms.startDate = firstDateOfCurrentWeek;
    self.terms.endDate   = lastDateOfCurrentWeek;
    
    self.terms.startDateString = [self.contentManager getStringFromDate: firstDateOfCurrentWeek];
    self.terms.endDateString   = [self.contentManager getStringFromDate: lastDateOfCurrentWeek];
    
    [self.contentManager fillTerms: self.terms];
}

- (void) setLastMonth
{
    NSDate* firstDateOfCurrentMonth = [Utils getFirstDateOfPrevMonth];
    NSDate* lastDateOfCurrentMonth  = [Utils getLastDateOFPrevMonth];
    
    self.terms.startDate = firstDateOfCurrentMonth;
    self.terms.endDate   = lastDateOfCurrentMonth;
    
    self.terms.startDateString = [self.contentManager getStringFromDate: firstDateOfCurrentMonth];
    self.terms.endDateString   = [self.contentManager getStringFromDate: lastDateOfCurrentMonth];
    
    [self.contentManager fillTerms: self.terms];
}

- (void) setCurrentMonth
{
    NSDate* firstDateOfCurrentMonth = [Utils getFirstDateOfCurrentMonth];
    NSDate* lastDateOfCurrentMonth  = [Utils getLastDateOFCurrentMonth];
    
    self.terms.startDate = firstDateOfCurrentMonth;
    self.terms.endDate   = lastDateOfCurrentMonth;
    
    self.terms.startDateString = [self.contentManager getStringFromDate: firstDateOfCurrentMonth];
    self.terms.endDateString   = [self.contentManager getStringFromDate: lastDateOfCurrentMonth];
    
    [self.contentManager fillTerms: self.terms];
}




@end
