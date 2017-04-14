//
//  RSAData.m
//  RsaDemo
//
//  Created by 苏苏咯 on 2017/4/14.
//  Copyright © 2017年 Rsa. All rights reserved.
//

#import "RSAData.h"

@implementation RSAData
#pragma mark 加密
+(NSString*)Rsaencode:(NSString *)str
{
    
    RSACode * Code = [RSACode sharedInstance];
    Code.mod = @"BA7BF7FE5100ECB6446F54E9B33ED3CAEBFCD002E50B8B41FCC91A1F6564F684D6A42B86CE015BE13355CE0C15500D73077E736657C2BE4E0D9E63875F30FF95C9A79D1E4213AE30B6667B1945540CCB6410A6B0981D891B9D58CF51C6A486AFBC124FC84559A6C22852CDC0CCC826EE06DF7BF386CC990FBA693E2E2376FBA5";
    
    Code.exp = (NSUInteger*)65537;
    
    return [Code encode:str];
    
}
+(NSString*)RsaDecode :(NSString *)str
{
    RSACode * Code = [RSACode sharedInstance];
    Code.mod = @"BA7BF7FE5100ECB6446F54E9B33ED3CAEBFCD002E50B8B41FCC91A1F6564F684D6A42B86CE015BE13355CE0C15500D73077E736657C2BE4E0D9E63875F30FF95C9A79D1E4213AE30B6667B1945540CCB6410A6B0981D891B9D58CF51C6A486AFBC124FC84559A6C22852CDC0CCC826EE06DF7BF386CC990FBA693E2E2376FBA5";
    
    Code.exp = (NSUInteger*)65537;
    
    
    return [Code decode:str];
}
@end
