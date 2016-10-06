//
//  TaskRowContent.h
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskRowContent : NSObject

@property (strong, nonatomic) NSString* cellId;

@property (assign, nonatomic) CGFloat rowHeight;

@property (strong, nonatomic) NSString* title;

@property (strong, nonatomic) NSDate* taskStartDate;

@property (strong, nonatomic) NSDate* taskEndDate;

@property (strong, nonatomic) NSString* taskDescription;

@property (strong, nonatomic) NSString* taskStatusDescription;

@property (strong, nonatomic) NSString* taskSystemDescription;

@property (assign, nonatomic) NSUInteger roomNumber;

@property (assign, nonatomic) BOOL isHiddenTask;

@property (assign, nonatomic) BOOL isOverdue;

@property (strong, nonatomic) NSString* roomNumberMarkImageName;

@property (strong, nonatomic) NSString* changeStatusMarkImageName;

@property (assign, nonatomic) NSUInteger subtasksNumber;

@property (assign, nonatomic) NSUInteger docsNumber;

@property (assign, nonatomic) NSUInteger commentsNumber;

@property (assign, nonatomic) NSString* taskStatusMarkImageName;

@end
