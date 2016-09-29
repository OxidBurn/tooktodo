//
//  SecureTextField.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSSecureTextField.h"

@interface OSSecureTextField() <UITextFieldDelegate>

// properties
@property (nonatomic, strong) NSMutableString * actualText;
@property (strong, nonatomic) NSMutableString * dotsText;
@property (assign, nonatomic) BOOL            isSecureState;
@property (strong, nonatomic) NSTimer         * updateLastSymbolTimer;

// methods


@end

@implementation OSSecureTextField


#pragma mark - Initialization -

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    self.delegate      = self;
    self.isSecureState = YES;
    self.dotsText      = [NSMutableString string];
    self.actualText    = [NSMutableString string];
    
    [self addTarget: self
             action: @selector(editingDidChange)
   forControlEvents: UIControlEventEditingChanged];
}


#pragma mark - Public methods -

- (void) updateSecureState: (BOOL) isSecure
{
    self.isSecureState = isSecure;
    
    [self updateValue];
}

- (NSString*) text
{
    return self.actualText;
}


#pragma mark - Event methods -

- (void) editingDidChange
{
    [self updateValue];
}


#pragma mark - Internal methods -

- (void) updateValue
{
    if ( self.isSecureState )
    {
        self.text = self.dotsText;
    }
    else
    {
        self.text = self.actualText;
    }
}

- (void) buildDotsText
{
    self.dotsText = [NSMutableString new];
    
    [self.actualText enumerateSubstringsInRange: NSMakeRange(0, self.actualText.length)
                                        options: NSStringEnumerationByComposedCharacterSequences
                                     usingBlock: ^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                                         
                                         if ( self.actualText.length > (substringRange.location + substringRange.length))
                                         {
                                             [self.dotsText appendString: @"\u2022"];
                                         }
                                         else
                                         {
                                             [self.dotsText appendString: substring];
                                         }
                                         
                                     }];
    
    [self startUpdatingLastSymbol];
}

- (void) startUpdatingLastSymbol
{
    if ( self.updateLastSymbolTimer.isValid )
    {
        [self.updateLastSymbolTimer invalidate];
    }
    
    self.updateLastSymbolTimer = [NSTimer scheduledTimerWithTimeInterval: 3.0f
                                                                  target: self
                                                                selector: @selector(updateLastSymbol:)
                                                                userInfo: nil
                                                                 repeats: NO];
}

- (void) updateLastSymbol: (NSTimer*) timer
{
    [timer invalidate];
    
    if ( self.dotsText.length > 0 )
    {
        [self.dotsText replaceCharactersInRange: NSMakeRange(self.dotsText.length - 1, 1)
                                     withString: @"\u2022"];
    }
    
    [self updateValue];
}


#pragma mark - Delegate methods -

- (BOOL)             textField: (UITextField*) textField
 shouldChangeCharactersInRange: (NSRange)      range
             replacementString: (NSString*)    string
{
    if ( [string isEqualToString: @"\n"] || [string isEqualToString: @" "] )
        return  NO;
    
    if ( string.length > 0 )
    {
        [self.actualText appendString: string];
        
        [self buildDotsText];
    }
    else
        if ( self.isSecureState )
        {
            self.dotsText   = [NSMutableString new];
            self.actualText = [NSMutableString new];
        }
        else
        {
            self.dotsText   = [NSMutableString stringWithString: [self.dotsText substringToIndex: range.location]];
            self.actualText = [NSMutableString stringWithString: [self.actualText substringToIndex: range.location]];
        }
    
    return YES;
}

- (BOOL) textFieldShouldReturn: (UITextField*) textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
