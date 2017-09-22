//
//  NSData+AES256.h
//  AES
//
//  Created by Henry Yu on 2009/06/03.
//  Copyright 2010 Sevensoft Technology Co., Ltd.(http://www.sevenuc.com)
//  All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>
@interface NSData (AES256)


/**
 *  AES加密方法
 *
 *  @param plain      加密的字串
 *  @param randomText 生成向量的随机数
 *
 *  @return 加密后的字串
 */
+ (NSString *)AES256EncryptWithPlainText:(NSString *)plain  randomText:(NSString *)randomText;



/**
 *  AES解密方法
 *
 *  @param ciphertexts 解密字串
 *  @param randomText  生成向量的随机数
 *
 *  @return 解密后的字串
 */
+ (NSString *)AES256DecryptWithCiphertext:(NSString *)ciphertexts  randomText:(NSString *)randomText;
@end
