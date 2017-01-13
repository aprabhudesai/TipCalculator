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
  Currency *USD = [Currency initWithTitle:@"USD" andSymbol:@"$"];
  Currency *INR = [Currency initWithTitle:@"INR" andSymbol:@"Rs"];
  Currency *EURO = [Currency initWithTitle:@"EURO" andSymbol:@"€"];
  Currency *YUAN = [Currency initWithTitle:@"YUAN" andSymbol:@"¥"];
  
  currencyArray = [[NSArray alloc] initWithObjects:USD, INR, EURO, YUAN, nil];
}

+ (NSArray *) getCurrencyArray {
  return currencyArray;
}

@end
