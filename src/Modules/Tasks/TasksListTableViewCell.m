//
//  TasksListTableViewCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TasksListTableViewCell.h"
#import "StatusMarkerComponent.h"
#import "TaskMarkerComponent.h"

@interface TasksListTableViewCell()

// properties
@property (weak, nonatomic) IBOutlet UILabel* executionDateLabel;
@property (weak, nonatomic) IBOutlet UILabel* roomNumbersLabel;
@property (weak, nonatomic) IBOutlet StatusMarkerComponent* typeTaskMarkerView;
@property (weak, nonatomic) IBOutlet UILabel* systemLabel;
@property (weak, nonatomic) IBOutlet UILabel* titleTaskLabel;
@property (weak, nonatomic) IBOutlet UIImageView* avatarImage;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent* amountTaskMarkerComponent;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent* attachmantsMarkerComponent;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent* commentsMarkerComponent;

// methods


@end

@implementation TasksListTableViewCell

- (void) awakeFromNib
{
    [super awakeFromNib];
}

- (void) setSelected: (BOOL) selected
            animated: (BOOL) animated
{
    [super setSelected: selected
              animated: animated];
}

@end
