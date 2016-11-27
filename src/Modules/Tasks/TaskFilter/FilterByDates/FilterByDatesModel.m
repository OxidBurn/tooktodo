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

- (RowContent*) getRowContentForIndexPath: (NSIndexPath*) indexPath
{
    return self.tableViewContent[indexPath.row];
}

- (void) setDefaultStartDayIfNotSetByPicker
{
    if ( self.terms.startDate == nil )
    {
        [self updateDateLabelWithDate: [NSDate date]
                     forPickerWithTag: 0];
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

@end
