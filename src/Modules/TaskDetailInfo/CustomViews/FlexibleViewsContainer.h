//
//  FlexibleViewsContainer.h
//  TookTODO
//
//  Created by Nikolay Chaban on 08.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FlexibleViewsContainerType)
{
    ViewForCommentCell,
    ViewForFilterParameters,
};

@interface FlexibleViewsContainer : UIView

// methods
- (instancetype) initWithType: (FlexibleViewsContainerType) viewType;

- (void) fillViewsContainerWithViews: (NSArray*) viewsArray;

@end
