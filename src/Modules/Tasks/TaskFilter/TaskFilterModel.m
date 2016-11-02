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

@interface TaskFilterModel()

// properties
@property (strong, nonatomic) NSArray* tableViewContent;

@property (strong, nonatomic) ProjectInfo* projectInfo;

@property (strong, nonatomic) TaskFilterConfiguration* filterConfig;

@property (strong, nonatomic) TaskFilterContentManager* contentManager;

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
        _tableViewContent = [self.contentManager getTableViewContentForConfiguration: self.filterConfig];
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

@end
