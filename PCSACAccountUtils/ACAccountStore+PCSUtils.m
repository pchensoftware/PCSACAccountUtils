//====================================================================================================
// Author: Peter Chen
// Created: 5/28/14
// Copyright 2014 Peter Chen
//====================================================================================================

#import "ACAccountStore+PCSUtils.h"
#import "DTActionSheet.h"

static ACAccount *_acAccountStore_PCSUtils_TwitterAccount = nil;

@implementation ACAccountStore (PCSUtils)

+ (void)getTwitterAccountFromController:(UIViewController *)controller completion:(void(^)(ACAccount *account))completion {
   if (_acAccountStore_PCSUtils_TwitterAccount) {
      if (completion)
         completion(_acAccountStore_PCSUtils_TwitterAccount);
      
      return;
   }
   
   ACAccountStore *store = [[ACAccountStore alloc] init];
   ACAccountType *accountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
   [store requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
      if (! granted) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Access Denied to Twitter Account" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
         
         if (completion)
            completion(nil);
         return;
      }
      
      dispatch_async(dispatch_get_main_queue(), ^{
         NSArray *accounts = [store accountsWithAccountType:accountType];
         if ([accounts count] == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Twitter Accounts On This Device" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
         }
         else if ([accounts count] == 1) {
            _acAccountStore_PCSUtils_TwitterAccount = [accounts firstObject];
            
            if (completion)
               completion(_acAccountStore_PCSUtils_TwitterAccount);
         }
         else {
            DTActionSheet *actions = [[DTActionSheet alloc] initWithTitle:@"Select Twitter account"];
            for (ACAccount *account in accounts) {
               [actions addButtonWithTitle:account.username block:^{
                  _acAccountStore_PCSUtils_TwitterAccount = account;
                  
                  if (completion)
                     completion(_acAccountStore_PCSUtils_TwitterAccount);
               }];
            }
            [actions addCancelButtonWithTitle:@"Cancel"];
            [actions showInView:controller.view];
         }
      });
   }];
}

@end
