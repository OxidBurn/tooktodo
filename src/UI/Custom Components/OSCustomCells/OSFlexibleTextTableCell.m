//
//  FlexibleTextTableCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSFlexibleTextTableCell.h"

@interface OSFlexibleTextTableCell()

//Properties
@property (weak, nonatomic) IBOutlet UILabel* flexibleTextLabel;

@property (strong, nonatomic) UIColor* steelColor;
//Metods

@end

@implementation OSFlexibleTextTableCell


#pragma mark - Properties -

- (UIColor*) steelColor
{
    if ( _steelColor == nil )
    {
        CGFloat red   = 120.0/256;
        CGFloat green = 133.0/256;
        CGFloat blue  = 148.0/256;
        
        _steelColor = [UIColor colorWithRed: red green: green blue:blue alpha: 1.0];
    }
    
    return _steelColor;
}


#pragma mark - Public -

- (void) fillCellWithText: (NSString*) textContent
{
    self.flexibleTextLabel.text = textContent;
    
    if ( [textContent isEqualToString: @"Описание задачи"] == NO )
    {
        self.flexibleTextLabel.textColor = [UIColor blackColor];
    } else
    {
        self.flexibleTextLabel.textColor = self.steelColor;
    }
}

@end
