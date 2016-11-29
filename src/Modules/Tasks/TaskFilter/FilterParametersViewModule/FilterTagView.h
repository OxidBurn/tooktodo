//
//  FilterTagView.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/28/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "FilterTagParameterInfo.h"

@interface FilterTagView : UIView

// properties
@property (copy, nonatomic) void(^didDeleteParameter)(NSUInteger parameterTag);

// methods

- (void) setParameterInfo: (FilterTagParameterInfo*) info;

@end
