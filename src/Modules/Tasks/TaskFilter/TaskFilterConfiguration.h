//
//  TaskFilterConfiguration.h
//  TookTODO
//
//  Created by Nikolay Chaban on 02.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "TermsData.h"

@interface TaskFilterConfiguration : NSObject

// properties
@property (strong, nonatomic) NSArray* byResponsible;

@property (strong, nonatomic) NSArray* byCreator;

@property (strong, nonatomic) NSArray* byApprovers;

@property (strong, nonatomic) NSArray* byResponsibleIndexes;

@property (strong, nonatomic) NSArray* byCreatorIndexes;

@property (strong, nonatomic) NSArray* byApproversIndexes;

@property (strong, nonatomic) NSArray* statusesList;

@property (strong, nonatomic) TermsData* byTermsStart;

@property (strong, nonatomic) TermsData* byTermsEnd;

@property (strong, nonatomic) TermsData* byFactTermsStart;

@property (strong, nonatomic) TermsData* byFactTermsEnd;

@property (strong, nonatomic) NSNumber* byMyRoleInProject;

@property (strong, nonatomic) NSArray* byWorkArea;

@property (strong, nonatomic) NSArray* bySystem;

@property (strong, nonatomic) NSArray* byTaskType;

@property (nonatomic, strong) NSArray* byRooms;

@property (nonatomic, strong) NSArray* byRoomIndexes;

@property (assign, nonatomic) BOOL isDone;

@property (assign, nonatomic) BOOL isCanceled;

@property (assign, nonatomic) BOOL isOverdue;

@end
