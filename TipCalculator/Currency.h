//
//  Currency.h
//  TipCalculator
//
//  Created by Abhishek Prabhudesai on 1/12/17.
//  Copyright © 2017 Abhishek Prabhudesai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject

@property NSString *title;
@property NSString *symbol;
@property NSLocale *locale;

+ (id) initWithTitle: (NSString *) title andSymbol: (NSString *) symbol andLocale: (NSString *) localeString;

@end
