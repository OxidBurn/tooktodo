//
//  CommentsCellFactory.m
//  TookTODO
//
//  Created by Chaban Nikolay on 13.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CommentsCellFactory.h"

// Classes
#import "CommentsCell.h"

@implementation CommentsCellFactory

#pragma mark - Public -
- (UITableViewCell*) returnCommentsCellForTableView: (UITableView*)    tableView
                                        withContent: (TaskRowContent*) content
{
    CommentsCell* cell = [tableView dequeueReusableCellWithIdentifier: @"CommentsCellId"];
    
    [cell fillCellWithContent: content];

    return cell;
}

@end
