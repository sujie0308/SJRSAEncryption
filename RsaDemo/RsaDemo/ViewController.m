//
//  ViewController.m
//  RsaDemo
//
//  Created by 苏苏咯 on 2017/4/14.
//  Copyright © 2017年 Rsa. All rights reserved.
//

#import "ViewController.h"
#import "RSAData.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //公钥加密
    NSString * en=[RSAData Rsaencode:@"300"];
    NSLog(@"%@",en);
    //公钥解密只是一个例子 解密  这个必须用私钥加密公钥才能解密 不懂的自行百度查下
    NSString * docode=[RSAData RsaDecode:en];
    NSLog(@"%@",docode);
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
