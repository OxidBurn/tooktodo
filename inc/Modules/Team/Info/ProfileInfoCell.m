//
//  ProfileInfoCell.m
//  TookTODO
//
//  Created by Lera on 05.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProfileInfoCell.h"

#import "TeamProfileInfoViewModel.h"

@interface ProfileInfoCell()

@property (strong, nonatomic) TeamProfileInfoViewModel* viewModel;

- (IBAction) onContact: (UIButton*) sender;

@end

@implementation ProfileInfoCell

- (TeamProfileInfoViewModel *)viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [TeamProfileInfoViewModel new];
    }
    
    return _viewModel;
}

- (void) fillCellWithInfo: (NSString*)      contactValue
             withBtnImage: (UIImage*)       btnImage
             forIndexPath: (NSIndexPath*)   indexPath
{
    self.contactsLabel.text = contactValue;
    [self.contactsBtn setImage: btnImage
                      forState: UIControlStateNormal];
    
    self.contactsBtn.tag = indexPath.row;
}

- (IBAction) onContact:(UIButton *)sender
{
    [self.viewModel performActionForIndex: sender.tag];
}
@end
