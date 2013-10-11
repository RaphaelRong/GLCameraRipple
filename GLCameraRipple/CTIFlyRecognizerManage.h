//
//  CTIFlyRecognizerManage.h
//  CTRIP_WIRELESS_V4.5
//
//  Created by geteng on 13-3-6.
//  Copyright (c) 2013年 gt. All rights reserved.
//  讯飞语音控件单例

#import <Foundation/Foundation.h>
#import "iflyMSC/IFlySpeechRecognizer.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechRecognizerDelegate.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import "iflyMSC/IFlySpeechUser.h"
//#import "iflyMSC/IFlyUserWords.h"
//#import "iflyMSC/IFlyDataUploader.h"

/** 讯飞语音控件单例生成类*/
@interface CTIFlyRecognizerManage : NSObject<IFlySpeechSynthesizerDelegate,IFlySpeechUserDelegate/*,IFlyDataUploaderDelegate*/>{

}
@property (nonatomic, assign) id<IFlySpeechSynthesizerDelegate> delegateForSynthesizer;
//获取自己单例
+(CTIFlyRecognizerManage *)getInstance;
+(void)login;
/**
 获取讯飞识别控件静态方法
 
 @return 获取讯飞语音识别控件单例
 */
+(IFlySpeechRecognizer *)getInstanceForRecognizer:(id)sender;

/**
 获取讯飞合成空间静态方法
 
 @return 获取讯飞合成空间控件单例
 */
+(IFlySpeechSynthesizer *)getInstanceForSynthesizer:(id)sender;
+(IFlySpeechSynthesizer *)getInstanceForSynthesizer:(id)sender Content:(NSString *)iString;
+(void)speak:(NSString *)iString;//注意会制nil代理
@end
