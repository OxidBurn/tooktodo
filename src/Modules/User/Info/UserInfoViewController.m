//
//  UserInfoViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoViewModel.h"
#import <RSKImageCropper/RSKImageCropper.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "MainTabBarController.h"
#import "TermsViewController.h"
#import "ProjectsControllersDelegate.h"
#import "KeyChainManager.h"
#import "UIImageView+AFNetworking.h"

@interface UserInfoViewController () <RSKImageCropViewControllerDelegate, RSKImageCropViewControllerDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

// Properties


@property (weak, nonatomic) IBOutlet UIImageView            * avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel                * fullNameLabel;
@property (nonatomic, weak) IBOutlet UITableView            * phoneInfoTable;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint     * phoneTableHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     * phonesTableHeightConstraint;
@property (nonatomic, weak) IBOutlet UIButton               * showUserTerms;
@property (nonatomic, weak) IBOutlet UIButton               * userLogOut;
@property (weak, nonatomic) IBOutlet UIButton* onChangePhoto;

@property (nonatomic, weak) id<ProjectsControllersDelegate> delegate;

@property (strong, nonatomic) UserInfoViewModel* viewModel;

// methods
- (IBAction) onAddNewPhotoBtn: (UIButton*) sender;
- (IBAction) onShowServiceTerms: (UIButton*) sender;

- (void) pickPictureFromLibOrCamera;

- (void) editImageForAvatar: (UIImage*) chosenImage;

- (void) createImageControllerForSourceType: (UIImagePickerControllerSourceType) sourceType;

- (void) showAccessAlertWithTitle: (NSString*) title
                      withMessage: (NSString*) message;



@end

@implementation UserInfoViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self bindingUI];
    
    [self updateInfo];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    // Update all contact info on appearing screen
    // for case, when user update info in another screen
    [self updateContactInfo];
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties -

