//
//  SortPopoverCell.m
//  TookTODO
//
//  Created by Глеб on 24.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SortPopoverCell.h"

@interface SortPopoverCell()

// properties
@property (weak, nonatomic) IBOutlet UILabel* optionRowLabel;

// methods


@end

@implementation SortPopoverCell


#pragma mark - Public -

- (void) fillCellWithOptionString: (NSString*) option
{
    self.optionRowLabel.layer.borderWidth = 1;
    self.optionRowLabel.layer.cornerRadius = 6;
    
    self.optionRowLabel.layer.borderColor = [UIColor colorWithRed:0.910 green:0.914 blue:1.000 alpha:1.000].CGColor;

    self.optionRowLabel.text = option;
}

- (void) setSelected: (BOOL) selected
            animated: (BOOL) animated
{
    [super setSelected: selected
              animated: animated];
    
    if ( selected )
    {
        self.optionRowLabel.layer.borderColor = [UIColor colorWithRed:0.224 green:0.741 blue:0.718 alpha:1.000].CGColor;
    }
    else
        if ( !selected )
    {
        self.optionRowLabel.layer.borderColor = [UIColor colorWithRed:0.910 green:0.914 blue:1.000 alpha:1.000].CGColor;
    }
}

@end
