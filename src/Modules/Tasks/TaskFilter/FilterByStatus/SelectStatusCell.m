//
//  SelectStatusCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 25.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectStatusCell.h"

// Classes
#import "TaskStatusDefaultValues.h"

@interface SelectStatusCell()

// outlets
@property (weak, nonatomic) IBOutlet UILabel*     statusDescrLabel;

@property (weak, nonatomic) IBOutlet UIImageView* markImageView;

// properties


// methods


@end

@implementation SelectStatusCell


#pragma mark - Public -

- (void) fillCellForIndexPath: (NSIndexPath*) indexPath
            withSelectedState: (BOOL)         isSelected
{
    NSUInteger idx = indexPath.row;
    
    self.statusDescrLabel.text = [[TaskStatusDefaultValues sharedInstance] returnTitleForTaskStatus: idx];
        
    self.markImageView.hidden = !isSelected;
}

- (void) changeCheckmarkState: (BOOL) state
{
    self.markImageView.hidden = state ? NO : YES;
}

- (BOOL) currentCheckMarkState
{
    return self.markImageView.hidden;
}

@end
