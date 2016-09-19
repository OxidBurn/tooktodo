//
//  ProjectRoleTypeModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/19/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ProjectRoleTypeModel : JSONModel

@property (strong, nonatomic) NSNumber* roleTypeID;

@property (strong, nonatomic) NSString* title;

@end