- (UserInfoViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [UserInfoViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Internal methods -

- (void) bindingUI
{
    self.userLogOut.rac_command = self.viewModel.logoutCommand;
    
    @weakify(self)
    
    [self.userLogOut.rac_command.executionSignals subscribeNext: ^(RACSignal* signal) {
        
        @strongify(self)
        
        [signal subscribeNext: ^(RACSignal* x) {
            
        } completed: ^{
            
            if ( IS_PHONE == NO )
            {
                [self dismissViewControllerAnimated: NO
                                         completion: nil];
            }
            
            // Need to implement better solution, re-write with using delegates
            [DefaultNotifyCenter postNotificationName: @"ShowLoginScreen"
                                               object: nil];
            
        }];
        
    }];
    
    [self.userLogOut.rac_command.errors subscribeNext: ^(NSError* error) {
        
        [Utils showErrorAlertWithMessage: @"Во время отправки запроса возникла ошибка\nПопробуйте еще раз"];
        
    }];
}


#pragma mark - Actions -

//photo editing methods
- (IBAction) onAddNewPhotoBtn: (UIButton*) sender
{
    [self pickPictureFromLibOrCamera];
}

- (IBAction) onShowServiceTerms: (UIButton*) sender
{
    NSString* segueId = @"";
    
    if ( IS_PHONE )
    {
        segueId = @"ShowServiceTermsiPhone";
        
    }
    else
    {
        segueId = @"ShowServiceTermsiPad";
        
    }
    
    [self performSegueWithIdentifier: segueId
                              sender: self];

}

#pragma mark - Internal methods -

- (void) updateInfo
{
    // Added checking if avatar image data is empty and not loaded yet
    // can happened when user make first autorization
    
    @weakify(self)
    
    [[self.viewModel updateInfo] subscribeNext: ^(id x) {
        
        @strongify(self)
        
        UIImage* userAvatar = [self.viewModel userAvatar];
        
        if ( userAvatar )
        {
            self.avatarImageView.image  = userAvatar;
        }
        else
        {
            [self.avatarImageView setImageWithURL: [self.viewModel getUserAvatarURL]];
        }
        
        self.fullNameLabel.text                   = [self.viewModel fullUserName];
        self.phoneInfoTable.dataSource            = self.viewModel;
        self.phoneTableHeightConstraint.constant  = [self.viewModel contactTableHeight];
        self.phonesTableHeightConstraint.constant = [self.viewModel contactTableHeight];
        
        [self.phoneInfoTable reloadData];
        
    }];
}

- (void) updateContactInfo
{
    __weak typeof(self) blockSelf = self;
    
    [self.viewModel updateCurrentUserInfoWithCompletion: ^(BOOL isSuccess) {
       
        blockSelf.fullNameLabel.text                   = [self.viewModel fullUserName];
        blockSelf.phoneInfoTable.dataSource            = self.viewModel;
        blockSelf.phoneTableHeightConstraint.constant  = [self.viewModel contactTableHeight];
        blockSelf.phonesTableHeightConstraint.constant = [self.viewModel contactTableHeight];
        
        [blockSelf.phoneInfoTable reloadData];
        
    }];
}


#pragma mark - RSKImageCropperDataSourse methods-


// Returns a custom rect for the mask.
- (CGRect) imageCropViewControllerCustomMaskRect: (RSKImageCropViewController*) controller
{
    CGSize maskSize;
    if ( [controller isPortraitInterfaceOrientation] )
    {
        maskSize = CGSizeMake(250, 250);
    }
    else
    {
        maskSize = CGSizeMake(220, 220);
    }
    
    CGFloat viewWidth  = CGRectGetWidth (controller.view.frame);
    CGFloat viewHeight = CGRectGetHeight(controller.view.frame);
    
    CGRect maskRect = CGRectMake ((viewWidth  - maskSize.width)  * 0.5f,
                                  (viewHeight - maskSize.height) * 0.5f,
                                  maskSize.width,
                                  maskSize.height);
    
    return maskRect;
}

// Returns a custom path for the mask.
- (UIBezierPath*) imageCropViewControllerCustomMaskPath: (RSKImageCropViewController*) controller
{
    CGRect rect = controller.maskRect;
    
    CGPoint point1 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPoint point2 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPoint point3 = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    
    UIBezierPath *triangle = [UIBezierPath bezierPath];
    
    [triangle moveToPoint:point1];
    [triangle addLineToPoint:point2];
    [triangle addLineToPoint:point3];
    [triangle closePath];
    
    return triangle;
}

// Returns a custom rect in which the image can be moved.
- (CGRect) imageCropViewControllerCustomMovementRect: (RSKImageCropViewController*) controller
{
    // If the image is not rotated, then the movement rect coincides with the mask rect.
    return controller.maskRect;
}

#pragma mark - RSKImageCropperDelegate methods -

// Crop image has been canceled.
- (void) imageCropViewControllerDidCancelCrop: (RSKImageCropViewController*) controller
{
    [controller dismissViewControllerAnimated: YES
                                   completion: nil];
}

// The original image has been cropped.
- (void) imageCropViewController: (RSKImageCropViewController*) controller
                    didCropImage: (UIImage*)                    croppedImage
                   usingCropRect: (CGRect)                      cropRect
{
    self.avatarImageView.image = croppedImage;
    
    [controller dismissViewControllerAnimated: YES
                                   completion: nil];
}

// The original image has been cropped. Additionally provides a rotation angle used to produce image.
- (void) imageCropViewController: (RSKImageCropViewController*) controller
                    didCropImage: (UIImage*)                    croppedImage
                   usingCropRect: (CGRect)                      cropRect
                   rotationAngle: (CGFloat)                     rotationAngle
{
    self.avatarImageView.image = croppedImage;
    
    __weak typeof(self) blockSelf = self;
    
    [self.viewModel saveNewImage: croppedImage
                  withCompletion: ^(UIImage *image) {
                      
                      blockSelf.avatarImageView.image = image;
                      
                  }];
    
    [controller dismissViewControllerAnimated: YES
                                   completion: nil];
}

// The original image will be cropped.
- (void) imageCropViewController: (RSKImageCropViewController*) controller
                   willCropImage: (UIImage*)                    originalImage
{
    
}


#pragma mark - UIImagePickerControllerDelegate methods -
//photo editing

- (void) imagePickerController: (UIImagePickerController *)      picker
 didFinishPickingMediaWithInfo: (NSDictionary <NSString *,id> *) info
{
    UIImage* chosenImage = info[UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated: NO
                               completion: ^{
                                   
                                   [self editImageForAvatar: chosenImage];
                                   
                               }];
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController*) picker
{
    [picker dismissViewControllerAnimated: YES
                               completion: nil];
}

//photo editing methods

- (void) pickPictureFromLibOrCamera
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle: nil
                                                                   message: nil
                                                            preferredStyle: UIAlertControllerStyleActionSheet];
    
    [alert addAction: [UIAlertAction actionWithTitle: @"Выбрать из библиотеки"
                                               style: UIAlertActionStyleDefault
                                             handler: ^(UIAlertAction * _Nonnull action) {
                                                 
                                                 [self createImageControllerForSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
                                             }]];
    
    [alert addAction: [UIAlertAction actionWithTitle: @"Сфотографировать"
                                               style: UIAlertActionStyleDefault
                                             handler: ^(UIAlertAction * _Nonnull action) {
                                                 
                                                 [self createImageControllerForSourceType: UIImagePickerControllerSourceTypeCamera];
                                                 
                                             }]];
    
    [alert addAction: [UIAlertAction actionWithTitle: @"Отмена"
                                               style: UIAlertActionStyleCancel
                                             handler: nil]];
    
    if ( IS_PHONE )
    {
        [self presentViewController: alert
                           animated: YES
                         completion: nil];
    }
    else
    {
        alert.modalPresentationStyle                   = UIModalPresentationPopover;
        alert.popoverPresentationController.sourceView = self.view;
        alert.popoverPresentationController.sourceRect = self.onChangePhoto.frame;
        
        [self presentViewController: alert
                           animated: YES
                         completion: nil];
    }
    
}

- (void) editImageForAvatar: (UIImage*) chosenImage
{
    RSKImageCropViewController* imageCropVC = [[RSKImageCropViewController alloc] initWithImage: chosenImage];
    
    imageCropVC.delegate = self;
    
    [self.parentViewController presentViewController: imageCropVC
                                            animated: YES
                                          completion: nil];
}

//photo editing helpers

- (void) createImageControllerForSourceType: (UIImagePickerControllerSourceType) sourceType
{
    if ( [UIImagePickerController isSourceTypeAvailable: sourceType])
    {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        
        picker.delegate      = self;
        picker.allowsEditing = YES;
        picker.sourceType    = sourceType;
        
        if ( IS_PHONE == NO && sourceType == UIImagePickerControllerSourceTypePhotoLibrary )
        {
            picker.modalPresentationStyle = UIModalPresentationPopover;
            
            UIPopoverPresentationController* imagePickerPresentation = picker.popoverPresentationController;
            
            imagePickerPresentation.permittedArrowDirections = UIPopoverArrowDirectionUp;
            imagePickerPresentation.sourceView = self.view;
            imagePickerPresentation.sourceRect = self.avatarImageView.frame;
        }
        
        [self.parentViewController presentViewController: picker
                                                animated: YES
                                              completion: nil];
    } else
    {
        [self showAccessAlertWithTitle: @"Камера не обнаружена"
                           withMessage: @"На устройстве нет камеры"];
    }
}

- (void) showAccessAlertWithTitle: (NSString*) title
                      withMessage: (NSString*) message
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle: title
                                                                   message: message
                                                            preferredStyle: UIAlertControllerStyleAlert];
    
    [alert addAction: [UIAlertAction actionWithTitle: @"Отмена"
                                               style: UIAlertActionStyleCancel
                                             handler: nil]];
    
    [self presentViewController: alert
                       animated: YES
                     completion: nil];
}


@end
