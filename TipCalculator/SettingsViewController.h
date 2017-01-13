//
//  SettingsViewController.h
//  TipCalculator
//
//  Created by Abhishek Prabhudesai on 1/11/17.
//  Copyright © 2017 Abhishek Prabhudesai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property NSString *currency;

@end
