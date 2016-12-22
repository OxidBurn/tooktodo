//
//  FilterAttachmentsCellFactory.m
//  TookTODO
//
//  Created by Chaban Nikolay on 12.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterAttachmentsCellFactory.h"

// Classes
#import "FilterAttachmentsCell.h"

@implementation FilterAttachmentsCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnFilterAttachmentsCellForTableView: (UITableView*) tableView
{
    FilterAttachmentsCell* cell = [tableView dequeueReusableCellWithIdentifier: @"FilterAttachmentsCellId"];
    
    return cell;
}


@end
