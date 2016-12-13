//
//  TaskActionModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol TaskActionModel;

@interface TaskActionModel : JSONModel

@property (strong, nonatomic) NSNumber* actionID;

@property (strong, nonatomic) NSString* actionDescription;

@end
