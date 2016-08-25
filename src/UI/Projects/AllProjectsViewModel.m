//
//  AllProjectsViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AllProjectsViewModel.h"

// Classes
#import "AllProjectsModel.h"
#import "ProjectInfo.h"
#import "ProjectInfoCell.h"

@interface AllProjectsViewModel()

// properties

@property (strong, nonatomic) NSArray* projectsContent;

@property (strong, nonatomic) AllProjectsModel* model;

// methods


@end

@implementation AllProjectsViewModel

#pragma mark - Properties -

- (AllProjectsModel*) model
{
    if ( _model == nil )
    {
        _model = [[AllProjectsModel alloc] init];
    }
    
    return _model;
}

#pragma mark - Public methods -

- (void) updateProjectsContent
{
    self.projectsContent = [self.model getProjectsContent];
}

- (void) applySortingForProjecstList: (AllProjectsSortingType) type
{
    self.projectsContent = [self.model applyProjectsSortingType: type
                                                        toArray: self.projectsContent];
}

#pragma mark - Table view data source methods -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 1;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return self.projectsContent.count;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    ProjectInfoCell* cell = (ProjectInfoCell*)[tableView dequeueReusableCellWithIdentifier: @"ProjectCellID"];
    
    ProjectInfo* info = self.projectsContent[indexPath.row];
    
    [cell fillContent: info];
    
    __weak typeof(self) blockSelf = self;
    
    cell.didSelectedProject = ^( NSNumber* projectID ){
        
        if ( blockSelf.didSelectedProject )
            blockSelf.didSelectedProject(projectID);
        
    };
    
    return cell;
}

#pragma mark - Table view delegate methods -

- (void)       tableView: (UITableView*) tableView
 didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
}

#pragma mark - Sorting popover delegate -

- (void) didSelectItemAtIndex: (NSUInteger) index
{
    // Apply sorting type to the projects table content
    [self applySortingForProjecstList: index];
    
    // Load new data for table
    if ( self.reloadTable )
        self.reloadTable();
}

@end
