//
//  ServerCommunicator.m
//  PrizeKing
//
//  Created by Andres Abril on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServerCommunicator.h"

@implementation ServerCommunicator
@synthesize dictionary,tag,caller,resDic,methodName;
-(id)init {
    self = [super init];
    if (self) {
        tag = 0;
        caller = nil;
        webData = nil;
        theConnection = nil;
    }
    return self;
}
-(void)callServerWithMethod:(NSString*)method
               andParameter:(NSString*)parameter{
    FileSaver *file=[[FileSaver alloc]init];
    parameter=[parameter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *dateUTC=[self dateString];
    NSString *hash=[IAmCoder hash256:dateUTC];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://bogo-taxi.com/service?event=%@&%@&time=%@&hash=%@&os=ios&ciudad=%@",method,parameter,dateUTC,hash,[file getLastCity]]];
    methodName=method;
    NSLog(@"url %@",url);
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	//[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	//[theRequest setHTTPMethod:@"GET"];
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	dictionary = [[NSDictionary alloc]init];
	if(theConnection) {
		webData = [NSMutableData data];
	}
	else {
		NSLog(@"theConnection is NULL");
	}
}


//Implement the NSURL and XMLParser protocols
#pragma mark -
#pragma mark NSURLConnection methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	[webData setLength:0];
	NSLog(@"didReceiveresponse");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	[webData appendData:data];
	NSLog(@"didReceiveData");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	NSLog(@"didFailWithError");
    if ([caller respondsToSelector:@selector(receivedDataFromServerWithError:)]) {
        [caller performSelector:@selector(receivedDataFromServerWithError:) withObject:self];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    resDic=[NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSLog(@"Todos los datos recibidos %@",resDic);
    NSString *str=[[NSString alloc]initWithData:webData encoding:NSUTF8StringEncoding];
    NSLog(@"PlainString %@",str);
    
    if ([caller respondsToSelector:@selector(receivedDataFromServer:)]) {
        [caller performSelector:@selector(receivedDataFromServer:) withObject:self];
    }
}
-(NSString*)dateString{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd-HHmmss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [formatter setTimeZone:timeZone];
    NSDate *now = [[NSDate alloc] init];
    NSString *date=[formatter stringFromDate:now];
    NSDate *date2=[formatter dateFromString:date];
    NSTimeInterval seconds = [date2 timeIntervalSince1970];
    NSString *date3=[NSString stringWithFormat:@"%.0f",seconds];
    NSLog(@"segundos entre fechas %@",date3);
    return date3;
    
}

@end
