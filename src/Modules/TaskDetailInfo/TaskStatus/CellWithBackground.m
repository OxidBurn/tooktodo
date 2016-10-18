//
//  CellWithBackground.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CellWithBackground.h"

// Classes
#import "TaskStatusDefaultValues.h"

@interface CellWithBackground()

// properties
@property (weak, nonatomic) IBOutlet UILabel*     statusNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView* statusImageView;

@property (nonatomic, assign) BOOL canCancel;

@end

@implementation CellWithBackground

#pragma mark - Public -

- (void) fillCellForTaskStatus: (TaskStatusType) statusType
{
    self.statusNameLabel.textColor       = [[TaskStatusDefaultValues sharedInstance]
                                            returnFontColorForTaskStatus: statusType];
    
    self.backgroundColor                 = [[TaskStatusDefaultValues sharedInstance]
                                            returnColorForTaskStatus: statusType];

    
    self.statusNameLabel.text            = [[TaskStatusDefaultValues sharedInstance]
                                            returnTitleForTaskStatus: statusType];
    
    self.statusImageView.image           = [[TaskStatusDefaultValues sharedInstance]
                                            returnIconImageForTaskStatus: statusType];
}


@end
