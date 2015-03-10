//
//  CategoryRequestClass.m
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 21/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import "CategoryRequestClass.h"

@implementation CategoryRequestClass
@synthesize CategorySearchDelegate;

-(void)makeRequestForCheckingListOfCategories
{
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@",BaseURL,PathUrl,MedicineCategory];
    
    NSString *replaceUrlString= [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"replaceUrlString %@",replaceUrlString);
    NSURL *url = [NSURL URLWithString:replaceUrlString];
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
    
    [self.CategorySearchDelegate performSelectorOnMainThread:@selector(successJSONParsingCategorySearch:) withObject:parsedDictionary waitUntilDone:NO];
    
}


-(void)didparsingFailed{
    
    
    [self.CategorySearchDelegate performSelectorOnMainThread:@selector(failureJSONParsingCategorySearchResult) withObject:nil waitUntilDone:NO];
    
    //[self.signUPRequestDelegate performSelectorOnMainThread:@selector(failureJSONParsingResult:) withObject:nil waitUntilDone:NO];
    
}

@end
