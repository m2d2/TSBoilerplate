/*
 Copyright (c) 2012 Tim Sawtell
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
 IN THE SOFTWARE.
 */

#import "TwitterEngine.h"
#import "TwitterCommand.h"

@implementation TwitterEngine

- (void)getPublicTimelineForScreenName:(NSString *)screenName
                      includedEntities:(BOOL)includeEntities
                       includeRetweets:(BOOL)includeRetweets
                            tweetCount:(NSUInteger)tweetCount
                          onCompletion:(_serviceCompletionBlock)complete
{
    /*NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   screenName, kTwitterScreenName,
                                   [NSNumber numberWithBool:includeEntities], kIncludeEntities,
                                   [NSNumber numberWithBool:includeRetweets], kIncludeReTweets, 
                                   [NSNumber numberWithInteger: tweetCount], kTweetCount, nil];
    [self registerOperationSubclass:[MKNetworkOperation class]];
    
    MKNetworkOperation *op = [self operationWithURLString:kTwitterTimelineBaseURL
                                                   params:params
                                               httpMethod:@"GET"]; */
    
    //[self executeOperation:op withCompletion:complete];
    // the twitter API has changed AUTH options, and this app can't get stuff unless I hardcode some secret keys, which I don't want to do.
    // so, I get some JSON from a file, which is what the API used to give us before the auth model changed.
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fake_results" ofType:@"json"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        NSError *error;
        NSDictionary *timelineData =
        [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path]
                                        options:NSJSONReadingAllowFragments error:&error];
        complete(timelineData, error);
    }
}

@end
