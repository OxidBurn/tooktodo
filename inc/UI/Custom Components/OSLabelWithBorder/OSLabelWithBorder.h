//
//  OSLabelWithBorder.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface OSLabelWithBorder : UILabel

@property (assign, nonatomic) IBInspectable CGFloat borderWidth;

@property (strong, nonatomic) IBInspectable UIColor* borderColor;

@end
