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

// methods

- (IBAction) onDeleteTag: (UIButton*) sender;

@end

@implementation FilterTagView


#pragma mark - Public methods -

- (void) setParameterInfo: (FilterTagParameterInfo*) info
{
    self.filterTagTitleLabel.text = info.title;
    self.deleteBtn.tag            = info.parameterTag;
}


#pragma mark - Actions -

- (IBAction) onDeleteTag: (UIButton*) sender
{
    if ( self.didDeleteParameter )
        self.didDeleteParameter(self.tag);
}

@end
