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
- (void) addViewAsSubview: (UIView*) view
        beginingFromPoint: (CGPoint) point;
@end

@implementation FlexibleViewsContainer


#pragma mark - Public -

- (void) setTypeToViewsContainer: (FlexibleViewsContainerType) type
{
    self.viewType = type;
}

- (void) fillViewsContainerWithViews: (NSArray*) viewsArray
                            forWidth: (CGFloat)  width
{
    self.autoresizesSubviews = NO;
    
    self.viewsArray = viewsArray;
    
    __block CGFloat widthLeftToEdge = width;
    __block NSUInteger numberOfRows = 1;
    __block CGPoint currentPointToAddView = CGPointMake(0, 0);
    
    [self.viewsArray enumerateObjectsUsingBlock: ^(UIView* view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat viewWidth = view.size.width;
        
        if ( viewWidth < widthLeftToEdge )
        {
            [self addViewAsSubview: view
                 beginingFromPoint: currentPointToAddView];
            
            currentPointToAddView.x += view.frame.size.width + 10;
            widthLeftToEdge         -= view.frame.size.width + 10;
        }
        else
        {
            numberOfRows++;
            currentPointToAddView.y += 20;
            currentPointToAddView.x = 0;
            widthLeftToEdge         = width;
            
            [self addViewAsSubview: view
                 beginingFromPoint: currentPointToAddView];
            
            currentPointToAddView.x += view.frame.size.width + 10;
            widthLeftToEdge         -= currentPointToAddView.x;
        }
    }];
    
    CGFloat containerHeight = numberOfRows * 16 + 5 * (numberOfRows - 1);
    
    CGRect containerFrame = self.frame;
    
    containerFrame.size.height = containerHeight;
    
    self.frame = containerFrame;
}


#pragma mark - Internal -


- (void) addViewAsSubview: (UIView*) view
        beginingFromPoint: (CGPoint) point
{
    CGRect viewFrame = CGRectMake( point.x,
                                   point.y,
                                   view.frame.size.width,
                                   view.frame.size.height );
    
    view.frame = viewFrame;
    
    [self addSubview: view];
}

@end
