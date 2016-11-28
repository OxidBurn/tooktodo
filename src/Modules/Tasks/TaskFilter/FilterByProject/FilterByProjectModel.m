//
//  FilterByProjectModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 28.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByProjectModel.h"

// Classes
#import "ProjectInfo+CoreDataProperties.h"
#import "DataManager+ProjectInfo.h"

@interface FilterByProjectModel()

// properties
@property (strong, nonatomic) NSArray* selectedProjectsIndexes;

@property (strong, nonatomic) NSArray* selectedProjects;

@property (strong, nonatomic) NSArray* allProjects;

// methods


@end

@implementation FilterByProjectModel


#pragma mark - Properties -

- (NSArray*) selectedProjects
{
    if ( _selectedProjects == nil )
    {
        _selectedProjects = [NSArray new];
    }
    
    return _selectedProjects;
}

- (NSArray*) selectedProjectsIndexes
{
    if ( _selectedProjectsIndexes == nil )
    {
        _selectedProjectsIndexes = [NSArray new];
    }
    
    return _selectedProjectsIndexes;
}

- (NSArray*) allProjects
{
    if ( _allProjects == nil )
    {
        _allProjects = [DataManagerShared getAllProjects];
    }
    
    return _allProjects;
}


#pragma mark - Public -

- (NSUInteger) getNumberOfRows
{
    return self.allProjects.count;
}

- (NSString*) getCellTitleForIndexPath: (NSIndexPath*) indexPath
{
    ProjectInfo* project = self.allProjects[indexPath.row];
    
    NSString* title = project.title;
    
    return title;
}

- (void) handleProjectSelectionForIndexPath: (NSIndexPath*) indexPath
{
    // adding to array indexes of selected projects
    NSMutableArray* tmp = self.selectedProjectsIndexes.mutableCopy;
    
    NSNumber* index = @(indexPath.row);
    
    if ( [self.selectedProjectsIndexes containsObject: index] )
    {
        [tmp removeObject: index];
    }
    else
        [tmp addObject: index];
    
    self.selectedProjectsIndexes = tmp.copy;
    
    // adding to array selected projects
    NSMutableArray* tmpProjects = self.selectedProjects.mutableCopy;
    
    ProjectInfo* project = self.allProjects[indexPath.row];
    
    if ( [self.selectedProjects containsObject: project] )
    {
        [tmpProjects removeObject: project];
    }
    else
        [tmpProjects addObject: project];
    
    self.selectedProjects = tmpProjects.copy;
}

- (BOOL) getCheckmarkStateForIndexPath: (NSIndexPath*) indexPath
{
    BOOL isSelected;
    
    if ( [self.selectedProjectsIndexes containsObject: @(indexPath.row)] )
        isSelected = YES;
    
    return isSelected;
}

- (NSArray*) getSelectedProjectsArray
{
    return self.selectedProjects;
}

- (NSArray*) getSelectedProjectsIndexes
{
    return self.selectedProjectsIndexes;
}

- (void) fillSelectedProjects: (NSArray*) projects
                  withIndexes: (NSArray*) indexes
{
    self.selectedProjects        = projects;
    self.selectedProjectsIndexes = indexes;
}

- (void) selectAll
{
    self.selectedProjectsIndexes = nil;
    
    __block NSMutableArray* tmp = [NSMutableArray new];

    self.selectedProjects = self.allProjects;
            
    [self.allProjects enumerateObjectsUsingBlock: ^(ProjectInfo* project, NSUInteger idx, BOOL * _Nonnull stop) {
                
                    [tmp addObject: @(idx)];
                
            }];

    
    self.selectedProjectsIndexes = tmp.copy;
}

- (void) deselectAll
{
    self.selectedProjectsIndexes = nil;
    self.selectedProjects        = nil;
}

- (void) fillSelectedProjects: (NSArray*) projects
{
    self.selectedProjects = projects;
}

- (BOOL) checkIfAllSelected
{
    return (self.selectedProjectsIndexes.count == self.allProjects.count);
}

- (void) handleAssigneeSelectionForIndexPath: (NSIndexPath*) indexPath
{
    // adding to array indexes of selected assignee
    NSMutableArray* tmp = self.selectedProjectsIndexes.mutableCopy;
    
    NSNumber* index = @(indexPath.row);
    
    if ( [self.selectedProjectsIndexes containsObject: index] )
    {
        [tmp removeObject: index];
    }
    else
        [tmp addObject: index];
    
    self.selectedProjectsIndexes = tmp.copy;
    
    // adding to array selected assignees
    NSMutableArray* tmpAssignees = self.selectedProjects.mutableCopy;
    
    ProjectInfo* selectedItem = nil;
    
    selectedItem = self.allProjects[indexPath.row];
    
    if ( [self.selectedProjects containsObject: selectedItem] )
    {
        [tmpAssignees removeObject: selectedItem];
    }
    else
        [tmpAssignees addObject: selectedItem];
    
    self.selectedProjects = tmpAssignees.copy;
}

@end
