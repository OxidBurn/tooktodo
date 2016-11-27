//
//  TaskFilterModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskFilterModel.h"

// Classes
#import "ProjectInfo+CoreDataProperties.h"
#import "DataManager+ProjectInfo.h"
#import "TaskFilterConfiguration.h"
#import "TaskFiltersService.h"
#import "DataManager+Filters.h"
#import "ProjectTaskFilterContent+CoreDataClass.h"

@interface TaskFilterModel()

// properties
@property (strong, nonatomic) NSArray* tableViewContent;

@property (strong, nonatomic) NSArray* seguesIdSingleProject;

@property (strong, nonatomic) NSArray* seguesIdAllProjects;

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

- (NSArray*) seguesIdSingleProject
{
    if ( _seguesIdSingleProject == nil )
    {
        _seguesIdSingleProject = @[ @[@"FilterByCreatorSegueId",
                                      @"FilterByResponsibleSegueId",
                                      @"FilterByApproversSegueId",
                                      @"FilterByStatusSegueId"],
                                    @[@"ShowFilterByDatesSegueId",
                                      @"ShowFilterByDatesSegueId"],
                                    @[@"ShowFilterByRoomsSegueID",
                                      @"ShowFilterBySystems",
                                      @"ShowFilterByTypesSegueID"]];
    }
    
    return _seguesIdSingleProject;
}

- (NSArray*) seguesIdAllProjects
{
    if ( _seguesIdAllProjects == nil )
    {
        _seguesIdAllProjects = @[ @[@"ShowFilterByTypesSegueID"],
                                  @[@"ShowFilterByDatesSegueId",
                                    @"ShowFilterByDatesSegueId"],
                                  @[@"ShowWorkAreaSegueId",
                                    @"FilterByStatusSegueId",
                                    @"ShowFilterByTypesSegueID"]];
    }
    
    return _seguesIdAllProjects;
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
        switch (self.taskFilterType)
        {
            case FilterBySingleProject:
            {
                _filterConfig = [self fillFilterConfigurationForProject];
            }
                break;
                
            case FilterByAllProjects:
            {
                _filterConfig = [TaskFilterConfiguration new];
            }
                break;
        }
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
    NSString* segueId = [NSString new];
    
    switch ( self.taskFilterType )
    {
        case FilterByAllProjects:
        {
            segueId = self.seguesIdAllProjects[indexPath.section][indexPath.row];
        }
            break;
            
        case FilterBySingleProject:
        {
            segueId = self.seguesIdSingleProject[indexPath.section][indexPath.row];
        }
            break;
            
        default:
            break;
    }
    return segueId;
}

- (CGFloat) getRowHeightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    NSArray* sectionContent = self.tableViewContent[indexPath.section];
    
    TaskFilterRowContent* content = sectionContent[indexPath.row];
    
    return content.rowHeight;
}

