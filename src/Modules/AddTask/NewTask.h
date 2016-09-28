//
//  NewTask.h
//  TookTODO
//
//  Created by Глеб on 21.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes


@interface NewTask : NSObject

//Properties
@property (strong, nonatomic) NSString* taskName;
@property (strong, nonatomic) NSString* taskDescription;
@property (assign, nonatomic) BOOL      isHiddenTask;
@property (nonatomic, strong) NSString* responsible;
@property (nonatomic, strong) NSArray*  claiming;
@property (nonatomic, strong) NSArray*  observers;
@property (nonatomic, strong) NSDate*   terms;

@end
