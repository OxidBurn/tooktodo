//
//  NewProjectRoleTypeModelErrorsModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import <JSONModel/JSONModel.h>

@protocol NewProjectRoleTypeModelErrorsModel;

@interface NewProjectRoleTypeModelErrorsModel : JSONModel

@property (strong, nonatomic) NSString* property;

@property (strong, nonatomic) NSString* message;

@end
