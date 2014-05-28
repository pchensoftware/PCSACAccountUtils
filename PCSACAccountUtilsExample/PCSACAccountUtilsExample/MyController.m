//====================================================================================================
// Author: Peter Chen
// Created: 5/28/14
// Copyright 2014 Peter Chen
//====================================================================================================

#import "MyController.h"
#import "ACAccountStore+PCSUtils.h"

@interface MyController()



@end

@implementation MyController

- (id)init {
   if ((self = [super init])) {
   }
   return self;
}

- (void)viewDidLoad {
   [super viewDidLoad];
   
   UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
   button.frame = CGRectMake(0, 100, 320, 44);
   [button setTitle:@"Hit Me" forState:UIControlStateNormal];
   [button addTarget:self action:@selector(_buttonTapped) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:button];
}

//====================================================================================================
#pragma mark - Events
//====================================================================================================

- (void)_buttonTapped {
   [ACAccountStore getTwitterAccountFromController:self completion:^(ACAccount *account) {
      [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Got account %@", account.username]
                                  message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
   }];
}

@end
