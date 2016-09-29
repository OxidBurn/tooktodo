//
//  ProjectTasksViewModel.m
//  TookTODO
//
//  Created by Lera on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectTasksViewModel.h"

// Classes
#import "ProjectTasksModel.h"
#import "StageTitleView.h"
#import "ProjectInfo+CoreDataClass.h"
#import "AllTaskBaseTableViewCell.h"
#import "ProjectsEnumerations.h"

@interface ProjectTasksViewModel()

// properties

@property (strong, nonatomic) ProjectTasksModel* model;

// methods


@end

@implementation ProjectTasksViewModel

#pragma mark - Properties -

- (ProjectTasksModel*) model
{
    if ( _model == nil )
    {
        _model = [ProjectTasksModel new];
    }
    
    return _model;
}

#pragma mark - Public methods -

- (RACSignal*) updateContent
{
    return [self.model updateContent];
}

#pragma mark - UITable view data source -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return [self.model countOfSections];
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model countOfRowsInSection: section];
}

- (CGFloat)     tableView: (UITableView*) tableView
 heightForHeaderInSection: (NSInteger)    section
{
    return 59.0f;
}

- (CGFloat)    tableView: (UITableView*) tableView
 heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    return [self.model getCellHeightAtIndexPath: indexPath];
}

- (nullable UIView*) tableView: (UITableView*) tableView
        viewForHeaderInSection: (NSInteger)    section
{
    StageTitleView* stageInfoView = [[MainBundle loadNibNamed: @"StageTitleView"
                                                                 owner: self
                                                               options: nil] firstObject];
    
    stageInfoView.tag = section;
    
    ProjectTaskStage* stage = [self.model getStageForSection: section];
    
    [stageInfoView fillInfo: stage];
    
    // Handle changing expand state of the project
    __weak typeof(self) blockSelf = self;
    
    stageInfoView.didChangeExpandState = ^( NSUInteger section ){
        
        [blockSelf.model markStageAsExpandedAtIndexPath: section
                                         withCompletion:^(BOOL isSuccess) {
                                             [tableView reloadData];
                                         }];
        
    };
    
    return stageInfoView;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    AllTaskBaseTableViewCell* cell = (AllTaskBaseTableViewCell*)[tableView dequeueReusableCellWithIdentifier: [self.model getCellIDAtIndexPath: indexPath]];
    
    [cell fillInfoForCell: [self.model getInfoForCellAtIndexPath: indexPath]];
    
    return cell;
}


#pragma mark - Table view delegate methods -

- (void)       tableView: (UITableView*) tableView
 didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    AllTaskBaseTableViewCell* cell = (AllTaskBaseTableViewCell*)[tableView cellForRowAtIndexPath: indexPath];
    
    AllTasksCellType selectedCellType = cell.cellType;
    
    switch (selectedCellType)
    {
        case AllTasksStageCellType:
        {
            [self.model markStageAsExpandedAtIndexPath: indexPath.section
                                withCompletion: ^(BOOL isSuccess) {
                                            
                                            [tableView reloadData];
                                            
                                        }];
        }
            break;
            
        case AllTasksTaskCellType:
        {
            
        }
            break;
    }
}


@end
