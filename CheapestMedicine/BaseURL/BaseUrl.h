//
//  BaseUrl.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 21/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BaseURL @"http://www.anshtech.org/"

#define PathUrl @"android_clinic_new/"

#define SearchByName @"name_search_with_relative.php?"

#define GenericNameSearch @"generic_name_search_with_relative.php?"

#define MedicineCategory @"category.php?"

#define MedicineDetails @"viewMedicine_Details.php?"

#define CategorySearch @"category_search.php?"

#define CurrenecyChange @"http://www.freecurrencyconverterapi.com/api/convert?q=INR-USD,INR-PHP,INR-EUR"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define ADMOB_KEY @"ca-app-pub-6469687600919926/1832606497"

@interface BaseUrl : NSObject

@end
