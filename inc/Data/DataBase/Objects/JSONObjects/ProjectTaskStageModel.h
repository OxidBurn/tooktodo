//
//  ProjectTaskStageModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 12/2/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

// Classes
#import "ProjectStageTasksListModel.h"

@interface ProjectTaskStageModel : JSONModel

@property (strong, nonatomic) NSNumber* stageID;

@property (strong, nonatomic) NSString<Optional>* title;

@property (strong, nonatomic) NSNumber<Optional>* isCommon;

@property (strong, nonatomic) ProjectStageTasksListModel <Optional>* tasks;

@end
