//
//  FilterByTermsCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByTermsCellFactory.h"

@implementation FilterByTermsCellFactory


#pragma mark - Public -

- (UITableViewCell*) returnFilterByTermsCellWithTitle: (NSString*)             title
                                       withStartTerms: (NSString*)             startTerms
                                         withEndTerms: (NSString*)             endTerms
                                         forTableView: (UITableView*)          tableView
                                         withCellType: (FilterByTermsCellType) cellType
                                         withDelegate: (id)                    delegate
{
    FilterByTermsCell* cell = [tableView dequeueReusableCellWithIdentifier: @"FilterByTermsCellID"];
    
    [cell fillCellWithTitle: title
             withStartTerms: startTerms
               withEndTerms: endTerms
               withCellType: cellType
               withDelegate: delegate];
    
    return cell;
}


@end
