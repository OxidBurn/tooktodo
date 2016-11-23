//
//  TaskApprovments.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol TaskApprovmentsModel;

@interface TaskApprovmentsModel : JSONModel

@property (strong, nonatomic) NSDate* createDate;
@property (strong, nonatomic) NSNumber* approverUserId;

@end
