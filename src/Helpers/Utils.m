//
//  Utils.m
//  Browse
//
//  Created by Chaban Nikolay on 4/9/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"

// Libraries
#import <Reachability/Reachability.h>
#import "NSString+APUtils.h"
#import "NSDate+Helper.h"
#import "NSDate-Utilities.h"
#import "AlertViewBlocks.h"

//! Default date formatter
static NSDateFormatter* defaultDateFormatter = nil;


@implementation Utils


#pragma mark - Fonts -


+ (UIFont*) defaultFontOfSize: (CGFloat) size
{
	return [UIFont systemFontOfSize: size];
}


+ (UIFont*) defaultMediumFontOfSize: (CGFloat) size
{
	return [UIFont systemFontOfSize: size];
}


+ (UIFont*) defaultBoldFontOfSize: (CGFloat) size
{
	return [UIFont boldSystemFontOfSize: size];
}

+ (UIFont*) helveticaMedFontOfSize: (CGFloat) size
{
    return [UIFont fontWithName: @"HelveticaNeue-Medium"
                           size: size];
}

+ (UIFont*) helveticaLightFontOfSize: (CGFloat) size
{
    return [UIFont fontWithName: @"HelveticaNeue-Light"
                           size: size];
}

+ (void) printAllFonts
{
    NSArray* allFonts = [UIFont familyNames];
    
    [allFonts enumerateObjectsUsingBlock: ^(NSString* familyName, NSUInteger idx, BOOL* stop) {
        
        NSArray* fontName = [UIFont fontNamesForFamilyName: familyName];
        
        [fontName enumerateObjectsUsingBlock: ^(NSString* fontName, NSUInteger idx, BOOL* stop) {
            
#if __DEBUG__
           NSLog(@"%@", fontName);
#endif
            
        }];
        
    }];
}

+ (NSString*) deviceTokenAsString: (NSData*) deviceTokenData
{
    NSCharacterSet* characterSet = [NSCharacterSet characterSetWithCharactersInString: @"<>"];
    
    NSString* tokenstring = [[[deviceTokenData description] stringByTrimmingCharactersInSet: characterSet] stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    return tokenstring;
}

+ (NSUInteger) detectOSVersion
{
    static NSUInteger deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSString *systemVersion = [UIDevice currentDevice].systemVersion;
        deviceSystemMajorVersion = [[systemVersion componentsSeparatedByString:@"."][0] intValue];
    });
    
    return deviceSystemMajorVersion;
}

+ (BOOL) connectedToNetwork
{
    return [[Reachability reachabilityWithHostname: @"www.google.com"] isReachable];
}

+ (NSString*) libraryPath: (NSString*) relPath
{
    NSArray* docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* path    = docPaths[0];
    
    if (relPath != nil)
        path = [path stringByAppendingPathComponent: relPath];
    
    return path;
}

#pragma mark - Date/time -


+ (NSDateFormatter*) defaultDateFormatter
{
  if (defaultDateFormatter == nil)
  {
    defaultDateFormatter = [[NSDateFormatter alloc] init];

    defaultDateFormatter.dateFormat = @"MM/dd/yyyy hh:mm:ss a";
    defaultDateFormatter.locale     = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"];
    defaultDateFormatter.timeZone   = [NSTimeZone timeZoneWithAbbreviation: @"GMT"];
  }

  return defaultDateFormatter;
}


#pragma mark - Misc -


+ (BOOL) isDeviceJailbroken
{
	BOOL jailbreak = NO;
	
	if ([[NSFileManager defaultManager] fileExistsAtPath: @"/bin/bash"])
		jailbreak = YES;
	else
	if ([[NSFileManager defaultManager] fileExistsAtPath: @"/Applications/Cydia.app"])
		jailbreak = YES;
	
	return jailbreak;
} 


+ (BOOL) isValidEmail: (NSString*) email
{
  NSString* emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
  
  NSPredicate* predicate = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", emailRegEx];
  
  return [predicate evaluateWithObject: [email lowercaseString]];
}

+ (NSString*) urlEncodedString: (NSString*) url
{
    return [url stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet characterSetWithCharactersInString: @"!*'();:@&=+$,/?%#[]"]];
}

