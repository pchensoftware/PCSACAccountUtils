//====================================================================================================
// Author: Peter Chen
// Created: 5/28/14
// Copyright 2014 Peter Chen
//====================================================================================================

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>

@interface ACAccountStore (PCSUtils)

+ (void)getTwitterAccountFromController:(UIViewController *)controller completion:(void(^)(ACAccount *account))completion;

@end
