//
//  RSACode.m
//  contact
//
//  Created by susulo on 16/4/21.
//  Copyright © 2016年 susulo. All rights reserved.
//

#import "RSACode.h"

#import "GTMBase64.h"
#include <openssl/rsa.h>
#include <openssl/pem.h>

#import "OXSingleton.h"
    
#define PUBLIC_EXPONENT 65537
#define DEFAULT_PUBLIC_KEYEX @"9B0C00E705AA322EB8A02371B4F971BABA52E36D0B76B03D42D1A1E6602291E9A081D5CE020EBE6C340981221BC32C72AB942F52E2CDAEDAA3D427D3D911C354587051B4F45BB7016C82799032608B6F1425B1C8BCB4BAD8D34E402DC76E130442ADEF691B4962EC03CF548E9722BB569B57C3DF6474EA7C2E480BEF8C9D5925"

@interface RSACode ()


@end


@implementation RSACode


OXSingletonM()
/**
 *  @author nick, 15-01-15 16:01:51
 *
 *  @brief  根据服务端提供模mod和指数exp，获取RSA公钥
 *  @param mod 十六进制模长
 *  @param exp 十六进制公钥指数
 *  @return 公钥
 */
- (RSA *)generatePublicKey{
    
    RSA * pubkey = RSA_new();
    
    BIGNUM * bnmod = BN_new();
    BIGNUM * bnexp = BN_new();
    
    BN_hex2bn(&bnmod, (const char *) [self.mod UTF8String]);
    BN_set_word(bnexp,(int) self.exp);
    
    pubkey->n = bnmod;
    pubkey->e = bnexp;
    return pubkey;

    
}


+ (int)getBlockSize:(RSA *)rsa PaddingType:(NSInteger)paddingType{
    
    int len = RSA_size(rsa);
    
    if (paddingType == RSA_PKCS1_PADDING || paddingType == RSA_SSLV23_PADDING) {
        //len -= 11;
    }
    
    return len;
}

/**
 *  @author nick, 15-01-15 15:01:38
 *
 *  @brief  根据服务端提供的十六进制模mod和指数exp
 *   ,获取strRSA经RSA加密后的十六进制字符串
 *  @param rawString 原文
 *  @return RSA加密后的密文
 */
- (NSString *)encode:(NSString *)rawString{
    
    
    RSA * pubkey = [self generatePublicKey];
    
    int nLen = [self.class getBlockSize:pubkey PaddingType:RSA_PKCS1_PADDING];
    char *crip = (char *)malloc(sizeof(char*) * nLen);
    
    //RSA_print_fp(stdout,pubkey,10);
    //使用公钥对data进行加密
    int nLen1 = RSA_public_encrypt((int)strlen((const char *)[rawString UTF8String]), (const unsigned char *)[rawString UTF8String], (unsigned char *) crip, pubkey, RSA_PKCS1_PADDING );
    //NSLog(@"len size : %d",nLen1);
    if (nLen1 <= 0)
    {
        NSLog(@"erro encrypt");
    }else{
        NSLog(@"SUC encrypt");
        
    }
    
    NSData *resData = [NSData dataWithBytes:crip length:nLen];
    
    free(crip);
    RSA_free(pubkey);
    return [GTMBase64 stringByEncodingData:resData];
    //  return [self hex:resData useLower:NO];
}

- (NSString *)decode:(NSString *)rawString{
    
    RSA * pubkey = [self generatePublicKey];
    
    int nLen = [self.class getBlockSize:pubkey PaddingType:RSA_PKCS1_PADDING];
    char *crip = (char *)malloc(sizeof(char*) * nLen);
    
    NSData *data = [GTMBase64 decodeString:rawString];
    
    //RSA_print_fp(stdout,pubkey,10);
    
    int nLen1 = RSA_public_decrypt((int)data.length, [data bytes], (unsigned char *) crip, pubkey, RSA_PKCS1_PADDING );
    //NSLog(@"len size : %d",nLen1);
    if (nLen1 <= 0)
    {
        NSLog(@"erro encrypt");
    }else{
        NSLog(@"SUC encrypt");
    }
    
    NSString *result = @"";
    if (nLen1 > 0){
        result = [[NSString alloc] initWithBytes:crip length:nLen1 encoding:NSUTF8StringEncoding];
    }
    
    free(crip);
    RSA_free(pubkey);
    
    return result;
}


+ (NSString *)hexStringFromData:(NSData *)data{
    NSData *myD = data;
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

+ (NSString *)hex: (NSData *)data useLower :(bool)isOutputLower
{
    static const char HexEncodeCharsLower[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
    static const char HexEncodeChars[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
    char *resultData;
    // malloc result data
    resultData = malloc([data length] * 2 +1);
    // convert imgData(NSData) to char[]
    unsigned char *sourceData = ((unsigned char *)[data bytes]);
    uint length = (int)[data length];
    
    if (isOutputLower) {
        for (uint index = 0; index < length; index++) {
            // set result data
            resultData[index * 2] = HexEncodeCharsLower[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeCharsLower[(sourceData[index] % 0x10)];
        }
    }
    else {
        for (uint index = 0; index < length; index++) {
            // set result data
            resultData[index * 2] = HexEncodeChars[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeChars[(sourceData[index] % 0x10)];
        }
    }
    resultData[[data length] * 2] = 0;
    
    // convert result(char[]) to NSString
    NSString *result = [NSString stringWithCString:resultData encoding:NSASCIIStringEncoding];
    sourceData = nil;
    free(resultData);
    
    return result;
}



@end
