//
//  FilterByTermsCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByTermsCell.h"

@interface FilterByTermsCell()

// outlets
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;

@property (weak, nonatomic) IBOutlet UILabel* endDateLabel;

@property (weak, nonatomic) IBOutlet UILabel* startDateLabel;

// properties
@property (assign, nonatomic) FilterByTermsCellType cellType;

// methods
- (IBAction) onShowEndDateOptions: (UIButton*) sender;

- (IBAction) onShowStartDateOptions: (UIButton*) sender;


@end

@implementation FilterByTermsCell


#pragma mark - Actions -

- (IBAction) onShowEndDateOptions: (UIButton*) sender
{
    FilterByDateViewControllerType controllerType = 0;
    
    switch ( self.cellType )
    {
        case FilterByTermsType:
            
            controllerType = ByTermsEnding;
            
            break;
            
        case FilterByFactTermsType:
            
            controllerType = ByFactTermsEnding;
            
        default:
            break;
    }
    
    if ( [self.delegate respondsToSelector: @selector(showFilterByDatesWithType:)] )
        [self.delegate showFilterByDatesWithType: controllerType];
}

- (IBAction) onShowStartDateOptions: (UIButton*) sender
{
    FilterByDateViewControllerType controllerType = 0;
    
    switch ( self.cellType )
    {
        case FilterByTermsType:
            
            controllerType = ByTermsBeginning;
            
            break;
            
        case FilterByFactTermsType:
            
            controllerType = ByFactTermsBeginning;
            
        default:
            break;
    }
    
    if ( [self.delegate respondsToSelector: @selector(showFilterByDatesWithType:)] )
        [self.delegate showFilterByDatesWithType: controllerType];
}


#pragma mark - Public -

- (void) fillCellWithWithContent: (TaskFilterRowContent*) rowContent
                    forTableView: (UITableView*)          tableView
                    withDelegate: (id)                    delegate

{
    self.titleLabel.text     = rowContent.title;
    self.endDateLabel.text   = rowContent.endTermsString;
    self.startDateLabel.text = rowContent.startTermsString;
    
    self.cellType = rowContent.termsType;
    
    self.delegate = delegate;
    
    self.startDateLabel.textColor = [self getTextColorForSelectedState: rowContent.isStartTermSelected];
    self.endDateLabel.textColor   = [self getTextColorForSelectedState: rowContent.isEndTermsSelected];
}


#pragma mark - Helpers -

- (UIColor*) getTextColorForSelectedState: (BOOL) isSelected
{
    UIColor* color = [UIColor new];
    
    if ( isSelected )
    {
        color = [UIColor blackColor];
    }
    else
    {
        color = [UIColor lightGrayColor];
    }
    
    return color;
}

@end
