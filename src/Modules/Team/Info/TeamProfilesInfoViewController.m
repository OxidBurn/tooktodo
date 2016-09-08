//
//  TeamProfilesInfoViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/31/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamProfilesInfoViewController.h"

// Frameworks
#import "ReactiveCocoa.h"
#import <MessageUI/MessageUI.h>

// Categories
#import "BaseMainViewController+NavigationTitle.h"

//Classes
#import "AvatarImageView.h"
#import "TeamProfileInfoViewModel.h"
#import "TeamMember.h"
#import "Utils.h"
#import "RolesViewController.h"
#import "OSAlertController.h"

@interface TeamProfilesInfoViewController () <TeamProfileViewModelDelegate, MFMailComposeViewControllerDelegate>

// Properties
@property (nonatomic, strong) TeamProfileInfoViewModel* viewModel;

// Outlets
@property (weak, nonatomic) IBOutlet UITableView* profileInfoTableView;

@property (weak, nonatomic) IBOutlet AvatarImageView* profileAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* profileFullNameLabel;

// Methods
- (IBAction) onDismiss: (UIBarButtonItem*) sender;


@end

@implementation TeamProfilesInfoViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Setup navigation title view
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"КОМАНДА"
                                               withSubTitle: [self.viewModel getProjectName]];
    
    self.profileInfoTableView.dataSource = self.viewModel;
    self.profileInfoTableView.delegate   = self.viewModel;
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    [self updateUserInfo];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Segue -

- (void) prepareForSegue: (UIStoryboardSegue*) segue
                  sender: (id)                 sender
{
    [super prepareForSegue: segue
                    sender: sender];
    
    
    if ([segue.identifier isEqualToString: @"ShowRolesControllerID"])
    {
        RolesViewController* controller = segue.destinationViewController;
        
        [controller setRolesViewControllerDelegate: self.viewModel];
    }
    
}

#pragma mark - Properties -

- (TeamProfileInfoViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [[TeamProfileInfoViewModel alloc] init];
        
        _viewModel.delegate = self;
    }
    
    return _viewModel;
}

#pragma mark - Acitons -

- (IBAction) onDismiss: (UIBarButtonItem*) sender
{
    // Need to call method in viewModel and model
    // for changing selected state in team member value
    
    [self.navigationController popViewControllerAnimated: YES];
}


#pragma mark - Internal methods -

- (void) updateUserInfo
{
    @weakify(self)
    
    [[self.viewModel updateInfo] subscribeNext: ^(TeamMember* teamMember) {
        
        @strongify(self)
        
        self.profileFullNameLabel.text      = [NSString stringWithFormat:@" %@ %@", teamMember.firstName, teamMember.lastName];
        
        self.profileAvatarImageView.image = [UIImage imageWithContentsOfFile: [[Utils getAvatarsDirectoryPath]
                                                                               stringByAppendingString: teamMember.avatarPath]];
        
        [self.profileInfoTableView reloadData];
        
    }];
}


#pragma mark - TeamProfileViewModelDelegate Methods -

- (void) showControllerWithIdentifier: (NSString*) segueID
{
    [self performSegueWithIdentifier: segueID
                              sender: self];
}

- (void) showDesignationAlert: (NSString*) userName
                   withAvatar: (UIImage*)  avatar
{
//    UIAlertController* alertController = [UIAlertController alertControllerWithTitle: @"Назначить администратором"
//                                                                             message: [NSString stringWithFormat:@"Изменить данные для пользователя %@", userName]
//                                                                      preferredStyle: UIAlertControllerStyleAlert];
//    
//    [alertController addAction: [UIAlertAction actionWithTitle: @"Назначить"
//                                                         style: UIAlertActionStyleDefault
//                                                       handler: ^(UIAlertAction * _Nonnull action) {
//                                                           NSLog(@"Пользователь %@ назначен администратором", userName);
//                                                       }]];
//    
//    [alertController addAction: [UIAlertAction actionWithTitle: @"Отменить"
//                                                         style: UIAlertActionStyleCancel
//                                                       handler: ^(UIAlertAction * _Nonnull action) {
//                                                           
//                                                       }]];
    
    
//    
//    [self presentViewController: alertController
//                       animated: YES
//                     completion: nil ];
    
    
    [OSAlertController showAlertWithImage: avatar
                                 withName: userName
                             onController: self];
}

- (void) showEmailComposerForMail: (NSString*) email
{
    NSString* emailTitle  = @"TookToDo";
    
    if ( [MFMailComposeViewController canSendMail] )
    {
        MFMailComposeViewController* mc = [[MFMailComposeViewController alloc] init];
        
        mc.mailComposeDelegate = self;
        
        [mc setSubject: emailTitle];
        
        [self presentViewController: mc
                           animated: YES
                         completion: NULL];
    }
}


#pragma mark - Mail composer delegate methods -

- (void) mailComposeController: (MFMailComposeViewController*) controller
           didFinishWithResult: (MFMailComposeResult)          result
                         error: (nullable NSError *)           error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
            
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
            
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
            
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated: YES
                             completion: NULL];
}

@end
