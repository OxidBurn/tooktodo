//
//  ContactInfoCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/6/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ContactInfoCell.h"

// Classes
#import "TeamProfileInfoViewModel.h"

@interface ContactInfoCell ()

// Properties


// Outlets
@property (weak, nonatomic) IBOutlet UILabel* contactInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton* contactActionBtn;


// Methods
- (IBAction) onContactActionBtn: (UIButton*) sender;

@end

@implementation ContactInfoCell


#pragma mark - Actions -

- (IBAction) onContactActionBtn: (UIButton*) sender
{
    if ( self.didPressOnPhone )
        self.didPressOnPhone(sender.tag);
}

#pragma mark - Public -


- (void) fillCellWithContactInfo: (NSString*)      contactValue
                    withBtnImage: (UIImage*)       btnImage
                    forIndexPath: (NSIndexPath*)   indexPath
{
    self.contactInfoLabel.text = contactValue;
    
    [self.contactActionBtn setImage: btnImage
                           forState: UIControlStateNormal];
    
    self.contactActionBtn.tag = indexPath.row;
}

@end
