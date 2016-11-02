//
//  TaskFilterRowContent.h
//  TookTODO
//
//  Created by Nikolay Chaban on 02.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "ProjectsEnumerations.h"

@interface TaskFilterRowContent : NSObject

// properties

@property (strong, nonatomic) NSString* cellId;

@property (assign, nonatomic) TaskFilterCellId cellTypeId;

@property (strong, nonatomic) NSString* segueId;

@property (strong, nonatomic) NSString* title;

@property (strong, nonatomic) NSString* detail;

@property (strong, nonatomic) NSString* avatarUrl;

@end
