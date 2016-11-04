//
//  FilterByDatesFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 04.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByDatesFactory.h"

// Classes
#import "ProjectsEnumerations.h"

// Factories
#import "OSRightDetailCellFactory.h"
#import "OSDatePickerCellFactory.h"


@interface FilterByDatesFactory()

// properties


// methods


@end

@implementation FilterByDatesFactory


#pragma mark - Public -


- (UITableViewCell*) returnCellForTableView: (UITableView*) tableView
                              withIndexPath: (NSIndexPath*) indexPath
                                withContent: (RowContent*)  rowContent
                               withDelegate: (id)           delegate
{
    UITableViewCell* cell = [UITableViewCell new];
    
    NSUInteger cellTypeIndex = rowContent.cellTypeIndex;
    
    switch ( cellTypeIndex )
    {
        case FilterByDatesRightDetailCell:
        {
            OSRightDetailCellFactory* factory = [OSRightDetailCellFactory new];
            
            cell = [factory returnRightDetailCellWithTitle: rowContent.title
                                            withDetailText: rowContent.detail
                                        withSelectedDetail: YES
                                              forTableView: tableView];
        }
            
            break;
        
        case FilterByDatesDatePickerCell:
        {
            OSDatePickerCellFactory* factory = [OSDatePickerCellFactory new];
            
            cell = [factory returnDatePickerCellWithTag: rowContent.pickerTag
                                         withDateToShow: rowContent.dateToShow
                                        withMinimumDate: rowContent.minimumDate
                                        withMaximumDate: rowContent.maximumDate
                                           forTableView: tableView
                                           withDelegate: delegate];
        }
            
        default:
            break;
    }
    
    return cell;
}

@end
