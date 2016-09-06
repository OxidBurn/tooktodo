//
//  AllProjectsViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AllProjectsViewModel.h"

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "AllProjectsModel.h"
#import "ProjectInfo.h"
#import "ProjectInfoCell.h"
#import "ProjectsEnumerations.h"

// Extensions
#import "UISearchBar+TextFieldControl.h"

typedef NS_ENUM(NSUInteger, SearchTableState)
{
    TableNormalState,
    TableSearchState,
};

static CGFloat sectionHeaderHeight = 30;

@interface AllProjectsViewModel() <UISearchBarWithClearButtonDelegate>

// properties

@property (strong, nonatomic) NSArray* projectsContent;

@property (strong, nonatomic) NSArray* filteredProjectsContent;

@property (strong, nonatomic) AllProjectsModel* model;

@property (assign, nonatomic) SearchTableState tableState;

@property (assign, nonatomic) BOOL isCanceledSearch;

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
    @weakify(self)
    
    [[self.model getProjectsContent] subscribeNext: ^(NSArray* projects) {
        
        @strongify(self)
        
        self.projectsContent = projects;
        
        if ( self.reloadTable )
            self.reloadTable();
        
    }];
}

- (void) applySortingForProjecstList: (AllProjectsSortingType)     type
                          isAcceding: (ContentAccedingSortingType) isAcceding
{
    self.projectsContent = [self.model applyProjectsSortingType: type
                                                        toArray: self.projectsContent
                                                     isAcceding: isAcceding];
}

#pragma mark - Table view data source methods -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 1;
}

- (UIView*)   tableView: (UITableView*) tableView
 viewForHeaderInSection: (NSInteger)    section
{
    if ( self.tableState == TableSearchState )
    {
        UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, tableView.frame.size.width, sectionHeaderHeight)];
        
        label.backgroundColor = [UIColor colorWithRed: 0.90 green: 0.91 blue: 0.92 alpha: 1.00];
        label.textColor       = [UIColor colorWithRed:0.75 green:0.76 blue:0.78 alpha:1.00];
        label.textAlignment   = NSTextAlignmentCenter;
        label.font            = [UIFont fontWithName: @"SFUIText-Regular" size: 12];
        label.text            = [NSString stringWithFormat: @"найдено %ld проекта", (unsigned long)self.filteredProjectsContent.count];
        
        return label;
    }
    
    return nil;
}

- (CGFloat)     tableView: (UITableView*) tableView
 heightForHeaderInSection: (NSInteger) section
{
    return (self.tableState == TableNormalState) ? 0 : sectionHeaderHeight;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    switch (self.tableState)
    {
        case TableNormalState:
        {
            return self.projectsContent.count;
            break;
        }
        case TableSearchState:
        {
            return self.filteredProjectsContent.count;
            break;
        }
    }
    
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    ProjectInfoCell* cell = (ProjectInfoCell*)[tableView dequeueReusableCellWithIdentifier: @"ProjectCellID"];
    
    ProjectInfo* info = nil;
    
    switch (self.tableState)
    {
        case TableNormalState:
        {
            info = self.projectsContent[indexPath.row];
            break;
        }
        case TableSearchState:
        {
            info = self.filteredProjectsContent[indexPath.row];
            break;
        }
    }
    
    
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

- (void) didGrowSortingAtIndex: (NSUInteger) index
{
    // Apply sorting type to the projects table content
    [self applySortingForProjecstList: index
                           isAcceding: GrowsSortingType];
    
    // Load new data for table
    if ( self.reloadTable )
        self.reloadTable();
}

- (void) didDiminutionSortingAtIndex: (NSUInteger) index
{
    // Apply sorting type to the projects table content
    [self applySortingForProjecstList: index
                           isAcceding: DiminutionSortingType];
    
    // Load new data for table
    if ( self.reloadTable )
        self.reloadTable();
}


#pragma mark - Search bar delegate methods -

- (void) searchBar: (UISearchBar*) searchBar
     textDidChange: (NSString*)    searchText
{
    if ( self.isCanceledSearch == NO )
    {
        self.filteredProjectsContent = [self.model filteredContentWithSearchText: searchText
                                                                         inArray: self.projectsContent];
        
        if ( self.reloadTable )
            self.reloadTable();
    }
}

- (BOOL) searchBarShouldBeginEditing: (UISearchBar*) sdfsearchBar
{
    return !self.isCanceledSearch;
}

- (void) searchBarTextDidBeginEditing: (UISearchBar*) searchBar
{
    self.tableState              = TableSearchState;
    self.filteredProjectsContent = self.projectsContent;
    
    if ( self.reloadTable )
        self.reloadTable();
}

- (void) searchBarTextDidEndEditing: (UISearchBar*) searchBar
{
    self.tableState              = TableNormalState;
    self.filteredProjectsContent = nil;
    
    if ( self.reloadTable )
        self.reloadTable();
}

- (void) searchBarClearButtonClicked: (id) sender
{
    if ( self.endSearching )
        self.endSearching();
    
    self.isCanceledSearch = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.isCanceledSearch = NO;
        
    });
    
}


#pragma mark - Sorting popver datasource -

- (NSUInteger) selectedItem
{
    return [self.model getProjectsSortedType];
}

- (ContentAccedingSortingType) getProjectsSortAccedingType
{
    return [self.model getProjectsSortAccedingType];
}

- (NSArray*) getPopoverContent
{
    return [self.model getProjectsSortedPopoverContent];
}

@end
