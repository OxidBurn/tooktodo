//
//  TasksGroupedByProjects.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/12/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

// Classes
#import "ProjectTaskModel.h"

@protocol ShortProjectInfoModel;

@interface TasksGroupedByProjects : JSONModel

@property (strong, nonatomic) NSArray<ShortProjectInfoModel> * projects;

@property (strong, nonatomic) NSNumber* tasksCount;

@end

@interface ShortProjectInfoModel : JSONModel

@property (nonatomic) NSUInteger                projectID;
@property (nonatomic) NSUInteger                ownerUserId;
@property (nonatomic) NSString<Optional>        * region;
@property (nonatomic) NSString                  * title;
@property (nonatomic) NSArray<ProjectTaskModel> * tasks;

@end
