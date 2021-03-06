//
//  Currency.m
//  TipCalculator
//
//  Created by Abhishek Prabhudesai on 1/12/17.
//  Copyright © 2017 Abhishek Prabhudesai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency.h"

@implementation Currency

+ (id) initWithTitle:(NSString *)title andSymbol:(NSString *)symbol andLocale:(NSString *)localeString {
  Currency *currency = [[self alloc] init];
  [currency setTitle: title];
  [currency setSymbol: symbol];
  [currency setLocale: [NSLocale localeWithLocaleIdentifier: localeString]];
  
  return currency;
}

@end
