//
//  ViewController.m
//  TipCalculator
//
//  Created by Abhishek Prabhudesai on 1/11/17.
//  Copyright © 2017 Abhishek Prabhudesai. All rights reserved.
//

#import "TipViewController.h"
#import "Utilities.h"
#import "Currency.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *customTipLabel;
@property (weak, nonatomic) IBOutlet UITextField *customTipTextField;
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;

@end

@implementation TipViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  _customTipLabel.hidden = YES;
  _customTipTextField.hidden = YES;
  _percentageLabel.hidden = YES;

  [Utilities initCurrencyDictionary];
  self.title = @"Tip Calculator";
  [self updateValues];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
  [self.view endEditing:YES];
  
  if ([_billTextField.text isEqualToString:@""] && !_customTipTextField.hidden && ![_customTipTextField.text isEqualToString:@""]) {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Bill amount cannot be empty" preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action) {
      [alert dismissViewControllerAnimated:YES completion: nil];
    }];
    
    [alert addAction: ok];
    [self presentViewController:alert animated:YES completion:nil];
  }
  
  [self updateValues];
}

- (void) updateValues {
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSInteger currencySetting = [defaults integerForKey:@"currencyIndex"];
  BOOL enableCustomTip = [defaults boolForKey:@"enableCustomTip"];
  
  _customTipLabel.hidden = enableCustomTip ? NO : YES;
  _customTipTextField.hidden = enableCustomTip ? NO : YES;
  _percentageLabel.hidden = enableCustomTip ? NO : YES;
  _tipControl.hidden = enableCustomTip ? YES : NO;
  
  NSArray *currencyArray = [Utilities getCurrencyArray];
  Currency *selectedCurrency;
  if (currencySetting) {
    selectedCurrency = currencyArray[currencySetting];
  }
  else {
    selectedCurrency = currencyArray[0];
  }
  
  // Get the bill amount
  float billAmount = [self.billTextField.text floatValue];
  
  // Compute Tip & Total
  NSArray *tipValues = @[@0.15, @0.2, @0.25];
  
  float tip = 0.0;
  if (enableCustomTip) {
    if ([_customTipTextField.text isEqualToString:@""]) {
      tip = 0.0;
    }
    else {
      tip = [_customTipTextField.text floatValue] / 100;
    }
  }
  else {
    tip = [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
  }

  float tipAmount = tip * billAmount;
  float totalAmount = billAmount + tipAmount;
  
  // Update the UI
  self.tipLabel.text = [NSString stringWithFormat:@"%@ %0.2f", selectedCurrency.symbol, tipAmount];
  
  CATransition *totalAmountAnimation = [CATransition animation];
  totalAmountAnimation.duration = 1.0;
  totalAmountAnimation.type = kCATransitionFade;
  totalAmountAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  [self.totalLabel.layer addAnimation:totalAmountAnimation forKey:@"changeTextTransition"];
  
  self.totalLabel.text = [NSString stringWithFormat:@"%@ %0.2f", selectedCurrency.symbol, totalAmount];
}

- (IBAction)onValueChange:(UISegmentedControl *)sender {
  [self updateValues];
}

- (IBAction) unwindToHomeScreen:(UIStoryboardSegue *) segue {
  [self updateValues];
}

@end
