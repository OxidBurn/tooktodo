//
//  AllTasksViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AllTasksViewModel.h"

// Classes
#import "AllTasksModel.h"
#import "TasksProjectTitleView.h"
#import "ProjectInfo.h"

@interface AllTasksViewModel()

// properties

@property (strong, nonatomic) AllTasksModel* model;

// methods


@end

@implementation AllTasksViewModel


#pragma mark - Properties -

- (AllTasksModel*) model
{
    if ( _model == nil )
    {
        _model = [AllTasksModel new];
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

- (nullable UIView*) tableView: (UITableView*) tableView
        viewForHeaderInSection: (NSInteger)    section
{
    TasksProjectTitleView* projectInfoView = [[MainBundle loadNibNamed: @"AllTasksProjectTitleView"
                                                                 owner: self
                                                               options: nil] firstObject];

    projectInfoView.tag = section;
    
    ProjectInfo* project = [self.model getProjectInfoForSection: section];

    [projectInfoView fillInfo: project];
    
    // Handle changing expand state of the project
    __weak typeof(self) blockSelf = self;
    
    projectInfoView.didChangeExpandState = ^( NSUInteger section ){
        
        [blockSelf.model markProjectAsExpanded: section
                                withCompletion: ^(BOOL isSuccess) {
                                   
                                    [tableView reloadData];
                                    
                                }];
        
    };
    
    return projectInfoView;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"StageTypeCellID"];
    
    return cell;
}



@end
