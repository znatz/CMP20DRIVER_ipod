//
//  CMP20DRIVER.h
//  CMP20DRIVER
//
//  Created by ZNATZ on 2015/08/07.
//  Copyright © 2015年 ZNATZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESCPOSPrinter.h"

@interface CMP20DRIVER : NSObject
@property ESCPOSPrinter * printer;
- (CMP20DRIVER *) initWithURL : (NSString *) url;
- (void) printHeader ;
- (void) printSeparator ;
- (void) printTxtName : (NSString *) file ;
- (void) close ;

- (void) normal_left     : (NSString *) line ;
- (void) normal_center   : (NSString *) line ;
- (void) normal_right    : (NSString *) line ;
- (void) double_width_left      : (NSString *) line ;
- (void) double_width_center    : (NSString *) line ;
- (void) double_width_right     : (NSString *) line ;
@end
