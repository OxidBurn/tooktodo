//
//  TaskSubTasksModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

// classes
@class ProjectTaskModel;

@protocol ProjectTaskModel;

@interface TaskSubTasksModel : JSONModel

@property (assign, nonatomic) NSUInteger count;
@property (strong, nonatomic) NSArray<ProjectTaskModel> * list;


@end
