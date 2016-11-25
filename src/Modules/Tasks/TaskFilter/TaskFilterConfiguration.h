//
//  TaskFilterConfiguration.h
//  TookTODO
//
//  Created by Nikolay Chaban on 02.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskFilterConfiguration : NSObject

// properties
@property (strong, nonatomic) NSArray* byResponsible;

@property (strong, nonatomic) NSArray* byCreator;

@property (strong, nonatomic) NSArray* byApprovers;

@property (strong, nonatomic) NSArray* byResponsibleIndexes;

@property (strong, nonatomic) NSArray* byCreatorIndexes;

@property (strong, nonatomic) NSArray* byApproversIndexes;

@property (strong, nonatomic) NSArray* byStatus;

@property (strong, nonatomic) NSDictionary* byTerms;

@property (strong, nonatomic) NSDictionary* byFactTerms;

@property (strong, nonatomic) NSArray* byWorkArea;

@property (strong, nonatomic) NSArray* bySystem;

@property (strong, nonatomic) NSArray* byTaskType;

@property (assign, nonatomic) BOOL isDone;

@property (assign, nonatomic) BOOL isCanceled;

@property (assign, nonatomic) BOOL isOverdue;

@end
