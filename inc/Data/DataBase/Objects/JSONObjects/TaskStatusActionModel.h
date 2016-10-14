//
//  TaskStatusActionModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol TaskStatusActionModel;

@interface TaskStatusActionModel : JSONModel

@property (strong, nonatomic) NSNumber* statusActionID;

@property (strong, nonatomic) NSString* stautsActionDescription;

@end
