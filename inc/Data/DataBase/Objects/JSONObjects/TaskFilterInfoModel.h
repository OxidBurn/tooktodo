//
//  TaskFilterInfoModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TaskFilterInfoModel : JSONModel

@property (nonatomic, strong) NSDictionary* items;

@end
