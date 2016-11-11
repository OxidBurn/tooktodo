//
//  OSSwitchTableCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSSwitchTableCellFactory.h"

// Classes
#import "OSSwitchTableCell.h"

@implementation OSSwitchTableCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnSwitchCellWithTitle: (NSString*)    titleText
                                       withTag: (NSUInteger)   tag
                               withSwitchState: (BOOL)         isOn
                                  forTableView: (UITableView*) tableView
                                  withDelegate: (id)           delegate
                              withEnabledState: (BOOL)         isEnabled
{
    OSSwitchTableCell* cell = [tableView dequeueReusableCellWithIdentifier: @"SwitchCellID"];
    
    [cell fillCellWithTitle: titleText
                    withTag: (NSUInteger) tag
            withSwitchState: isOn
               withDelegate: delegate
           withEnabledState: isEnabled];
    
    return cell;
}

@end
