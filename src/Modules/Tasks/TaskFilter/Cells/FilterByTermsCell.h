//
//  FilterByTermsCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "ProjectsEnumerations.h"

@protocol FilterByTermsCellDelegate;

@interface FilterByTermsCell : UITableViewCell

// properties
@property (weak, nonatomic) id <FilterByTermsCellDelegate> delegate;

// methods

- (void) fillCellWithTitle: (NSString*)             titleText
            withStartTerms: (NSString*)             startTerms
              withEndTerms: (NSString*)             endTerms
              withCellType: (FilterByTermsCellType) cellType
              withDelegate: (id)                    delegate;

@end

@protocol FilterByTermsCellDelegate <NSObject>

- (void) showFilterByDatesWithType: (FilterByDateViewControllerType) controllerType;

@end
