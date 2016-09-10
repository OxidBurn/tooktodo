//
//  TaskApprovementsObject.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TaskApprovementsModel : JSONModel

@property (strong, nonatomic) NSDate   * createdDate;
@property (strong, nonatomic) NSNumber * approverUserId;

@end
