//
//  CMP20DRIVER.m
//  CMP20DRIVER
//
//  Created by ZNATZ on 2015/08/07.
//  Copyright © 2015年 ZNATZ. All rights reserved.
//

#import "CMP20DRIVER.h"

@implementation CMP20DRIVER

-(CMP20DRIVER *) initWithURL : (NSString *) url{
    self            = [super init];
    self.printer    = [[ESCPOSPrinter alloc] init];
    if ([self.printer openPort:url withPortParam:9100] <0 ) { return nil; }
    [self.printer setEncoding:NSShiftJISStringEncoding];
    return self;
}

-(void) printHeader {
    unsigned char tWidthHeightSize[3]   = {0x1D,0x21,0x22};
    unsigned char centerAlign[3]        = {0x1B,0x61,0x01};
    
    [self.printer printData:centerAlign withLength:sizeof(centerAlign)];
    [self.printer printData:tWidthHeightSize withLength:sizeof(tWidthHeightSize)];
    [self.printer printString:@"領 収 証\r\n\r\n"];
}

-(void) close {
    [self.printer lineFeed:4];
    [self.printer closePort];
}

 
-(void) printTxtName : (NSString *) file {
    NSString * filePath = [[NSBundle mainBundle] pathForResource:file ofType:@"txt"];
    NSLog(@"file : %@ ^^^^^^ filePaht : %@", file, filePath);
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    NSString * content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self normal_left:[NSString stringWithFormat:@"%@", content]];
}
 
-(NSString *) setStringAsCurrency : (NSString *) input {
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    [f setNumberStyle:NSNumberFormatterCurrencyStyle];
    [f setCurrencySymbol:@"￥"];
    NSString * formatted = [f stringFromNumber:[[NSNumber alloc] initWithInt:[input intValue]]];
    return formatted;
}

-(NSString*)leftJPJustify:(NSString *) input amount:(NSInteger )amount with:(NSString*)padString{
    if (amount <= input.length * 2)
        return input;
    NSString *pad = @"";
    NSInteger c = 0;
    for(NSInteger i = 0;i<amount-(input.length * 2);i++){
        pad = [NSString stringWithFormat:@"%@%c",pad,[padString characterAtIndex:c++]];
        if(c >= padString.length)
            c = 0;
    }
    NSString *result = [NSString stringWithFormat:@"%@%@",input,pad];
    return result;
}

-(void) printSeparator {
    [self normal_center:@"------------------------------\r\n"];
}


-(void) normal_left : (NSString *) line {
    unsigned char leftAlign[3] = {0x1B,0x61,0x00};
    unsigned char normalSize[3] = {0x1D,0x21,0x00};
    [self.printer printData:leftAlign withLength:3];
    [self.printer printData:normalSize withLength:3];
    [self.printer printString:line];
}

-(void) normal_right : (NSString *) line {
    unsigned char rightAlign[3] = {0x1B,0x61,0x02};
    unsigned char normalSize[3] = {0x1D,0x21,0x00};
    [self.printer printData:rightAlign withLength:sizeof(rightAlign)];
    [self.printer printData:normalSize withLength:sizeof(normalSize)];
    [self.printer printString:line];
}

-(void) normal_center : (NSString *) line {
    unsigned char centerAlign[3] = {0x1B,0x61,0x01};
    unsigned char normalSize[3] = {0x1D,0x21,0x00};
    [self.printer printData:centerAlign withLength:sizeof(centerAlign)];
    [self.printer printData:normalSize withLength:sizeof(normalSize)];
    [self.printer printString:line];
}


-(void) double_width_left : (NSString *) line {
    unsigned char leftAlign[3] = {0x1B,0x61,0x00};
    unsigned char dWidthSize[3] = {0x1D,0x21,0x10};
    [self.printer printData:leftAlign withLength:sizeof(leftAlign)];
    [self.printer printData:dWidthSize withLength:sizeof(dWidthSize)];
    [self.printer printString:line];
}

-(void) double_width_right : (NSString *) line {
    unsigned char rightAlign[3] = {0x1B,0x61,0x02};
    unsigned char dWidthSize[3] = {0x1D,0x21,0x10};
    [self.printer printData:rightAlign withLength:sizeof(rightAlign)];
    [self.printer printData:dWidthSize withLength:sizeof(dWidthSize)];
    [self.printer printString:line];
}

-(void) double_width_center : (NSString *) line {
    unsigned char centerAlign[3] = {0x1B,0x61,0x01};
    unsigned char dWidthSize[3] = {0x1D,0x21,0x10};
    [self.printer printData:centerAlign withLength:sizeof(centerAlign)];
    [self.printer printData:dWidthSize withLength:sizeof(dWidthSize)];
    [self.printer printString:line];
}


@end


/*


*/