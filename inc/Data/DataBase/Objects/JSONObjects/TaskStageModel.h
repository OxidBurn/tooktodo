//
//  TaskStageModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TaskStageModel : JSONModel

@property (assign, nonatomic) NSUInteger stageID;
@property (assign, nonatomic) BOOL isCommon;
@property (strong, nonatomic) NSString* title;

@end
