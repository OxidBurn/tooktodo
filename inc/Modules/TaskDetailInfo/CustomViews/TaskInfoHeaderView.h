//
//  SubTaskInfoView.h
//  TookTODO
//
//  Created by Chaban Nikolay on 10.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TaskInfoFooterDelegate;

@interface TaskInfoHeaderView : UIView

// properties
@property (weak, nonatomic) id <TaskInfoFooterDelegate> delegate;

// methods
- (void) fillViewWithInfo: (NSArray*) infoArray
             withDelegate: (id)       delegate;

@end

@protocol TaskInfoFooterDelegate <NSObject>

- (void) updateSecondSectionContentType: (NSUInteger) typeIndex;

@end