+ (NSString*) readableValueWithBytes: (id) bytes
{
    
    NSString* readable;
    
    //round bytes to one kilobyte, if less than 1024 bytes
    if (([bytes longLongValue] < 1024))
    {
        
        readable = [NSString stringWithFormat:@"1 KB"];
    }
    
    //kilobytes
    if (([bytes longLongValue]/1024)>=1)
    {
        
        readable = [NSString stringWithFormat:@"%lld KB", ([bytes longLongValue]/1024)];
    }
    
    //megabytes
    if (([bytes longLongValue]/1024/1024)>=1){
        
        readable = [NSString stringWithFormat:@"%llu MB", ([bytes longLongValue]/1024/1024)];
    }
    
    //gigabytes
    if (([bytes longLongValue]/1024/1024/1024)>=1){
        
        readable = [NSString stringWithFormat:@"%lld GB", ([bytes longLongValue]/1024/1024/1024)];
    }
    
    //terabytes
    if (([bytes longLongValue]/1024/1024/1024/1024)>=1){
        
        readable = [NSString stringWithFormat:@"%lld TB", ([bytes longLongValue]/1024/1024/1024/1024)];
    }
    
    //petabytes
    if (([bytes longLongValue]/1024/1024/1024/1024/1024)>=1){
        
        readable = [NSString stringWithFormat:@"%lld PB", ([bytes longLongValue]/1024/1024/1024/1024/1024)];
    }
    
    return readable;
}

+ (NSString*) addZeroToEnd: (NSString*) string
{
    NSRange dotRange = [string rangeOfString: @"."];
    NSRange spaceRange = [string rangeOfString: @" "];
    
    if ( dotRange.location == NSNotFound )
    {
        NSString* valueSize = [string substringFromIndex: spaceRange.location + spaceRange.length];
        string              = [string substringToIndex: spaceRange.location];
        string              = [string stringByAppendingFormat: @".0 %@", valueSize];
    }
    
    return string;
}

+ (NSString*) stringFromFileSize: (int) theSize
{
    float floatSize = theSize;
    if (theSize<1023)
        return([NSString stringWithFormat: @"%i bytes",theSize]);
    floatSize = floatSize / 1024;
    if (floatSize<1023)
        return([NSString stringWithFormat: @"%1.1f KB",floatSize]);
    floatSize = floatSize / 1024;
    if (floatSize<1023)
        return([NSString stringWithFormat: @"%1.1f MB",floatSize]);
    floatSize = floatSize / 1024;
    
    // Add as many as you like
    
    return([NSString stringWithFormat: @"%1.1f GB",floatSize]);
}

