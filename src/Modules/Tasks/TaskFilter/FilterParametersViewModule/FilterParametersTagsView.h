//
//  FilterParametersTagsView.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/28/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "FilterParametersViewDataSource.h"
#import "FilterParameterViewDelegate.h"

@interface FilterParametersTagsView : UIScrollView

// Properties

@property (weak, nonatomic) id<FilterParametersViewDataSource> dataSource;

@property (weak, nonatomic) id<FilterParameterViewDelegate> filterDelegate;

@property (copy, nonatomic) void(^updateHeight)(CGFloat height);

// methods

- (void) reloadContent;

@end
