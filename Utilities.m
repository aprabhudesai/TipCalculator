//
//  Utilities.m
//  TipCalculator
//
//  Created by Abhishek Prabhudesai on 1/12/17.
//  Copyright © 2017 Abhishek Prabhudesai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utilities.h"
#import "Currency.h"

static NSArray *currencyArray;

@implementation Utilities 

+ (void) initCurrencyDictionary {
  Currency *USD = [Currency initWithTitle:@"USD" andSymbol:@"$" andLocale:@"en_US"];
  Currency *INR = [Currency initWithTitle:@"INR" andSymbol:@"Rs" andLocale:@"en_IN"];
  Currency *EURO = [Currency initWithTitle:@"EURO" andSymbol:@"€" andLocale:@"en"];
  Currency *YUAN = [Currency initWithTitle:@"YUAN" andSymbol:@"¥" andLocale:@"zh"];
  
  currencyArray = [[NSArray alloc] initWithObjects:USD, INR, EURO, YUAN, nil];
}

+ (NSArray *) getCurrencyArray {
  return currencyArray;
}

@end