+ (UIImage*) imageWithImage: (UIImage*) image
               scaledToSize: (CGSize)   newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    
    [image drawInRect: CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (NSString*) stringFromCurrentDate
{
    NSDateFormatter* outputFormatter = [[NSDateFormatter alloc] init];
    
    [outputFormatter setDateFormat: @"yyyy-MM-dd hh:mm"];
    
    NSString* timestamp_str = [outputFormatter stringFromDate: [NSDate date]];
    
    return timestamp_str;
}

- (NSDate*) getDateFromString: (NSString*) string
{
    NSDate* expareDate = [NSDate dateFromString: string withFormat: @"E, dd MMM yyyy HH:mm:ss zzz"];
    
    return expareDate;
}

#pragma mark - Application -

+ (NSString*) applicationSupportDirectory
{
    NSString* basePath = [NSHomeDirectory() stringByReplacingOccurrencesOfString: @"file://" withString: @""];
    
    basePath = [basePath stringByAppendingPathComponent: @"/Library/Application Support"];
    
    if ( [DefaultFileManager fileExistsAtPath: basePath isDirectory: nil] == NO )
    {
        [DefaultFileManager createDirectoryAtPath: basePath
                      withIntermediateDirectories: NO
                                       attributes: nil
                                            error: nil];
    }
    
    return basePath;
}

+ (NSString*) getAbbreviationWithName: (NSString*) name
                          withSurname: (NSString*) surname
{
    NSString* abbreviationOfName = @"";
    
    if ( name.length > 0 )
        abbreviationOfName = [abbreviationOfName stringByAppendingString: [name substringToIndex: 1]];
    if ( surname.length > 0 )
        abbreviationOfName = [abbreviationOfName stringByAppendingString: [surname substringToIndex: 1]];
    
    return abbreviationOfName;
}

+ (NSString*) getAvatarsDirectoryPath
{
    NSString* avatarsDirectoryPath = [[Utils applicationSupportDirectory] stringByAppendingString: @"/Avatars/"];
    
    return avatarsDirectoryPath;
}

+ (void) createAvatarDirectoryIfNotExist
{
    BOOL isDirectory           = YES;
    NSString* avatarsDirectory = [Utils getAvatarsDirectoryPath];
    
    if ( [DefaultFileManager fileExistsAtPath: avatarsDirectory
                                  isDirectory: &isDirectory] == NO )
    {
        [DefaultFileManager createDirectoryAtPath: avatarsDirectory
                      withIntermediateDirectories: NO
                                       attributes: nil
                                            error: nil];
    }
}

+ (NSString*) getEmailPrefix: (NSString*) email
{
    NSRange range         = [email rangeOfString: @"@"];
    NSString* emailPrefix = @"";
    if ( range.location != NSNotFound )
    {
        emailPrefix = [email substringToIndex: range.location];
    }
    
    return emailPrefix;
}


#pragma mark - iCloud skip backup -

+ (BOOL) addSkipBackupAttributeToItemAtURL: (NSURL*) URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError* error = nil;
    
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    
#if __DEBUG__
   if( !success )
    {
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
#endif
    
    return success;
}

+ (CGSize) findHeightForText: (NSString*) text
                 havingWidth: (CGFloat)   widthValue
                     andFont: (UIFont*)   font
{
    CGSize size = CGSizeZero;
    
    if (text)
    {
        CGRect frame = [text boundingRectWithSize: CGSizeMake(widthValue, CGFLOAT_MAX)
                                          options: NSStringDrawingUsesLineFragmentOrigin
                                       attributes: @{ NSFontAttributeName: font }
                                          context: nil];
        
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    
    return size;
}

+ (NSString*) getNameAbbreviation: (NSString*) name
{
    NSMutableString* abbreviation = [NSMutableString stringWithString: [name substringToIndex: 1]];
    
    NSRange whiteSpaceRange = [name rangeOfString: @" "];
    
    if ( whiteSpaceRange.location != NSNotFound )
    {
        NSString* tmpString = [name substringFromIndex: whiteSpaceRange.location + 1];
        
        [abbreviation appendString: [tmpString substringToIndex: 1]];
    }
    
    return abbreviation;
}

+ (NSString*) stringByStrippingHTML: (NSString*) inputString
{
    NSMutableString *outString;
    
    if (inputString)
    {
        outString = [[NSMutableString alloc] initWithString:inputString];
        
        if ([inputString length] > 0)
        {
            NSRange r;
            
            while ((r = [outString rangeOfString: @"<[^>]*>|&nbsp;|[printf]+\\(\'*|\\\'\\);" options:NSRegularExpressionSearch]).location != NSNotFound)
            {
                [outString deleteCharactersInRange: r];
            }
        }
    }
    
    return outString; 
}

+ (NSString*) getDeclensionStringWithValue: (NSUInteger) count
                    withSearchedObjectName: (NSString*)  value
{
    NSString* fullSearchingPhrase = @"";
    
    NSString* foundWordSufix      = @"";
    NSString* searchedObjectSufix = @"";
    
    if ([value isEqualToString: @"проект"])
    {
        if ( count > 1 && count <= 4 )
        {
            foundWordSufix      = @"o";
            searchedObjectSufix = @"a";
        }
        else
            if ( count > 4 || count == 0 )
            {
                foundWordSufix      = @"o";
                searchedObjectSufix = @"ов";
            }
        
        fullSearchingPhrase = [NSString stringWithFormat: @"найден%@ %ld %@%@", foundWordSufix, (unsigned long)count, value, searchedObjectSufix];
     }
    
    else if ([value isEqualToString: @"задач"])
    {
        if ( count > 1 && count <= 4 )
        {
            foundWordSufix      = @"о";
            searchedObjectSufix = @"и";
        }
        else
            if ( count > 4 || count == 0 )
            {
                foundWordSufix      = @"о";
                searchedObjectSufix = @"";
            }
        else
            if (count == 1)
            {
                foundWordSufix      = @"а";
                searchedObjectSufix = @"a";
            }
        
        fullSearchingPhrase = [NSString stringWithFormat: @"найден%@ %ld %@%@", foundWordSufix, (unsigned long)count, value, searchedObjectSufix];
    }
    
    return fullSearchingPhrase;
}


+ (NSString*) generateStringOfDaysCount: (NSUInteger) count
{
    NSString* daysCountString = [NSString stringWithFormat: @"%ld ", (unsigned long)count];
    NSString* sufixString     = @"";
    
    switch (count)
    {
        case 1:
            sufixString = @"день";
            break;
        case 2 ... 4 :
            sufixString = @"дня";
            break;
        case 5 ... NSIntegerMax:
            sufixString = @"дней";
            break;
        default:
            sufixString = @"дней";
            break;
    }
    
    daysCountString = [daysCountString stringByAppendingString: sufixString];
    
    return daysCountString;
}

+ (NSDate*) getFistDayOfCurrentWeeak
{
    NSDate* currentWeek = [NSDate date];
    
    NSDate* firstDateOfWeek = [[currentWeek beginningOfWeek] dateByAddingDays: 1];
    
    return firstDateOfWeek;
}

+ (NSDate*) getLastDayOfCurrentWeek
{
    NSDate* currentWeek = [NSDate date];
    
    NSDate* lastDate = [[currentWeek endOfWeek] dateByAddingDays: 1];
    
    return lastDate;
}

+ (NSDate*) getFirstDateOfPrevWeek
{
    NSDate* weekAgoDate = [[NSDate date] dateBySubtractingDays: 7];
    
    NSDate* firstDateOfWeek = [[weekAgoDate beginningOfWeek] dateByAddingDays: 1];
    
    return firstDateOfWeek;
}

+ (NSDate*) getLastDayOfPrevWeek
{
    NSDate* weekAgoDate = [[NSDate date] dateBySubtractingDays: 7];
    
    NSDate* lastDate = [[weekAgoDate endOfWeek] dateByAddingDays: 1];
    
    return lastDate;
}

+ (NSDate*) getFirstDateOfCurrentMonth
{
    NSDate* currentDate = [NSDate date];
    
    NSDate* firstDateOfMonth = [[currentDate beginningOfMonth] dateByAddingHours: 2];
    
    return firstDateOfMonth;
}

+ (NSDate*) getLastDateOFCurrentMonth
{
    NSDate* currentDate = [NSDate date];
    
    NSDate* lastDayOfCurrentMonth = [[currentDate endOfMonth] dateByAddingHours: 2];
    
    return lastDayOfCurrentMonth;
}

+ (NSDate*) getFirstDateOfPrevMonth
{
    NSDate* monthAgoDate = [Utils getDateOfMonthAgo];
    
    NSDate* firstDateOfMonth = [[monthAgoDate beginningOfMonth] dateByAddingHours: 3];
    
    return firstDateOfMonth;
}

+ (NSDate*) getLastDateOFPrevMonth
{
    NSDate* monthAgoDate = [Utils getDateOfMonthAgo];
    
    NSDate* lastDayOfCurrentMonth = [monthAgoDate endOfMonth];
    
    return lastDayOfCurrentMonth;
}

+ (NSDate*) getDateOfMonthAgo
{
    NSDate *date                     = [NSDate date];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    
    [dateComponents setMonth: -1];
    
    date = [[NSCalendar currentCalendar] dateByAddingComponents: dateComponents
                                                         toDate: date
                                                        options: 0];
    
    return date;
}

+ (void) showErrorAlertWithMessage: (NSString*) message
{
    [AlertViewBlocks alertWithTitle: @"Ошибка"
                            message: message
                            confirm: nil
                             cancel: nil
                  otherButtonTitles: @"Ok", nil];
}

@end
