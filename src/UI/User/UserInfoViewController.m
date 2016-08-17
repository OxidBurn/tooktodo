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

@interface UserInfoViewController () <RSKImageCropViewControllerDelegate, RSKImageCropViewControllerDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

// Properties


@property (weak, nonatomic) IBOutlet UIImageView* avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel    * fullNameLabel;

@property (strong, nonatomic) UserInfoViewModel* viewModel;

// methods
- (IBAction) onAddNewPhotoBtn: (UIButton*) sender;

- (void) pickPictureFromLibOrCamera;

- (void) editImageForAvatar: (UIImage*) chosenImage;

- (void) createImageControllerForSourceType: (UIImagePickerControllerSourceType) sourceType;

- (void) showAccessAlertWithTitle: (NSString*) title
                      withMessage: (NSString*) message;



@end

@implementation UserInfoViewController

#pragma mark - Life cycle -

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    
    
    [self updateInfo];
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


#pragma mark - Actions -

//photo editing methods
- (IBAction) onAddNewPhotoBtn: (UIButton*) sender
{
    [self pickPictureFromLibOrCamera];
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
    [self.navigationController popViewControllerAnimated:YES];
}

// The original image has been cropped.
- (void) imageCropViewController: (RSKImageCropViewController*) controller
                    didCropImage: (UIImage*)                    croppedImage
                   usingCropRect: (CGRect)                      cropRect
{
    self.avatarImageView.image = croppedImage;
    
    [self.navigationController popViewControllerAnimated:YES];
}

// The original image has been cropped. Additionally provides a rotation angle used to produce image.
- (void) imageCropViewController: (RSKImageCropViewController*) controller
                    didCropImage: (UIImage*)                    croppedImage
                   usingCropRect: (CGRect)                      cropRect
                   rotationAngle: (CGFloat)                     rotationAngle
{
    self.avatarImageView.image = croppedImage;
    
    [self.navigationController popViewControllerAnimated:YES];
}

// The original image will be cropped.
- (void) imageCropViewController: (RSKImageCropViewController*) controller
                   willCropImage: (UIImage*)                    originalImage
{
    // Use when `applyMaskToCroppedImage` set to YES.
    //    [SVProgressHUD show];
}


#pragma mark - UIImagePickerControllerDelegate methods -
//photo editing

- (void) imagePickerController: (UIImagePickerController *)      picker
 didFinishPickingMediaWithInfo: (NSDictionary <NSString *,id> *) info
{
    UIImage* chosenImage = info[UIImagePickerControllerEditedImage];
    
    [self editImageForAvatar: chosenImage];
    
    [picker dismissViewControllerAnimated: YES
                               completion: nil];
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController*) picker
{
    [picker dismissViewControllerAnimated: YES
                               completion: nil];
}

#pragma mark - Internal methods -

- (void) updateInfo
{
    self.avatarImageView.image = [self.viewModel userAvatar];
    self.fullNameLabel.text    = [self.viewModel fullUserName];
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
    
    [self presentViewController: alert
                       animated: YES
                     completion: ^{
                         
                         
                     }];
    
}

- (void) editImageForAvatar: (UIImage*) chosenImage
{
    RSKImageCropViewController* imageCropVC = [[RSKImageCropViewController alloc] initWithImage: chosenImage];
    
    imageCropVC.delegate = self;
    
    [self.navigationController pushViewController: imageCropVC
                                         animated: YES];
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
        
        [self presentViewController: picker
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
