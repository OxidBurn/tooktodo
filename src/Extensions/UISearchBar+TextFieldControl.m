//
//  UISearchBar+TextFieldControl.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/30/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UISearchBar+TextFieldControl.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+ (void)brc_swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Method origMethod = class_getInstanceMethod(self, origSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    
    if(class_addMethod(self, origSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(self, newSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
        method_exchangeImplementations(origMethod, newMethod);
}
@end

@implementation UISearchBar (TextFieldControl)

+ (void)load {
    [self brc_swizzleMethod:@selector(textFieldShouldClear:) withMethod:@selector(jbm_textFieldShouldClear:)];
}

- (id<UISearchBarWithClearButtonDelegate>)jbm_customDelegate {
    if( [[self delegate] conformsToProtocol:@protocol(UISearchBarWithClearButtonDelegate)] )
        return (id<UISearchBarWithClearButtonDelegate>)[self delegate];
    else
        return nil;
}

- (BOOL)jbm_textFieldShouldClear:(UITextField *)textField
{
    if ( [[self jbm_customDelegate] respondsToSelector:@selector(searchBarClearButtonClicked:)] )
        [[self jbm_customDelegate] searchBarClearButtonClicked:self];
    
    return [self jbm_textFieldShouldClear:textField];
}

@end
