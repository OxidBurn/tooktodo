//
//  AttachmentsCellFactory.m
//  TookTODO
//
//  Created by Chaban Nikolay on 13.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AttachmentsCellFactory.h"

// Classes
#import "AttachmentsCell.h"

@implementation AttachmentsCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnAttachmentsCellForTableView: (UITableView*)    tableView
                                           withContent: (TaskRowContent*) content
{
    AttachmentsCell* cell = [tableView dequeueReusableCellWithIdentifier: @"AttachmentsCellId"];
    
    [cell fillCellWithContent: content];

    return cell;
}

@end
