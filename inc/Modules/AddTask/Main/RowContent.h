//
//  RowContent.h
//  TookTODO
//
//  Created by Nikolay Chaban on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "ProjectsEnumerations.h"

@interface RowContent : NSObject

@property (strong, nonatomic) NSString* title;

@property (strong, nonatomic) NSString* detail;

@property (strong, nonatomic) NSArray*  membersArray;

@property (strong, nonatomic) NSString* cellId;

@property (assign, nonatomic) AddTaskTableViewCellType cellIndex;

@property (assign, nonatomic) FilterByDatesCellId filterByDatesIndex;

@property (strong, nonatomic) NSString* segueId;

@property (assign, nonatomic) BOOL      isHidden;

@property (nonatomic, assign) BOOL      isSwitchEnabled;

@property (nonatomic, assign) BOOL      userInteractionEnabled;

@property (nonatomic, strong) UIColor* markImage;

@property (assign, nonatomic) NSUInteger pickerTag;

@property (assign, nonatomic) NSUInteger switchTag;

@property (assign, nonatomic) BOOL       switchIsOn;

@property (strong, nonatomic) NSDate*   dateToShow;

@property (strong, nonatomic) NSDate*   minimumDate;

@property (strong, nonatomic) NSDate*   maximumDate;

- (instancetype) initWithUserInteractionEnabled;

@end
