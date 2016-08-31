//
//  UserInfoViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserInfoViewModel.h"
#import "UserInfoModel.h"

@interface UserInfoViewModel()

// properties

@property (strong, nonatomic) UserInfoModel* model;

@property (nonatomic, strong) NSArray* userContactInfo;

// methods


@end

@implementation UserInfoViewModel


#pragma mark - Properties -

- (UserInfoModel*) model
{
    if ( _model == nil )
    {
        _model = [UserInfoModel new];
    }
    
    return _model;
}


#pragma mark - Public -

- (UIImage*) userAvatar
{
    return [self.model getUserAvatarImage];
}

- (NSURL*) getUserAvatarURL
{
    return [self.model getUserAvatarURL];
}

- (NSString*) fullUserName
{
    return [self.model getFullUserName];
}

- (CGFloat) contactTableHeight
{
    return self.userContactInfo.count * 42;
}

- (RACCommand*) logoutCommand
{
    if ( _logoutCommand == nil )
    {
        _logoutCommand = [[RACCommand alloc] initWithSignalBlock: ^RACSignal *(id input) {
            
            return [self.model logoutUser];
            
        }];
    }
    
    return _logoutCommand;
}

- (void) saveNewImage: (UIImage*) image
{
    [self.model saveNewAvatar: image];
}

#pragma mark - Internal methods -

- (NSArray*) userContactInfo
{    
    return [self.model getUserContactInfo];;
}

#pragma mark - Table view data source -

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return self.userContactInfo.count;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"UserPhoneNumCellID"];
    
    cell.textLabel.text = self.userContactInfo[indexPath.row];
    
    return cell;
}

@end
