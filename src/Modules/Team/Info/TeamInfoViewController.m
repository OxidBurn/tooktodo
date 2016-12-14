//
//  TeamInfoViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/24/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamInfoViewController.h"

// Frameworks
#import <MessageUI/MessageUI.h>

// Classes
#import "ProjectsControllersDelegate.h"
#import "MainTabBarController.h"
#import "TeamInfoViewModel.h"
#import "FilledTeamInfo.h"
#import "TeamProfilesInfoViewController.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"

@interface TeamInfoViewController () <TeamInfoViewModelDelegate, MFMailComposeViewControllerDelegate, UISplitViewControllerDelegate>

// Properties

// Outlets
@property (weak, nonatomic) IBOutlet UIBarButtonItem* menuBarButtonItem;
@property (weak, nonatomic) IBOutlet UITableView* teamInfoTableView;
@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;

@property (strong, nonatomic) TeamInfoViewModel* viewModel;
@property (nonatomic, strong) InviteInfo*        inviteInfo;

// Methods

- (void) setupTableView;

- (void) bindingUI;

- (void) handleViewModelActions;

- (IBAction) onAddMemberBarButtonItem: (UIBarButtonItem*) sender;

@end

@implementation TeamInfoViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Binding controller UI
    [self bindingUI];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    // Update team info when appeared screen
    // made for immediate update team info after
    // switching between projects or adding new member to the team
    [self updateTeamInfo];
    
    // Hide search bar on show
    [self setupTableView];
    
    [self.teamInfoTableView reloadData];
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
    if ([segue.identifier isEqualToString: @"ShowTeamMemberInfoID"])
    {
        FilledTeamInfo* teamMember = [self.viewModel getSelectedTeamMember];
        
        self.profilesVC = (TeamProfilesInfoViewController*)[(UINavigationController*)segue.destinationViewController topViewController];
        
        [self.profilesVC fillSelectedTeamMember: teamMember];
        
        [self.profilesVC reloadUserInformationViewData];
    }
}

#pragma mark - Properties -

- (TeamInfoViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [[TeamInfoViewModel alloc] init];
        
        _viewModel.delegate = self;
    }
    
    return _viewModel;
}


#pragma mark - Public mehtods -

- (void) fillInviteInfo: (InviteInfo*) userInf
{
    self.inviteInfo = userInf;
}


#pragma mark - Internal methods -

- (void) updateTeamInfo
{
    __weak typeof(self) blockSelf = self;
    
    [self.viewModel updateInfoWithCompletion: ^(BOOL isSuccess) {
        
        if ( isSuccess )
        {
            [blockSelf.teamInfoTableView reloadData];
        }
        
    }];
    
    // Setup navigation title view
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"КОМАНДА"
                                               withSubTitle: [self.viewModel getProjectName]];
}

- (void) setupTableView
{
    [self.teamInfoTableView setContentOffset: CGPointMake(0, self.searchBar.height)];
}



- (void) bindingUI
{
    self.teamInfoTableView.dataSource = self.viewModel;
    self.teamInfoTableView.delegate   = self.viewModel;
    self.searchBar.delegate           = self.viewModel;
    
    [self handleViewModelActions];
    
    // handling splitVC delegate
    self.splitViewController.delegate = self;
    
    // hiding Menu btn for iPad
    if ( IS_PHONE == NO )
        self.navigationItem.leftBarButtonItem = nil;
        
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.didShowMemberInfo = ^() {
        
        [blockSelf performSegueWithIdentifier: @"ShowTeamMemberInfoID"
                                       sender: blockSelf];
        
        
    };
}

- (void) handleViewModelActions
{
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.reloadTableView = ^(){
        
        [blockSelf.teamInfoTableView reloadData];
        
    };
    
    self.viewModel.endFiltering = ^(){
        
        [blockSelf.searchBar resignFirstResponder];
        [blockSelf.view endEditing: YES];
        
    };
    
}

#pragma mark - Actions -

- (void) needToUpdateContent
{
    [self updateTeamInfo];
}

- (IBAction) onShowMenu: (UIBarButtonItem*) sender
{
    [self.slidingViewController anchorTopViewToRightAnimated: YES];
}

- (IBAction) onAddMemberBarButtonItem: (UIBarButtonItem*) sender
{
    NSString* segueId = @"";
    
    if ( IS_PHONE )
    {
       segueId = @"ShowAddMemberInviteiPhone";
    }
    else
    {
        segueId = @"ShowAddMemberInviteiPad";
    }
    
    [self performSegueWithIdentifier: segueId
                              sender: self];
}

#pragma mark - ViewModel delegate methods -

- (void) createActionSheetWithMainNumber: (NSString*) mainNumber
                       andAdditionNumber: (NSString*) additionNumber
{
    UIAlertController* actionSheet = [UIAlertController alertControllerWithTitle: nil
                                                                         message: nil
                                                                  preferredStyle: UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction: [UIAlertAction actionWithTitle: mainNumber
                                                     style: UIAlertActionStyleDefault
                                                   handler: ^(UIAlertAction * _Nonnull action) {
                                                       
                                                       // call
                                                       [[UIApplication sharedApplication] openURL: [NSURL URLWithString: [NSString stringWithFormat: @"tel://%@", mainNumber]]];
                                                       
                                                   }]];
    
    [actionSheet addAction: [UIAlertAction actionWithTitle: additionNumber
                                                     style: UIAlertActionStyleDefault
                                                   handler: ^(UIAlertAction * _Nonnull action) {
                                                       
                                                       [[UIApplication sharedApplication] openURL: [NSURL URLWithString: [NSString stringWithFormat: @"tel://%@", additionNumber]]];
                                                   }]];
    
    [actionSheet addAction: [UIAlertAction actionWithTitle: @"Cancel"
                                                     style: UIAlertActionStyleCancel
                                                   handler: nil]];
    
    [self presentViewController: actionSheet
                       animated: YES
                     completion: nil];
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

#pragma mark - UISplitViewControllerDelegate methods -

- (BOOL)    splitViewController: (UISplitViewController*) splitViewController
collapseSecondaryViewController: (UIViewController*)      secondaryViewController
      ontoPrimaryViewController: (UIViewController*)      primaryViewController
{
    return YES;
}

- (BOOL) splitViewController: (UISplitViewController*) splitViewController
    showDetailViewController: (UIViewController*)      vc
                      sender: (id)                     sender
{
    return NO;
}

- (BOOL) splitViewController: (UISplitViewController*) splitViewController
          showViewController: (UIViewController*)      vc
                      sender: (nullable id)            sender
{
    return NO;
}

@end
