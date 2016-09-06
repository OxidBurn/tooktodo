//
//  TeamProfileInfoViewModel.m
//  TookTODO
//
//  Created by Lera on 05.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamProfileInfoViewModel.h"

// Frameworks
#import "ReactiveCocoa.h"

//Classes
#import "ProfileInfoCell.h"
#import "TeamMember.h"
#import "DataManager+Team.h"
#import "Utils.h"
#import "TeamProfileInfoModel.h"

typedef NS_ENUM(NSUInteger, CellType)
{
    RoleType,
    PermissionType,
};

static NSString* SegueID = @"ShowRolesForUser";

@interface TeamProfileInfoViewModel() <TeamMemberCellDelegate>

@property (nonatomic, strong) TeamProfileInfoModel* model;

@property (nonatomic, strong) TeamMember* memberInfo;

@end

@implementation TeamProfileInfoViewModel


#pragma mark - Properties -

- (TeamProfileInfoModel *)model
{
    if ( _model == nil )
    {
        _model = [TeamProfileInfoModel new];
    }
    
    return _model;
}


#pragma mark - Public -

- (RACSignal*) updateInfo
{
    return [self.model updateUserInfo];
}

- (void)performActionForIndex:(NSUInteger)index
{
    [self.model performActionForIndex: index];
}


#pragma mark - TableView datasource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    
    if (indexPath.section == 0)
    {
       ProfileInfoCell* cell = (ProfileInfoCell*)[tableView dequeueReusableCellWithIdentifier: @"ProfileCellID"];
        
        [cell fillCellWithInfo: [self.model getContactValueForIndexPath: indexPath]
                  withBtnImage: [self.model getBtnImageForIndexPath: indexPath]
                  forIndexPath: indexPath];
        
        cell.delegate = self;
        
//        NSString* contactInfo = [self.model getContactValueForIndexPath: indexPath];
//        
//        cell.contactsLabel.text = contactInfo;
        
//        [self buttonImagesForCell: cell];
        //cell.contactsBtn.tag = indexPath.row;
        
        return cell;
    }
    else 
    {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"CellID"];
        
        cell.tag = indexPath.row;
        
        cell.textLabel.text  = [self labelsArray][indexPath.row];
    
        
        UIFont* customFont = [UIFont fontWithName: @"SFUIText-Regular"
                                                        size: 13.0f];
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.font = customFont;
        
        return cell;
    }
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    if (section == 0)
    {
        return [self.model countOfContactsContent];
    }
    
    else
        return [[self labelsArray] count];
}

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 2;
}


#pragma mark - TableView delegate methods -

- (CGFloat)     tableView: (UITableView*) tableView
 heightForHeaderInSection: (NSInteger)    section
{
    if (section == 0)
    {
        return 0;
    }
    
    else return 10.f;
}

- (void)        tableView: (UITableView*) tableView
  didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath: indexPath];
    if (cell.tag == RoleType)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(showControllerWithIdentifier:)])
        {
            [self.delegate showControllerWithIdentifier: SegueID];
        }
    }
    
    else
        if (cell.tag == PermissionType)
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(showDesignationAlert:)])
            {
                [self.delegate showDesignationAlert: [self.model getMemberName]];
            }
        }
    
}

#pragma mark - RolesControllerDelegate methods-

- (void) didSelectRole: (ProjectRoles*) value
{
   // self.cell.detailTextLabel.text = value.title;
}

#pragma mark - Helpers -

//- (NSArray*) teamMemberInfo
//{
//    NSMutableArray* tmp = [NSMutableArray arrayWithObjects: [self.model getEmail], [self.model getPhone],[self.model getAdditionalPhone], nil];
//    
//    if ([[self.model getEmail] isEqualToString: @""])
//    {
//        [tmp removeObject: [self.model getEmail]];
//    }
//    if ([[self.model getPhone] isEqualToString: @""])
//    {
//        [tmp removeObject: [self.model getPhone]];
//    }
//    if ([[self.model getAdditionalPhone] isEqualToString: @""])
//    {
//        [tmp removeObject: [self.model getAdditionalPhone]];
//    }
//    return tmp;
//}

//- (void) buttonImagesForCell: (ProfileInfoCell*) cell
//{
//    
//    UIImage* emailPic    = [UIImage imageNamed: @"Mail"];
//    UIImage* phonePic    = [UIImage imageNamed: @"Phone"];
//    
//    if (![[self.model getEmail] isEqualToString: @""])
//    {
//        [cell.contactsBtn setImage: emailPic
//                          forState: UIControlStateNormal];
//        
//    }
//    
//    if ((![[self.model getPhone] isEqualToString: @""]) ||
//        (![[self.model getAdditionalPhone] isEqualToString: @""]))
//    {
//        [cell.contactsBtn setImage: phonePic
//                          forState: UIControlStateNormal];
//    }
//    
//}

- (NSArray*) labelsArray
{
    return @[@"Роль в проекте", @"Права доступа"];
}


@end
