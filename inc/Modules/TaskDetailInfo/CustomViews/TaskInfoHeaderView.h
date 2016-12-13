//
//  SubTaskInfoView.h
//  TookTODO
//
//  Created by Chaban Nikolay on 10.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TaskInfoHeaderDelegate;

@interface TaskInfoHeaderView : UIView

// properties
@property (weak, nonatomic) id <TaskInfoHeaderDelegate> delegate;

// methods
- (void) fillViewWithInfo: (NSArray*) infoArray
             withDelegate: (id)       delegate;

@end

@protocol TaskInfoHeaderDelegate <NSObject>

- (void) updateSecondSectionContentType: (NSUInteger) typeIndex;

@end
