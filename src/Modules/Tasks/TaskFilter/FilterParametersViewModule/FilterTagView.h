//
//  FilterTagView.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/28/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "FilterTagParameterInfo.h"
#import "FilterParameterViewDelegate.h"

@interface FilterTagView : UIView

// properties

// methods

- (void) setParameterInfo: (FilterTagParameterInfo*)         info
             withDelegate: (id<FilterParameterViewDelegate>) delegate;

- (void) updateTagValue: (NSUInteger) tag;

@end
