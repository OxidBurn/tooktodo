//
//  FilterTagView.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/28/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterTagView.h"

@interface FilterTagView()

// properties

@property (weak, nonatomic) IBOutlet UILabel *filterTagTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (weak, nonatomic) id<FilterParameterViewDelegate> delegate;

// methods

- (IBAction) onDeleteTag: (UIButton*) sender;

@end

@implementation FilterTagView


#pragma mark - Public methods -

- (void) setParameterInfo: (FilterTagParameterInfo*)         info
             withDelegate: (id<FilterParameterViewDelegate>) delegate
{
    self.filterTagTitleLabel.text                  = info.title;
    self.deleteBtn.tag                             = info.parameterTag;
    self.frame                                     = info.tagParamterFrame;
    self.delegate                                  = delegate;
}

- (void) updateTagValue: (NSUInteger) tag
{
    self.deleteBtn.tag = tag;
}


#pragma mark - Actions -

- (IBAction) onDeleteTag: (UIButton*) sender
{
    if ( [self.delegate respondsToSelector: @selector(didDeleteFilterParameterWithTag:)] )
        [self.delegate didDeleteFilterParameterWithTag: sender.tag];
}

@end
