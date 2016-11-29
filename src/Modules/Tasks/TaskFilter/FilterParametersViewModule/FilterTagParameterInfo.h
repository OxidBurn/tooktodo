//
//  FilterTagParameterInfo.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/28/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "ProjectsEnumerations.h"

@interface FilterTagParameterInfo : NSObject

@property (strong, nonatomic) NSString* title;

@property (assign, nonatomic) FilterTagParameterType parameterType;

@property (assign, nonatomic) NSUInteger parameterTag;

@property (strong, nonatomic) NSNumber* parameterValue;

@property (assign, nonatomic) CGRect tagParamterFrame;


// methods

- (instancetype) initWithTitle: (NSString*)              title
             withParameterType: (FilterTagParameterType) type
              withParameterTag: (NSUInteger)             tag
                     withValue: (NSNumber*)              value;

- (void) updatedTagIndex: (NSUInteger) tag;

@end
