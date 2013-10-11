//
//  CTStringToBluetooth.m
//  AutoSpeech
//
//  Created by ge teng on 13-7-6.
//  Copyright (c) 2013年 geteng. All rights reserved.
//

#import "CTStringToBluetooth.h"
#import "CTIFlyRecognizerManage.h"


static CTStringToBluetooth *__selfSender = nil;
@implementation CTStringToBluetooth
@synthesize iDo;
@synthesize iSomeThing;
+(CTStringToBluetooth *)getInstance
{
	if(!__selfSender){
        @synchronized(self){
            if(!__selfSender){
                __selfSender = [[CTStringToBluetooth alloc] init];
                if (!__selfSender.iDo)
                {
                    __selfSender.iDo = [[NSMutableArray alloc]initWithObjects:@"开",@"关",@"红",@"绿",@"蓝",@"彩色", nil];
                }
                if (!__selfSender.iSomeThing)
                {
                    __selfSender.iSomeThing = [[NSMutableArray alloc]initWithObjects:@"灯",@"窗帘",@"墙壁",@"墙纸",@"你好", nil];
                }
            }
        }
	}
	return __selfSender;
}


+(NSData *)doChange:(NSString *)iString{
    UInt8 buf[3] = {0x00, 0x00, 0x00};

    
    if ([iString rangeOfString:@"灯"].location != NSNotFound) {
        buf[0] = 0x01;
        if ([iString rangeOfString:@"开"].location != NSNotFound) {
            buf[1] = 0x01;
        }else if ([iString rangeOfString:@"关"].location != NSNotFound){
            buf[1] = 0x00;
        }else {
            [CTIFlyRecognizerManage speak:@"请再说一遍"];
            return nil;
        }
    }else if([iString rangeOfString:@"窗帘"].location != NSNotFound){
        buf[0] = 0x02;
        if ([iString rangeOfString:@"开"].location != NSNotFound) {
            buf[1] = 0x01;
            //
        }else if ([iString rangeOfString:@"关"].location != NSNotFound){
            buf[1] = 0x00;
            //
        }else {
            [CTIFlyRecognizerManage speak:@"请再说一遍"];
            return nil;
        }
    }else if(([iString rangeOfString:@"墙壁"].location != NSNotFound)||([iString rangeOfString:@"墙纸"].location != NSNotFound)||([iString rangeOfString:@"墙壁"].location != NSNotFound)||([iString rangeOfString:@"强制"].location != NSNotFound)){
        buf[0] = 0x03;
        if ([iString rangeOfString:@"关"].location != NSNotFound) {
            buf[1] = 0x00;
            //
        }else if ([iString rangeOfString:@"彩色"].location != NSNotFound){
            buf[1] = 0x01;
            //
        }else if ([iString rangeOfString:@"红"].location != NSNotFound){
            buf[1] = 0x02;
            //
        }
        else if ([iString rangeOfString:@"绿"].location != NSNotFound){
            buf[1] = 0x03;
            //
        }else if ([iString rangeOfString:@"蓝"].location != NSNotFound){
            buf[1] = 0x04 ;
            //
        }else {
            [CTIFlyRecognizerManage speak:@"请再说一遍"];
            return nil;
        }
    } else {
        [CTIFlyRecognizerManage speak:@"请再说一遍"];
        return nil;
    }
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    return data;
}
@end
