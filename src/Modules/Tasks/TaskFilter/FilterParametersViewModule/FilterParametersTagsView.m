//
//  FilterParametersTagsView.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/28/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterParametersTagsView.h"

// Classes
#import "FilterTagParameterInfo.h"
#import "FilterTagView.h"

const CGFloat kTagViewXPadding = 5.0f;
const CGFloat kTagViewYPadding = 15.0f;
const CGFloat kTagViewHeight   = 20.0f;

@interface FilterParametersTagsView() <FilterParameterViewDelegate>

// properties

@property (nonatomic, strong) NSArray* content;

@property (strong, nonatomic) NSArray* tagsViewsList;

// methods

- (void) reloadTags;

@end

@implementation FilterParametersTagsView


#pragma mark - Public methods -

- (void) reloadContent
{
    self.content = [self.dataSource getFilterParameterContent];
    
    [self reloadTags];
}


#pragma mark - Internal methods -

- (void) reloadTags
{
    [self.tagsViewsList enumerateObjectsUsingBlock: ^(FilterTagView*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [obj removeFromSuperview];
        
    }];
    
    [self addNewTags];
}

- (void) addNewTags
{
    __block NSMutableArray* tmpTagsViewsList = [NSMutableArray array];
    
    [self.content enumerateObjectsUsingBlock: ^(FilterTagParameterInfo*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        FilterTagView* tagView = [[MainBundle loadNibNamed: @"FilterParameterView"
                                                     owner: nil
                                                   options: nil] lastObject];
        
        [tagView setParameterInfo: obj
                     withDelegate: self];
        
        [tmpTagsViewsList addObject: tagView];
        
        [self addSubview: tagView];
        
        
    }];
    
    self.tagsViewsList = tmpTagsViewsList.copy;
    
    tmpTagsViewsList = nil;
    
    [self calculateFrames];
}

- (void) calculateFrames
{
    __block CGFloat xPosition = 15.0f;
    __block CGFloat yPosition = 15.0f;
    
    [self.tagsViewsList enumerateObjectsUsingBlock: ^(FilterTagView*  _Nonnull tagView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        tagView.xOrigin = xPosition;
        tagView.yOrigin = yPosition;
        
        if ( tagView.maxX > self.width )
        {
            xPosition  = 15.0f;
            yPosition += tagView.height + kTagViewYPadding;
            
            tagView.xOrigin = xPosition;
            tagView.yOrigin = yPosition;
        }
        
        xPosition += tagView.width + kTagViewXPadding;
        
        [tagView updateTagValue: idx];
        
    }];
    
    CGFloat heightValue = 0;
    
    if ( self.tagsViewsList.count > 0 )
        heightValue = yPosition + kTagViewHeight + kTagViewYPadding;
    
    self.contentSize = CGSizeMake(self.width, heightValue);
    
    if ( self.updateHeight )
        self.updateHeight(heightValue);
}

- (void) deleteTagItemAtIndex: (NSUInteger) index
{
    FilterTagView* tagItem = self.tagsViewsList[index];
    
    [tagItem removeFromSuperview];
    
    NSMutableArray* tmpTagsViewsList = self.tagsViewsList.mutableCopy;
    
    [tmpTagsViewsList removeObjectAtIndex: index];
    
    self.tagsViewsList = tmpTagsViewsList.copy;
    
    [self calculateFrames];
    
    tmpTagsViewsList = nil;
}


#pragma mark - Filter tag view delegate methods -

- (void) didDeleteFilterParameterWithTag: (NSUInteger) tag
{
    [self deleteTagItemAtIndex: tag];
    
    if ( [self.filterDelegate respondsToSelector: @selector(didDeleteFilterParameterWithTag:)] )
        [self.filterDelegate didDeleteFilterParameterWithTag: tag];
}

@end
