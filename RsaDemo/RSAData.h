//
//  RSAData.h
//  RsaDemo
//
//  Created by 苏苏咯 on 2017/4/14.
//  Copyright © 2017年 Rsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSACode.h"
@interface RSAData : NSObject
#pragma mark 加密
+(NSString*)Rsaencode:(NSString *)str;
#pragma makr 解密
+(NSString*)RsaDecode :(NSString *)str;
@end
