//
//  OSRightDetailCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSRightDetailCellFactory.h"

@implementation OSRightDetailCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnRightDetailCellWithTitle: (NSString*)    titleText
                                     withDetailText: (NSString*)    detailText
                                 withSelectedDetail: (BOOL)         isSelected
                                       forTableView: (UITableView*) tableView
{
    OSRightDetailCell* cell = [tableView dequeueReusableCellWithIdentifier: @"RightDetailCellID"];
    
    [cell fillCellWithTitle: titleText
                 withDetail: detailText
           detailIsSelected: isSelected];
    
    cell.userInteractionEnabled = YES;
    cell.accessoryType          = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (UITableViewCell*) returnAboutProjectCommentCellWithComment: (NSString*)    comment
                                            withSelectedState: (BOOL)         isSelected
                                                 forTableView: (UITableView*) tableView
{
    OSRightDetailCell* cell = [tableView dequeueReusableCellWithIdentifier: @"RightDetailCellID"];
    
    [cell fillCellWithTitle: @"Комментарий"
                 withDetail: comment
           detailIsSelected: isSelected];
    
    return cell;
}

@end
