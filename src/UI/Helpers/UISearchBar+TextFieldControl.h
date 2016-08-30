//
//  UISearchBar+TextFieldControl.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/30/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UISearchBarWithClearButtonDelegate <UISearchBarDelegate>

@optional
- (void) searchBarClearButtonClicked: (id) sender;

@end

@interface UISearchBar (TextFieldControl)

@end
