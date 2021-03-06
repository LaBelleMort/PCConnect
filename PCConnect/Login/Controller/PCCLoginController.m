//
//  PCCLoginController.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/10.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCLoginController.h"
#import <Masonry.h>
#import "PCCTextField.h"
#import "PCCSocketCmd.h"
#import "PCCSocketFile.h"
#import "UIAlertController+show.h"

@interface PCCLoginController ()<UITextFieldDelegate,PCCSocketCmdDelegate>

@property(nonatomic, strong) UIButton *logInButton; // 登陆
@property(nonatomic, strong) UIButton *noLogInButton; // 取消登陆

@end

@implementation PCCLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithRed:0.01f green:0.76f blue:0.71f alpha:1.00f];
    self.isOnLine = false;
    [self initUI];
}

- (void)initUI {
    
    UITextField *usernameTextField = [[PCCTextField alloc] init];
    usernameTextField.placeholder = @"账号";
    usernameTextField.textColor = [UIColor whiteColor];
    usernameTextField.delegate = self;
    [self.view addSubview:usernameTextField];
    // 设置 placeholder
    NSMutableAttributedString *placeholder=[[NSMutableAttributedString alloc] initWithString:usernameTextField.placeholder];
    
    [placeholder addAttribute:NSForegroundColorAttributeName
     
                        value:[UIColor whiteColor]
     
                        range:NSMakeRange(0, usernameTextField.placeholder.length)];
    
    [placeholder addAttribute:NSFontAttributeName
     
                        value:[UIFont boldSystemFontOfSize:18]
     
                        range:NSMakeRange(0, usernameTextField.placeholder.length)];
    
    usernameTextField.attributedPlaceholder = placeholder;
    
    UIView *longLineView = [[UIView  alloc] init];
    longLineView.backgroundColor = [UIColor whiteColor];
    longLineView.alpha = 0.7;
    [self.view addSubview:longLineView];
    
    UITextField *passwordTextField = [[PCCTextField alloc] init];
    passwordTextField.placeholder = @"密码";
    passwordTextField.textColor  = [UIColor whiteColor];
    passwordTextField.delegate = self;
    passwordTextField.secureTextEntry = YES;
    [self.view addSubview:passwordTextField];
    // 设置 placeholder
    NSMutableAttributedString *placeholder1=[[NSMutableAttributedString alloc] initWithString:passwordTextField.placeholder];
    
    [placeholder1 addAttribute:NSForegroundColorAttributeName
     
                         value:[UIColor whiteColor]
     
                         range:NSMakeRange(0, passwordTextField.placeholder.length)];
    
    [placeholder1 addAttribute:NSFontAttributeName
     
                         value:[UIFont boldSystemFontOfSize:18]
     
                         range:NSMakeRange(0, passwordTextField.placeholder.length)];
    
    passwordTextField.attributedPlaceholder = placeholder1;
    
    
    UIView *longLineView1 = [[UIView  alloc] init];
    longLineView1.backgroundColor = [UIColor whiteColor];
    longLineView1.alpha = 0.7;
    [self.view addSubview:longLineView1];
    
    UIButton *logInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logInButton.backgroundColor = [UIColor colorWithRed:1.00f green:0.60f blue:0.00f alpha:1.00f];
    [logInButton setTitle:@"登录" forState:UIControlStateNormal];
    logInButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:logInButton];
    
    UIButton *noLogInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    noLogInButton.backgroundColor = [UIColor colorWithRed:1.00f green:0.60f blue:0.00f alpha:1.00f];
    [noLogInButton setTitle:@"取消" forState:UIControlStateNormal];
    noLogInButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:noLogInButton];

    
    // 布局
    [usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(kScreenHeight * 0.35);
        make.left.equalTo(self.view.mas_left).with.offset(kScreenWidht * 0.1);
        make.width.mas_equalTo(kScreenWidht * 0.8);
        make.height.mas_equalTo(50 * kScreenRatio);
    }];
    
    [longLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(usernameTextField.mas_bottom);
        make.left.mas_equalTo(usernameTextField.mas_left);
        make.width.mas_equalTo(usernameTextField.mas_width);
        make.height.mas_equalTo(2 * kScreenRatio);
    }];
    
    
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(longLineView.mas_bottom).with.offset(kScreenRatio * 20);
        make.left.mas_equalTo(usernameTextField.mas_left);
        make.width.mas_equalTo(usernameTextField.mas_width);
        make.height.mas_equalTo(50 * kScreenRatio);
    }];
    
    [longLineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordTextField.mas_bottom);
        make.left.equalTo(usernameTextField.mas_left);
        make.width.mas_equalTo(usernameTextField.mas_width);
        make.height.mas_equalTo(2 * kScreenRatio);
    }];
    
    
    
    [logInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(longLineView1.mas_bottom).with.offset(50 * kScreenRatio);
        make.left.equalTo(usernameTextField.mas_left);
        make.width.mas_equalTo(kScreenWidht * 0.8);
        make.height.mas_equalTo(45 * kScreenRatio);
    }];
    
    [noLogInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logInButton.mas_bottom).with.offset(15 * kScreenRatio);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(kScreenWidht * 0.8);
        make.height.mas_equalTo(45 * kScreenRatio);
    }];
    
    
    [logInButton addTarget:self action:@selector(logIn) forControlEvents:(UIControlEventTouchUpInside)];
    [noLogInButton addTarget:self action:@selector(noLogIn) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.usernameTextField = usernameTextField;
    self.passwordTextField = passwordTextField;
    self.logInButton = logInButton;
    
    
}


#pragma mark --UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// 键盘消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

#pragma mark --登陆
- (void)logIn {
    
    if (![_usernameTextField.text isEqualToString:@""] && ![_passwordTextField.text isEqualToString:@""]) {
        
        [PCCSocketCmd shareInstance].username = self.usernameTextField.text;
        [PCCSocketCmd shareInstance].password = self.passwordTextField.text;
        [PCCSocketCmd shareInstance].socket.userData = SocketOfflineByUser;
        [[PCCSocketCmd shareInstance] cutOffCmdSocket];
        [PCCSocketCmd shareInstance].socket.userData = SocketOfflineByServer;
        [[PCCSocketCmd shareInstance] socketConnectHost];
        [PCCSocketCmd shareInstance].cmdDelegate = self;
//        
        
    }
    else {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }
}


- (void)noLogIn {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- SocketDelegate

- (void)getCmdDataMessage:(NSData *)data {
    int a;
    if (data.length <= 4) {
        int i;
        [data getBytes: &i length: sizeof(i)];
        a = CFSwapInt32BigToHost((uint32_t)i);
        return;
    } else {
        NSString *recStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"recStr--%@",recStr);
        if ([recStr isEqualToString:@"|CONNECTED@SUCCESS|_@@|END@FLAG|@@"]) {
            [PCCSocketCmd shareInstance].isOnline = YES;
            [self dismissViewControllerAnimated:YES completion:^{
                
                //                [PCCSocketModel shareInstance].isOnline = YES;
                
            }];
        } else {
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码不正确" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [[PCCSocketCmd shareInstance] cutOffCmdSocket];
            }];
            [alertVC addAction:cancelAction];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
