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

@property (assign, nonatomic) CGFloat rowHeight;

@property (assign, nonatomic) TaskFilterCellId cellTypeId;

@property (assign, nonatomic) FilterByTermsCellType termsType;

@property (strong, nonatomic) NSString* segueId;

@property (strong, nonatomic) NSString* title;

@property (strong, nonatomic) NSString* detail;

@property (strong, nonatomic) NSString* userFullName;

@property (strong, nonatomic) NSString* avatarUrl;

@property (strong, nonatomic) NSArray* selectedUsers;

@property (nonatomic, strong) NSArray* selectedRooms;

@property (assign, nonatomic) NSUInteger switchControllTag;

@property (assign, nonatomic) BOOL isOn;

@property (assign, nonatomic) BOOL detailIsSelected;

@property (assign, nonatomic) BOOL isExpanded;

@property (strong, nonatomic) NSString* startTermsString;

@property (strong, nonatomic) NSString* endTermsString;

@property (assign, nonatomic) BOOL isStartTermSelected;

@property (assign, nonatomic) BOOL isEndTermsSelected;

@end
