//
//  TaskProjectRoleTypeModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TaskProjectRoleTypeModel : JSONModel

@property (assign, nonatomic) NSUInteger roleTypeID;
@property (strong, nonatomic) NSString* title;

@end
