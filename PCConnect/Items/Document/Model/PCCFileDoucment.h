//
//  PCCFileDoucment.h
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/25.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCCSocketCmd.h"

@interface PCCFileDoucment : NSObject <PCCSocketCmdDelegate>
@property (nonatomic, strong) NSMutableData             *muData;
- (void)postFileDescirbeCmd:(NSString *)cmd;

@end
