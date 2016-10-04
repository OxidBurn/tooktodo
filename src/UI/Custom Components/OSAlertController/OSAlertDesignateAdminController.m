//
//  OSAlertDesignateAdminController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertDesignateAdminController.h"

// Categories
#import <SDWebImage/UIImageView+WebCache.h>

@interface OSAlertDesignateAdminController ()

//properties

// IBOutlets
@property (weak, nonatomic) IBOutlet UILabel* nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView* avatarImgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


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

- (void) setImage: (NSString*) imagePath
         withName: (NSString*) name
      withMessage: (NSString*) message

{
    self.avatarImgView.layer.cornerRadius = 13.0f;
    self.avatarImgView.clipsToBounds      = YES;
    self.nameLabel.text                   = name;
    self.titleLabel.text                  = message;
    
    [self.avatarImgView sd_setImageWithURL: [NSURL URLWithString: imagePath]];
}


#pragma mark - Actions -

- (IBAction) onCancel: (UIButton*) sender
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];

}

- (IBAction) onReady: (UIButton*) sender
{
    [self dismissViewControllerAnimated: YES
                             completion: ^{
                                 
         [self.delegate didDoneAlertAction];
    }];

}


@end
