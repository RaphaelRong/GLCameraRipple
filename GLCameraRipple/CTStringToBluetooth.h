//
//  CTStringToBluetooth.h
//  AutoSpeech
//
//  Created by ge teng on 13-7-6.
//  Copyright (c) 2013年 geteng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTStringToBluetooth : NSObject{
    NSMutableArray* iDo;//动词组
    NSMutableArray* iSomeThing;//名字组
}
@property (nonatomic, retain) NSMutableArray* iDo;
@property (nonatomic, retain) NSMutableArray* iSomeThing;
//获取自己单例
+(CTStringToBluetooth *)getInstance;
+(NSData *)doChange:(NSString *)iString;
@end
