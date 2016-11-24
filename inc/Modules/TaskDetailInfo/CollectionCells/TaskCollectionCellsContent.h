//
//  TaskCollectionCellsContent.h
//  TookTODO
//
//  Created by Chaban Nikolay on 06.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskCollectionCellsContent : NSObject

@property (strong, nonatomic) NSString* cellId;

@property (strong, nonatomic) NSString* cellTitle;

@property (strong, nonatomic) NSString* cellDetail;

@property (strong, nonatomic) NSArray* taskOwner;

@property (assign, nonatomic) NSUInteger roomNumber;

@property (strong, nonatomic) NSArray* responsible;

@property (strong, nonatomic) NSArray* claiming;

@property (strong, nonatomic) NSArray* observers;

@property (strong, nonatomic) NSString* premises;

@property (assign, nonatomic) BOOL taskStatus;

@property (strong, nonatomic) UIImage* taskOnPlanImage;

@property (nonatomic, assign) BOOL hasApprovedTask;

@end
