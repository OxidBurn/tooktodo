//
//  TaskWorkAreaModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TaskWorkAreaModel : JSONModel

@property (assign, nonatomic) BOOL       hasTasks;
@property (assign, nonatomic) NSUInteger workAreaID;
@property (strong, nonatomic) NSString   * shortTitle;
@property (strong, nonatomic) NSString   * title;

@end
