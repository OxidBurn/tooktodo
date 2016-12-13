//
//  ProjectSystemsObject.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ProjectSystemsModel : JSONModel

@property (strong, nonatomic) NSNumber* systemID;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* shortTitle;
@property (assign, nonatomic) BOOL hasTasks;

@end
