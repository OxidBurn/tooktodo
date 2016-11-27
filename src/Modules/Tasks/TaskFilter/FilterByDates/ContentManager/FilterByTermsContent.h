//
//  FilterByTermsContent.h
//  TookTODO
//
//  Created by Nikolay Chaban on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "ProjectsEnumerations.h"

@interface FilterByTermsContent : NSObject

@property (strong, nonatomic) NSString* title;

@property (strong, nonatomic) NSString* detail;

@property (assign, nonatomic) FilterByDatesCellId cellIdIndex;

@property (assign, nonatomic) NSUInteger pickerTag;

@property (strong, nonatomic) NSDate*   dateToShow;

@property (strong, nonatomic) NSDate*   minimumDate;

@property (strong, nonatomic) NSDate*   maximumDate;

@end
