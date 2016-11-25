//
//  TaskFilterModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskFilterModel.h"

// Classes
#import "TaskFilterContentManager.h"
#import "ProjectInfo+CoreDataProperties.h"
#import "DataManager+ProjectInfo.h"
#import "TaskFilterConfiguration.h"
#import "TaskFiltersService.h"

@interface TaskFilterModel()

// properties
@property (strong, nonatomic) NSArray* tableViewContent;

@property (strong, nonatomic) NSArray* seguesId;

@property (strong, nonatomic) ProjectInfo* projectInfo;

@property (strong, nonatomic) TaskFilterConfiguration* filterConfig;

@property (strong, nonatomic) TaskFilterContentManager* contentManager;

@property (assign, nonatomic) TasksFilterType taskFilterType;

// methods


@end

@implementation TaskFilterModel


#pragma mark - Properties -

- (TaskFilterContentManager*) contentManager
{
    if ( _contentManager == nil )
    {
        _contentManager = [TaskFilterContentManager new];
    }
    
    return _contentManager;
}

- (NSArray*) seguesId
{
    if ( _seguesId == nil )
    {
        _seguesId = @[ @[@"FilterByCreatorSegueId",
                         @"FilterByResponsibleSegueId",
                         @"FilterByApproversSegueId",
                         @"FilterByStatusSegueId"],
                       @[@"ShowFilterByDatesSegueId",
                         @"ShowFilterByDatesSegueId"] ];
    }
    
    return _seguesId;
}

- (ProjectInfo*) projectInfo
{
    if ( _projectInfo == nil )
    {
        _projectInfo = [DataManagerShared getSelectedProjectInfo];
    }
    
    return _projectInfo;
}
- (NSArray*) tableViewContent
{
    if ( _tableViewContent == nil )
    {
        _tableViewContent = [self.contentManager getTableViewContentForConfiguration: self.filterConfig
                                                                      withFilterType: self.taskFilterType];
    }
    
    return _tableViewContent;
}

- (TaskFilterConfiguration*) filterConfig
{
    if ( _filterConfig == nil )
    {
        _filterConfig = [TaskFilterConfiguration new];
    }
    
    return _filterConfig;
}


#pragma mark - Public -

- (TaskFilterRowContent*) getRowContentForIndexPath: (NSIndexPath*) indexPath
{
    TaskFilterRowContent* content = self.tableViewContent[indexPath.section][indexPath.row];
    
    return content;
}

- (NSUInteger) getNumberOfRowsIsSection: (NSUInteger) section
{
    NSUInteger numberOfRows = [self.tableViewContent[section] count];
    
    return numberOfRows;
}

- (NSString*) getSegueIdForIndexPath: (NSIndexPath*) indexPath
{
    return self.seguesId[indexPath.section][indexPath.row];
}

- (CGFloat) getRowHeightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    NSArray* sectionContent = self.tableViewContent[indexPath.section];
    
    TaskFilterRowContent* content = sectionContent[indexPath.row];
    
    return content.rowHeight;
}

- (void) didSelectTermsCellForIndexPath: (NSIndexPath*) indexPath
{
    NSArray* sectionContent = self.tableViewContent[indexPath.section];
    
    TaskFilterRowContent* content = sectionContent[indexPath.row];
    
    BOOL isExpanded = [content.cellId isEqualToString: @"FilterByTermsCellID"];
    
    NSString* newCellId = isExpanded ? @"CustomDisclosureIconCellID" : @"FilterByTermsCellID";
    
    CGFloat newRowHeight = isExpanded ? 50 : 110;
    
    NSUInteger cellIdType = isExpanded? TaskFilterCustomDisclosureCell : TaskFilterFilterByTermsCell;
    
    content.rowHeight  = newRowHeight;
    content.cellId     = newCellId;
    content.cellTypeId = cellIdType;
    
    NSMutableArray* newContentArray = self.tableViewContent.mutableCopy;
    
    NSMutableArray* newSectionContent = sectionContent.mutableCopy;
    
    [newSectionContent replaceObjectAtIndex: indexPath.row
                                 withObject: content];
    
    [newContentArray replaceObjectAtIndex: indexPath.section
                               withObject: newSectionContent];
    
    self.tableViewContent = newContentArray.copy;
}

- (void) fillFilterType: (TasksFilterType) filterType
{
    self.taskFilterType = filterType;
}

// method to save data with assignees
- (void) fillSelectedAssigneesData: (NSArray*)             selectedAssignees
                       withIndexes: (NSArray*)             indexesArray
                     forFilterType: (FilterByAssigneeType) filterType
{
    switch ( filterType )
    {
        case FilterByCreator:
        {
            self.filterConfig.byCreator        = selectedAssignees;
            self.filterConfig.byCreatorIndexes = indexesArray;
        }
            break;
        
        case FilterByResponsible:
        {
            self.filterConfig.byResponsible        = selectedAssignees;
            self.filterConfig.byResponsibleIndexes = indexesArray;
        }
            break;
            
        case FilterByApprovers:
        {
            self.filterConfig.byApprovers        = selectedAssignees;
            self.filterConfig.byApproversIndexes = indexesArray;
        }
            break;
            
        default:
            break;
    }
    
    [self updateContent];
}

- (void) fillSelectedStatusesData: (NSArray*) selectedStatuses
{
    self.filterConfig.statusesList = selectedStatuses;
    
    [self updateContent];
}

// helpers for test
- (void) saveFilterConfigurationWithCompletion: (CompletionWithSuccess) completion
{
    [[TaskFiltersService sharedInstance] saveFilterConfiguration: self.filterConfig
                                                  withCompletion: completion];
}

- (void) resetFilterConfigurationForCurrentProject: (CompletionWithSuccess) completion
{
    [[TaskFiltersService sharedInstance] resetFilterConfigurationForCurrentProject: completion];
}

- (TaskFilterConfiguration*) getFilterConfig
{
    return self.filterConfig;
}


#pragma mark - Helpers -

- (void) updateContent
{
    self.tableViewContent = [self.contentManager getTableViewContentForConfiguration: self.filterConfig
                                                                      withFilterType: self.taskFilterType];
}

@end
