//
//  OSAlertDesignateAdminController.m
//  TookTODO
//
//  Created by Lera on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertDesignateAdminController.h"

@interface OSAlertDesignateAdminController ()

// IBOutlets
@property (weak, nonatomic) IBOutlet UILabel* nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView* avatarImgView;

@property (weak, nonatomic) IBOutlet UIButton* cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton* readyBtn;


//IBActions

- (IBAction) onCancel: (UIButton*) sender;

- (IBAction) onReady: (UIButton*) sender;

@end

@implementation OSAlertDesignateAdminController

#pragma mark - Life Cycle -

- (void) loadView
{
    [super loadView];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Public -

- (void) setImage: (UIImage*)  image
         withName: (NSString*) name

{
    self.avatarImgView.layer.cornerRadius = CGRectGetWidth(self.avatarImgView.frame) / 2;
    
    self.avatarImgView.image = image;
    self.nameLabel.text      = name;
}


#pragma mark - Actions -

- (IBAction) onCancel: (UIButton*) sender
{
    [self.delegate performAction];
}

- (IBAction) onReady: (UIButton*) sender
{
    [self.delegate performAction];
}


@end
