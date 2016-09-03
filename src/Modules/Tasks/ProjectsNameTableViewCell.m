//
//  NameProjectTableViewCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectsNameTableViewCell.h"

@interface ProjectsNameTableViewCell()

// properties
@property (weak, nonatomic) IBOutlet UILabel* titleProjectsName;
@property (weak, nonatomic) IBOutlet UILabel* subtitleProjectStreet;
@property (weak, nonatomic) IBOutlet UILabel* amountTasksLabel;
@property (weak, nonatomic) IBOutlet UILabel* unreadTasksLabel;
@property (weak, nonatomic) IBOutlet UIImageView* arrowImage;

// methods


@end

@implementation ProjectsNameTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void) setSelected: (BOOL)selected
            animated: (BOOL)animated
{
    [super setSelected: selected
              animated: animated];

}

@end
