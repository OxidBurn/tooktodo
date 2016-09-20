//
//  Utils.h
//  Browse
//
//  Created by Chaban Nikolay on 4/9/14.
//  Copyright __MyCompanyName__ 2014. All rights reserved.
//


@interface Utils : NSObject

#pragma - Font -

//! Create default regular font of the given size
+ (UIFont*) defaultFontOfSize: (CGFloat) size;

//! Create default medium font of the given size
+ (UIFont*) defaultMediumFontOfSize: (CGFloat) size;

//! Create default bold font of the given size
+ (UIFont*) defaultBoldFontOfSize: (CGFloat) size;

/**
 *  Used in app font Helvetica-Neue Medium with custom size
 *
 *  @param size font size
 *
 *  @return Custom font
 */
+ (UIFont*) helveticaMedFontOfSize: (CGFloat) size;

/**
 *  Used in app font Helvetica-Neue Light with custom size
 *
 *  @param size font size
 *
 *  @return Custom font
 */
+ (UIFont*) helveticaLightFontOfSize: (CGFloat) size;

/** Print all fonts
 */
+ (void) printAllFonts;

/**
 *  Get device token string from device token data
 *
 *  @param deviceTokenData token data
 *
 *  @return token string
 */
+ (NSString*) deviceTokenAsString: (NSData*) deviceTokenData;

/** Detect os version
 */
+ (NSUInteger) detectOSVersion;

/**
 *  Check internet connection
 *
 *  @return internet connection bool state
 */
+ (BOOL) connectedToNetwork;

/**
 *  Get path to library directory with subpath
 *
 *  @param relPath sub path of the library directory
 *
 *  @return full path to folder/file
 */
+ (NSString*) libraryPath: (NSString*) relPath;

#pragma - Misc -

+ (BOOL) isDeviceJailbroken;

+ (BOOL) isValidEmail: (NSString*) email;

+ (NSString*) urlEncodedString: (NSString*) url;

+ (NSString*) readableValueWithBytes: (id) bytes;

+ (NSString*) stringFromFileSize: (int) theSize;

/** Get support directory path
 */
+ (NSString*) applicationSupportDirectory;


- (NSDate*) getDateFromString: (NSString*) string;


#pragma mark - Avatars -

+ (NSString*) getAvatarsDirectoryPath;

+ (void) createAvatarDirectoryIfNotExist;

+ (NSString*) getNameAbbreviation: (NSString*) name;

+ (NSString*) getAbbreviationWithName: (NSString*) name
                          withSurname: (NSString*) surname;

+ (NSString*) getEmailPrefix: (NSString*) email;

#pragma mark - Date/time -

+ (NSDateFormatter*) defaultDateFormatter;

+ (BOOL) addSkipBackupAttributeToItemAtURL: (NSURL*) URL;

+ (NSString*) stringFromCurrentDate;

+ (UIImage*) imageWithImage: (UIImage*) image
               scaledToSize: (CGSize)   newSize;

+ (CGSize) findHeightForText: (NSString*) text
                 havingWidth: (CGFloat)   widthValue
                     andFont: (UIFont*)   font;

+ (NSString*) stringByStrippingHTML: (NSString*) inputString;

+ (NSString*) getDeclensionStringWithValue: (NSUInteger) count
                    withSearchedObjectName: (NSString*)  value;

@end
