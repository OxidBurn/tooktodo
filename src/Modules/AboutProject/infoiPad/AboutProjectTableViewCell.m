//
//  AboutProjectTableViewCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 10/28/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AboutProjectTableViewCell.h"

@interface AboutProjectTableViewCell()

// properties
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UIView*  selectedStateView;

// methods

@end

@implementation AboutProjectTableViewCell

#pragma mark - Public -

- (void) fillCellWithTitle: (NSString*) title
{
    self.titleLabel.text = title;
}

- (void) selectCell
{
    self.backgroundColor = [UIColor colorWithRed: 235.0/256
                                           green: 248.0/256
                                            blue: 247.0/256
                                           alpha: 1];
    self.selectedStateView.hidden = NO;
}

- (void) deselectCell
{
    self.backgroundColor = [UIColor clearColor];
    
    self.selectedStateView.hidden = YES;
}

@end
