//
//  Text.m
//  AutoSpeech
//
//  Created by ge teng on 13-7-6.
//  Copyright (c) 2013年 geteng. All rights reserved.
//

#import "Text.h"
#import "CTIFlyRecognizerManage.h"
#import "CTStringToBluetooth.h"

@interface Text ()

@end

@implementation Text

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //语音对象单例模式
    _iFlyRecognizer = [CTIFlyRecognizerManage getInstanceForRecognizer:self];
    _iFlyRecognizer.delegate = (id)self;
    
    
    [CTIFlyRecognizerManage login];
    
    [self.theButton addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [self.theButton addTarget:self action:@selector(touchCancel) forControlEvents:UIControlEventTouchDragOutside|UIControlEventTouchUpOutside];
    
    
//    [CTIFlyRecognizerManage speak:@"我草你麻痹"];
}

#pragma -mark  接口方法
//[_iFlyRecognizer startListening];
//[_iFlyRecognizer stopListening];
//[_iFlyRecognizer cancel];

#pragma mark - 按钮按下事件
- (void)touchDown
{
//        [self performSelector:@selector(changeTimeState) withObject:nil afterDelay:1.0];
    [self performSelector:@selector(startListening) withObject:nil afterDelay:0.01];
}

#pragma mark - 启动讯飞开始录音
- (void)startListening
{
    [_iFlyRecognizer startListening];
//    [self performSelector:@selector(startRecgnize) withObject:nil afterDelay:10.0];
}

#pragma mark - 十秒后开始识别
- (void)startRecgnize
{
    [self touchCancel];
}

#pragma mark - 取消按钮点击事件
- (void)touchCancel
{
    [_iFlyRecognizer stopListening];
}




#pragma -mark 识别回调用
/**
 * @fn      onVolumeChanged
 * @brief   音量变化回调
 *
 * @param   volume      -[in] 录音的音量，音量范围1~100
 * @see
 */
- (void) onVolumeChanged: (int)volume{

}

/**
 * @fn      onBeginOfSpeech
 * @brief   开始识别回调
 *
 * @see
 */
- (void) onBeginOfSpeech{

}

/**
 * @fn      onEndOfSpeech
 * @brief   停止录音回调
 *
 * @see
 */
- (void) onEndOfSpeech{

}

/**
 * @fn      onError
 * @brief   识别结束回调
 *
 * @param   errorCode   -[out] 错误类，具体用法见IFlySpeechError
 */
- (void) onError:(IFlySpeechError *) errorCode{
        self.iText.text = @"onError";
}

/**
 * @fn      onResults
 * @brief   识别结果回调
 *
 * @param   result      -[out] 识别结果，NSArray的第一个元素为NSDictionary，NSDictionary的key为识别结果，value为置信度
 * @see
 */
- (void) onResults:(NSArray *) results{
    NSString * iString = @"";
    NSDictionary *dic = [results objectAtIndex:0];
    for (NSString *key in dic) {
        NSLog(@"hui fu d  neirong :%@",key);
        iString = key;
    }
    
    if (iString.length > 0) {
//        [CTIFlyRecognizerManage speak:iString];
        NSData * iData = [CTStringToBluetooth doChange:iString];
    }

    
}
// 取消识别回调
- (void) onCancel{
    self.iText.text = @"onCancel";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//- (void)dealloc {
//    [_theButton release];
//    [_iText release];
//    [super dealloc];
//}
@end
