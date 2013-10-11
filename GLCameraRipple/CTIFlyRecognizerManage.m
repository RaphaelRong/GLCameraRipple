//
//  CTIFlyRecognizerManage.m
//  CTRIP_WIRELESS_V4.5
//
//  Created by geteng on 13-3-6.
//  Copyright (c) 2013年 gt. All rights reserved.
//  讯飞语音控件单例

#import "CTIFlyRecognizerManage.h"

//#define APPID @"4db7c9c3"
//#define ENGINE_URL @"http://dev.voicecloud.cn:1028/index.htm"
#define ENGINE_URL @http://dev.voicecloud.cn:1028/index.htm

#import <UIKit/UIKit.h>
#define APPID           @"51c17283"         // appid        在开发者论坛中申请的
#define URL             @"http://dev.voicecloud.cn:1028/index.htm"                 // url
#define TIMEOUT         @"20000"            // timeout      连接超时的时间，以ms为单位
#define PWD             @""                 // password     密码，在开发者论坛中注册的用户名
#define USR             @""                 // user         用户名，在开发者论坛中注册的用户名
#define BEST_URL        @"1"                   // best_search_url 最优搜索路径


#define SEARCH_AREA     @"上海市"
#define ASR_PTT         @"1"
#define VAD_BOS         @"5000"
#define VAD_EOS         @"1800"
#define PLAIN_RESULT    @"1"
#define ASR_SCH         @"1"

#define USERWORDS   @"{\"userword\":[{\"name\":\"iflytek\",\"words\":[\"科大讯飞\",\"云平台\",\"用户词条1\",\"开始上传词条\"]}]}"

#define PARAMS @"sub=iat,dtt=userword"
#define NAME @"userwords"

static CTIFlyRecognizerManage *__selfSender = nil;

@implementation CTIFlyRecognizerManage
@synthesize delegateForSynthesizer;

static IFlySpeechRecognizer *manage = nil;
static IFlySpeechSynthesizer *manageTwo = nil;

#pragma mark - --------------------退出清空--------------------

//- (void)dealloc
//{
//    delegateForSynthesizer =nil;
//    [super dealloc];
//}

#pragma mark - --------------------接口API--------------------
+(void)login{
    if (![IFlySpeechUser isLogin]) {
        // 需要先登陆
        IFlySpeechUser *loginUser = [[IFlySpeechUser alloc] initWithDelegate:[CTIFlyRecognizerManage getInstance]];
        // user 和 pwd 都传入nil时表示是匿名登陆
        NSString *loginString = [[NSString alloc] initWithFormat:@"appid=%@",APPID];
        [loginUser login:@"13641887009" pwd:@"gtt123456" param:loginString];
//        [loginString release];
    }
}
- (void) onUpload
{
//    IFlyUserWords *iFlyUserWords = [[[IFlyUserWords alloc] initWithJson:USERWORDS]autorelease];
//    IFlyDataUploader *uploader = [[[IFlyDataUploader alloc] initWithDelegate:nil pwd:nil params:nil delegate:self] autorelease];
//    
//    [uploader uploadData:NAME params:PARAMS data:[iFlyUserWords toString]];
}


+(CTIFlyRecognizerManage *)getInstance
{
	if(!__selfSender){
        @synchronized(self){
            if(!__selfSender){
                __selfSender = [[CTIFlyRecognizerManage alloc] init];
            }
        }
	}
	return __selfSender;
}
#pragma -mark 语音识别部分
+ (IFlySpeechRecognizer *)getInstanceForRecognizer:(id)sender
{
    if (!manage)
    {
        @synchronized(self)
        {
            if (!manage)
            {
                //初始化语音识别参数
                NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,timeout=%@",APPID,TIMEOUT];
                manage = [IFlySpeechRecognizer createRecognizer: initString delegate:sender];
//                [initString release];
                
                
                /**
                 * @fn      setParameter
                 * @brief   设置引擎参数
                 *
                 * key的取值:
                 *          domain:应用的领域,可设参数:iat,search,video,poi，music,asr
                 *          vad_bos:vad前端点超时,可选范围:1000-10000(单位:ms),默认值：短信转写5000，其它4000
                 *          vad_eos:vad后端点超时，可选范围:0-10000(单位:ms),默认值:短信转写1800,其它700
                 *          sample_rate:采样率,16000或者8000
                 * 更多取值请参考开发手册
                 * @param   key                 -[in] 参数名称
                 * @param   value               -[in] 参数的值
                 * @see
                 */
                // 设置识别的参数
                [manage setParameter:@"domain" value:@"sms"];
                [manage setParameter:@"sample_rate" value:@"16000"];
                [manage setParameter:@"plain_result" value:@"0"];
                [manage setParameter:@"asr_ptt" value:@"0"];


            }
        }
    }
    manage.delegate = sender;
    return manage;
}

