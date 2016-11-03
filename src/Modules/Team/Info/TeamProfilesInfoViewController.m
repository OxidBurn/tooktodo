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
#import <SDWebImage/UIImageView+WebCache.h>

// Categories
#import "BaseMainViewController+NavigationTitle.h"

//Classes
#import "AvatarImageView.h"
#import "TeamProfileInfoViewModel.h"
#import "FilledTeamInfo.h"
#import "Utils.h"
#import "RolesViewController.h"
#import "OSAlertController.h"
#import "UIViewController+Helper.h"
#import "TeamInfoViewController.h"

@interface TeamProfilesInfoViewController () <TeamProfileViewModelDelegate, MFMailComposeViewControllerDelegate, UISplitViewControllerDelegate>

// Properties
@property (nonatomic, strong) TeamProfileInfoViewModel* viewModel;

// Outlets
@property (weak, nonatomic) IBOutlet UITableView* profileInfoTableView;

@property (weak, nonatomic) IBOutlet AvatarImageView* profileAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* profileFullNameLabel;


// Methods


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
    
    self.splitViewController.delegate = self;
    
    if ( IS_PHONE )
    {
        [self setupBackButtonUI];
    }
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.dismissViewController = ^(){
        
        [blockSelf dismissViewControllerAnimated: YES
                                      completion: nil];
    };
    
    self.viewModel.popToVC = ^(){
      
        [blockSelf.navigationController popViewControllerAnimated: YES];
    };

}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    [self updateUserInfo];
    
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
    
    if ([segue.identifier isEqualToString: @"ShowRolesControllerIDiPhone"] || [segue.identifier isEqualToString: @"ShowRoleControllerIDiPad"])
    {
        RolesViewController* controller = (RolesViewController*)[(UINavigationController*)segue.destinationViewController topViewController];
        
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

- (void) setupBackButtonUI
{
    UIBarButtonItem* backBtn = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: @"ArrowBack"]
                                                                style: UIBarButtonItemStylePlain
                                                               target: self.navigationController.navigationController
                                                               action: @selector(popViewControllerAnimated:)];
    
    self.navigationItem.leftBarButtonItem                                  = backBtn;
    self.navigationController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

#pragma mark - Public -

- (void) fillSelectedTeamMember: (FilledTeamInfo*) teamMember
{
    [self.viewModel fillSelectedTeamMember: teamMember];
}

- (void) refreshTableView
{
    [self.profileInfoTableView reloadData];
}

- (void) reloadUserInformationViewData
{
    [self updateUserInfo];
}

#pragma mark - Acitons -

- (void) leftBarButtonActionForiPad
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

- (void) onDismiss
{
    [self.navigationController popViewControllerAnimated: YES];
}

#pragma mark - Internal methods -

- (void) updateUserInfo
{
    @weakify(self)
    
    [[self.viewModel updateInfo] subscribeNext: ^(FilledTeamInfo* teamMember) {
        
        @strongify(self)
        
        self.profileFullNameLabel.text = [NSString stringWithFormat: @" %@ %@", teamMember.firstName, teamMember.lastName];
        
        
        [self.profileAvatarImageView sd_setImageWithURL: [NSURL URLWithString: teamMember.avatarSrc]];
        
        [self.profileInfoTableView reloadData];
        
    }];
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.reloadTableView = ^(){
        
        [blockSelf.profileInfoTableView reloadData];
        
    };
}


#pragma mark - TeamProfileViewModelDelegate Methods -

- (void) showControllerWithIdentifier: (NSString*) segueID
{
    [self performSegueWithIdentifier: segueID
                              sender: self];
}

- (void) showDesignationAlert: (NSString*) userName
                   withAvatar: (NSString*)  avatar
                  withMessage: (NSString*) message
{
    
    [OSAlertController showAlertWithImage: avatar
                                 withName: userName
                              withMessage: message
                             onController: self.splitViewController
                             withDelegate: self.viewModel];
    
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


#pragma mark - Split view controller delegate methods -

- (BOOL) splitViewController: (UISplitViewController*) splitViewController
    showDetailViewController: (UIViewController*)      vc
                      sender: (id)                     sender
{
    if ( [sender isKindOfClass: [TeamInfoViewController class]] &&
         [((TeamInfoViewController*)sender).profilesVC isKindOfClass: [TeamProfilesInfoViewController class]])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController showViewController:(UIViewController *)vc sender:(id)sender
{
    return NO;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController
collapseSecondaryViewController:(UIViewController *)secondaryViewController
  ontoPrimaryViewController:(UIViewController *)primaryViewController {
    
    if ([secondaryViewController isKindOfClass: [UINavigationController class]]
        && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass: [TeamProfilesInfoViewController class]])
    {    
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
        
    } else {
        
        return NO;
        
    }
}

@end
