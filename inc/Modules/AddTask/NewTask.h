//
//  NewTask.h
//  TookTODO
//
//  Created by Nikolay Chaban on 21.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "TermsData.h"
#import "ProjectSystem+CoreDataClass.h"
#import "ProjectTaskStage+CoreDataClass.h"

@interface NewTask : NSObject

//Properties
@property (strong, nonatomic) NSString*  taskName;

@property (strong, nonatomic) NSString*  taskDescription;

@property (assign, nonatomic) BOOL       isHiddenTask;

@property (strong, nonatomic) NSArray*   defaultResponsible;

@property (strong, nonatomic) NSArray*   responsible;

@property (strong, nonatomic) NSArray*   claiming;

@property (strong, nonatomic) NSArray*   observers;

@property (strong, nonatomic) TermsData* terms;

@property (nonatomic, strong) ProjectSystem* system;

@property (nonatomic, strong) ProjectTaskStage* stage;

@end
