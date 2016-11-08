//
//  FlexibleViewsContainer.m
//  TookTODO
//
//  Created by Nikolay Chaban on 08.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FlexibleViewsContainer.h"

@interface FlexibleViewsContainer()

// properties
@property (assign, nonatomic) FlexibleViewsContainerType viewType;

@property (strong, nonatomic) NSArray* viewsArray;

// methods
- (void) countFrame;

@end

@implementation FlexibleViewsContainer


#pragma mark - Initialization -

- (instancetype) initWithType: (FlexibleViewsContainerType) viewType
{
    self = [super init];
    
    if ( self )
    {
        self.viewType = viewType;
    }
    
    return self;
}


#pragma mark - Public -

- (void) fillViewsContainerWithViews: (NSArray*) viewsArray
{
    self.viewsArray = viewsArray;
}


#pragma mark - Internal -


- (void) countFrame
{
    
}

@end
