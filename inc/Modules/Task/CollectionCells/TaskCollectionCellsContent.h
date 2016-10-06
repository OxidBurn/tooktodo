//
//  TaskCollectionCellsContent.h
//  TookTODO
//
//  Created by Глеб on 06.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskCollectionCellsContent : NSObject

@property (strong, nonatomic) NSString* cellId;

@property (strong, nonatomic) NSString* cellTitle;

@property (strong, nonatomic) NSArray* responsible;

@property (strong, nonatomic) NSArray* claiming;

@property (strong, nonatomic) NSArray* observers;

@property (strong, nonatomic) NSString* premises;

@property (assign, nonatomic) BOOL taskStatus;

@property (strong, nonatomic) UIImage* taskOnPlanImage;

@end