- (void) didSelectTermsCellForIndexPath: (NSIndexPath*) indexPath
{
    [self.contentManager updateExpandedStateWithIndexPath: indexPath];
    
    self.tableViewContent = [self.contentManager getTableViewContentForConfiguration: self.filterConfig
                                                                      withFilterType: self.taskFilterType];
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

- (void) fillSelectedRoomsData: (NSArray*) selectedRooms
                   withIndexes: (NSArray*) selRoomIndexes
{
    self.filterConfig.byRooms = selectedRooms;
    self.filterConfig.byRoomIndexes = selRoomIndexes;
    
    [self updateContent];
}

- (void) fillSelectedSystemData: (NSArray*) selectedSystems
                   withIndexes: (NSArray*) selectedIndexes
{
    self.filterConfig.bySystem        = selectedSystems;
    self.filterConfig.bySystemIndexes = selectedIndexes;
    
    [self updateContent];
}

- (void) fillSelectedStatusesData: (NSArray*) selectedStatuses
{
    self.filterConfig.statusesList = selectedStatuses;
    
    [self updateContent];
}

- (void) fillSelectedAditionalTermsOptionsWithValue: (BOOL)                           isOn
                                             forTag: (TaskFilterAditionalOptionsTags) tag
{
    switch ( tag )
    {
        case FilterByCanceledTasksTag:
        {
            self.filterConfig.isCanceled = isOn;
        }
            break;
            
        case FilterByOverdueTasksTag:
        {
            self.filterConfig.isOverdue = isOn;
        }
            break;
            
        case FilterByDoneTasksTag:
        {
            self.filterConfig.isDone = isOn;
        }
            break;
            
        default:
            break;
    }
    
    [self updateContent];
}

- (void) fillTaskType: (NSArray*) taskTypes
{
    self.filterConfig.byTaskType = taskTypes;
    
    [self updateContent];
}

- (void) fillSystemInfo: (ProjectSystem*) system
{
    self.filterConfig.bySystem = @[ system ];
}

- (void) fillTermsInfo: (TermsData*)                     terms
     forControllerType: (FilterByDateViewControllerType) controllerType
{
    switch ( controllerType )
    {
        case ByTermsBeginning:
        {
            self.filterConfig.byTermsStart = terms;
        }
            break;
          
        case ByTermsEnding:
        {
            self.filterConfig.byTermsEnd = terms;
        }
            break;
            
        case ByFactTermsBeginning:
        {
            self.filterConfig.byFactTermsStart = terms;
        }
            break;
            
        case ByFactTermsEnding:
        {
            self.filterConfig.byFactTermsEnd = terms;
        }
            break;
            
        default:
            break;
    }
    
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

- (void) updateContentWithRow: (TaskFilterRowContent*) newRow
                    inSection: (NSUInteger)            section
                        inRow: (NSUInteger)            row
{
    NSArray* sectionContent = self.tableViewContent[section];
    
    NSMutableArray* contentCopy = [NSMutableArray arrayWithArray: self.tableViewContent];
    
    NSMutableArray* sectionCopy = [NSMutableArray arrayWithArray: sectionContent];
    
    [sectionCopy replaceObjectAtIndex: row withObject: newRow];
    
    sectionContent = [sectionCopy copy];
    
    [contentCopy replaceObjectAtIndex: section withObject: sectionContent];
    
    self.tableViewContent = [contentCopy copy];
}

- (TaskFilterConfiguration*) fillFilterConfigurationForProject
{
    TaskFilterConfiguration* configuraiton = [TaskFilterConfiguration new];
    
    ProjectTaskFilterContent* filterContent = [DataManagerShared getFilterContentForSelectedProject];
    
    if ( filterContent )
    {
        // --- Approvements ---
        NSMutableArray* approvements = [NSMutableArray arrayWithArray: filterContent.approvementsAssignee.allObjects];
        
        [approvements addObjectsFromArray: filterContent.approvementsInvite.allObjects];
        
        
        
        // --- Dates ---
        TermsData* startDates        = [[TermsData alloc] initWithStartDate: filterContent.startBeginDate
                                                                withEndDate: filterContent.startEndDate];
        TermsData* endDates          = [[TermsData alloc] initWithStartDate: filterContent.closeBeginDate
                                                                withEndDate: filterContent.closeEndDate];
        TermsData* factualStartDates = [[TermsData alloc] initWithStartDate: filterContent.factualStartBeginDate
                                                                withEndDate: filterContent.factualStartEndDate];
        TermsData* factualEndDates   = [[TermsData alloc] initWithStartDate: filterContent.factualCloseBeginDate
                                                                withEndDate: filterContent.factualCloseEndDate];
        
        
        // Filling info
        configuraiton.byCreator            = filterContent.creators.allObjects;
        configuraiton.byCreatorIndexes     = (NSArray*)filterContent.creatorsSelectedIndexes;
        configuraiton.byResponsible        = filterContent.responsibles.allObjects;
        configuraiton.byResponsibleIndexes = (NSArray*)filterContent.responsiblesSelectedIndexes;
        configuraiton.byApprovers          = approvements;
        configuraiton.byApproversIndexes   = (NSArray*)filterContent.approvementsSelectedIndexes;
        configuraiton.statusesList         = (NSArray*)filterContent.statuses;
        configuraiton.byTermsStart         = startDates;
        configuraiton.byTermsEnd           = endDates;
        configuraiton.byFactTermsStart     = factualStartDates;
        configuraiton.byFactTermsEnd       = factualEndDates;
        configuraiton.byTaskType           = (NSArray*)filterContent.types;
        configuraiton.isDone               = filterContent.isDone.boolValue;
        configuraiton.isOverdue            = filterContent.isExpired.boolValue;
        configuraiton.isCanceled           = filterContent.isCanceled.boolValue;
        configuraiton.byRooms              = filterContent.rooms.allObjects;
        configuraiton.byRoomIndexes        = (NSArray*)filterContent.roomsSelectedIndexes;
    }
    
    return configuraiton;
}

@end