/*
// 开始识别
- (void) onBegin:(id) sender
{
    [_iFlySpeechRecognizer startListening];
}
// 停止录音
- (void) onStop:(id) sender
{
    [_iFlySpeechRecognizer stopListening];
}
// 取消识别
- (void) onCancel:(id) sender
{
    [_iFlySpeechRecognizer cancel];
}
*/
 
#pragma -mark 合成部分
+(IFlySpeechSynthesizer *)getInstanceForSynthesizer:(id)sender{
    if (!manageTwo)
    {
        @synchronized(self)
        {
            if (!manageTwo)
            {
                //初始化参数
                NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID];
                manageTwo = [IFlySpeechSynthesizer createWithParams:initString delegate:[CTIFlyRecognizerManage getInstance]];
//                [initString release];
                //// 设置语音合成的参数
                // 设置语速
                [manageTwo setParameter:@"speed" value:@"50"];
                // 设置音量
                [manageTwo setParameter:@"volume" value:@"50"];
                //设置说话人
                [manageTwo setParameter:@"voice_name" value:@"xiaoyan"];
                [manageTwo setParameter:@"sample_rate" value:@"8000"];
                // 设置合成过程中是否有背景音乐
                [manageTwo setParameter:@"params" value:@"bgs=0"];
                
            }
        }
    }
//    manageTwo.delegate = sender;
    [CTIFlyRecognizerManage getInstance].delegateForSynthesizer =sender;
    return manageTwo;
}
+(IFlySpeechSynthesizer *)getInstanceForSynthesizer:(id)sender Content:(NSString *)iString{
    IFlySpeechSynthesizer *mode =[CTIFlyRecognizerManage getInstanceForSynthesizer:sender];
    [mode startSpeaking:iString];
    return mode;
}
+(void)speak:(NSString *)iString{
    IFlySpeechSynthesizer *mode =[CTIFlyRecognizerManage getInstanceForSynthesizer:nil];
    [mode startSpeaking:iString];
}

#pragma -mark 合成代理
/**
 * @fn      onSpeakBegin
 * @brief   开始播放
 *
 * @see
 */
- (void) onSpeakBegin{
    if ([delegateForSynthesizer respondsToSelector:@selector(onSpeakBegin)]) {
        [delegateForSynthesizer onSpeakBegin];
    }
}
/**
 * @fn      onBufferProgress
 * @brief   缓冲进度
 *
 * @param   progress            -[out] 缓冲进度
 * @see
 */
- (void) onBufferProgress:(int) progress{
    if ([delegateForSynthesizer respondsToSelector:@selector(onBufferProgress:)]) {
        [delegateForSynthesizer onBufferProgress:progress];
    }
}
/**
 * @fn      onSpeakProgress
 * @brief   播放进度
 *
 * @param   progress            -[out] 播放进度
 * @see
 */
- (void) onSpeakProgress:(int) progress{
    if ([delegateForSynthesizer respondsToSelector:@selector(onSpeakProgress:)]) {
        [delegateForSynthesizer onSpeakProgress:progress];
    }
}
/**
 * @fn      onSpeakPaused
 * @brief   暂停播放
 *
 * @see
 */
- (void) onSpeakPaused{
    if ([delegateForSynthesizer respondsToSelector:@selector(onSpeakPaused)]) {
        [delegateForSynthesizer onSpeakPaused];
    }
}
/**
 * @fn      onSpeakResumed
 * @brief   恢复播放
 *
 * @see
 */
- (void) onSpeakResumed{
    if ([delegateForSynthesizer respondsToSelector:@selector(onSpeakResumed)]) {
        [delegateForSynthesizer onSpeakResumed];
    }
}
/**
 * @fn      onCompleted
 * @brief   结束回调
 *
 * @param   error               -[out] 错误对象
 * @see
 */
- (void) onCompleted:(IFlySpeechError*) error{
    if ([delegateForSynthesizer respondsToSelector:@selector(onCompleted:)]) {
        [delegateForSynthesizer onCompleted:error];
    }
}
/**
 * @fn      onSpeakCancel
 * @brief   正在取消
 *
 * @see
 */
- (void) onSpeakCancel{
    if ([delegateForSynthesizer respondsToSelector:@selector(onSpeakCancel)]) {
        [delegateForSynthesizer onSpeakCancel];
    }
}

#pragma -mark 登陆回调
- (void) onEnd:(IFlySpeechUser *)iFlySpeechUser error:(IFlySpeechError *)error{

}
#pragma -mark 上传回调
//- (void) onEnd:(IFlyDataUploader*) uploader grammerID:(NSString *)grammerID error:(IFlySpeechError *)error{
//
//}
@end
