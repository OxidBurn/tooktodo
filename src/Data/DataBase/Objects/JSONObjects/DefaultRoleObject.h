//
//  DefaultRoleObject.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/7/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DefaultRoleObject : JSONModel

@property (strong, nonatomic) NSNumber * roleID;
@property (strong, nonatomic) NSString * title;

@end
