//
//  Text.h
//  AutoSpeech
//
//  Created by ge teng on 13-7-6.
//  Copyright (c) 2013年 geteng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTIFlyRecognizerManage.h"

@interface Text : UIViewController<IFlySpeechRecognizerDelegate>{
    
    IFlySpeechRecognizer	*_iFlyRecognizer;//识别控件,recognizer
}
@property (retain, nonatomic) IBOutlet UIButton *theButton;
@property (retain, nonatomic) IBOutlet UILabel *iText;

@end
