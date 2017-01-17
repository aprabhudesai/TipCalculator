//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Abhishek Prabhudesai on 1/11/17.
//  Copyright © 2017 Abhishek Prabhudesai. All rights reserved.
//

#import "SettingsViewController.h"
#import "Utilities.h"
#import "Currency.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *currencyTextField;
@property (weak, nonatomic) UIPickerView *currencyPicker;
@property (weak, nonatomic) IBOutlet UISwitch *customTipSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipPercentageSelector;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [Utilities initCurrencyDictionary];

  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSInteger currencySetting = [defaults integerForKey:@"currencyIndex"];
  
  if (currencySetting) {
    NSArray *currencyArray = [Utilities getCurrencyArray];
    Currency *currency = currencyArray[currencySetting];
    _currencyTextField.text = currency.title;
  }
  else {
    _currencyTextField.text = @"USD";
  }

  BOOL customTipSwitchEnabled = [defaults boolForKey:@"enableCustomTip"];
  [_customTipSwitch setOn:customTipSwitchEnabled];
  
  int defaultTipIndex = (int) [defaults integerForKey: @"defaultTipIndex"];
  [self.defaultTipPercentageSelector setSelectedSegmentIndex:defaultTipIndex];

  CGFloat ht = 200.0;
  UIPickerView *currencyPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - ht, [[UIScreen mainScreen] bounds].size.width, 200)];
  currencyPicker.backgroundColor = [UIColor whiteColor];
  currencyPicker.showsSelectionIndicator = YES;
  currencyPicker.delegate = self;
  currencyPicker.dataSource = self;
  
  _currencyPicker = currencyPicker;

  UIToolbar *toolBar = [[UIToolbar alloc] init];
  toolBar.barStyle = UIBarStyleDefault;
  toolBar.translucent = YES;
  [toolBar sizeToFit];
  
  UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target: self action: @selector(pickerDoneClicked:)];
  
  [toolBar setItems:@[doneButton] animated:NO];
  toolBar.userInteractionEnabled = YES;

  _currencyTextField.delegate = self;
  
  _currencyTextField.inputView = currencyPicker;
  _currencyTextField.inputAccessoryView = toolBar;
  self.title = @"Settings";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
  [self updateUserSettings];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return [Utilities getCurrencyArray].count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  NSArray *currencyArray = [Utilities getCurrencyArray];
  Currency *currency = currencyArray[row];
  _currencyTextField.text = currency.title;
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSInteger currencyIndex;
  if ([_currencyTextField.text isEqualToString:@""]) {
    currencyIndex = 0;
  }
  else {
    currencyIndex = row;
  }

  [defaults setInteger: currencyIndex forKey:@"currencyIndex"];
  [defaults synchronize];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  NSArray *currencyArray = [Utilities getCurrencyArray];
  Currency *currency = currencyArray[row];
  return currency.title;
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
  [self dismissView];
}

- (IBAction) pickerDoneClicked:(UIBarButtonItem *) sender {
  [_currencyPicker removeFromSuperview];
  [_currencyTextField resignFirstResponder];
}

- (void) dismissView {
  [[self navigationController] popViewControllerAnimated:YES];
}

- (void) updateUserSettings {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  BOOL enableCustomTip = [_customTipSwitch isOn];
  [defaults setBool:enableCustomTip forKey:@"enableCustomTip"];

  int defaultTipIndex = (int) self.defaultTipPercentageSelector.selectedSegmentIndex;
  [defaults setInteger:defaultTipIndex forKey:@"defaultTipIndex"];
  
  [defaults synchronize];
}

@end
