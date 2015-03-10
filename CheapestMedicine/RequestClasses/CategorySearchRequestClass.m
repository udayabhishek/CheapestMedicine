//
//  CategorySearchRequestClass.m
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 24/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import "CategorySearchRequestClass.h"

@implementation CategorySearchRequestClass
@synthesize CategoryMedicineSearchDelegate;
-(void)makeRequestForCheckingWithCategoryMedicineSearchtxt:(NSString*)usertext Value:(NSString *)val{
    
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@txt=%@&val=%@",BaseURL,PathUrl,CategorySearch,usertext,val];
    
    NSString *replaceUrlString= [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSString *replaceStringgs=[replaceUrlString stringByReplacingOccurrencesOfString:@"`" withString:@"%60"];
    NSLog(@"replaceUrlString %@",replaceStringgs);
    NSURL *url = [NSURL URLWithString:replaceStringgs];
    NSLog(@"url %@",url);
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters:nil];
    
    NSLog(@"request %@",request);
    
    
    AFJSONRequestOperation *operation=[AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Success %@",JSON);
        
//        NSDictionary *dict=nil;
//        
//        dict=[JSON copy];
        
        [self didStartParsing:[JSON copy]];
        
        
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Failure");
        [self didparsingFailed];
        NSLog(@"Failure %@",JSON);
    }];
    
    [operation start];
    
    
}
-(void)didStartParsing:(NSDictionary *)dict
{
    
    NSLog(@"dict ==== %@",dict);
    NSLog(@"dict ==== %lu",(unsigned long)[dict count]);
    
    fetchedReponseArray=[[NSMutableArray alloc]init];
    
    if ([dict count]) {
        
        [self didfinishedParsing:[dict copy]];
        
    }
    else{
        [self didparsingFailed];
        
        
    }
}

-(void)didfinishedParsing:(NSMutableDictionary *)parsedDictionary{
    
    [self.CategoryMedicineSearchDelegate performSelectorOnMainThread:@selector(successJSONParsingCategoryMedicineSearch:) withObject:parsedDictionary waitUntilDone:NO];
    
}


-(void)didparsingFailed{
    
    
    [self.CategoryMedicineSearchDelegate performSelectorOnMainThread:@selector(failureJSONParsingCategoryMedicineSearchResult) withObject:nil waitUntilDone:NO];
    
    
    
}

@end
