//
//  TaskRoomLavelModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TaskRoomLavelModel : JSONModel

@property (assign, nonatomic) NSUInteger id;
@property (assign, nonatomic) NSUInteger level;

@end
