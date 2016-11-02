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

@interface TaskFilterModel()

// properties
@property (strong, nonatomic) NSArray* tableViewContent;

@property (strong, nonatomic) ProjectInfo* projectInfo;

// methods


@end

@implementation TaskFilterModel

#pragma mark - Properties -

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
        TaskFilterContentManager* manager = [TaskFilterContentManager new];
        
        _tableViewContent = [manager getTableViewContentForProjectInfo: self.projectInfo];
    }
    
    return _tableViewContent;
}

@end
