//
//  TaskStagesActionModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol TaskStagesActionModel;

@interface TaskStagesActionModel : JSONModel

@property (strong, nonatomic) NSNumber* stageActionID;

@property (strong, nonatomic) NSString* title;

@property (strong, nonatomic) NSNumber* isCommon;

@end
