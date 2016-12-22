//
//  AddCommentCellFactory.m
//  TookTODO
//
//  Created by Chaban Nikolay on 12.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddCommentCellFactory.h"

// Classes
#import "AddCommentCell.h"

@implementation AddCommentCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnAddCommentCellForTableView: (UITableView*) tableView
{
    AddCommentCell* cell = [tableView dequeueReusableCellWithIdentifier: @"AddCommentCellId"];
    
    return cell;
}

@end
