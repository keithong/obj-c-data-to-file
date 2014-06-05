//
//  main.m
//  ImageFetch
//
//  Created by Keith Samson on 6/5/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        
        NSURL *url = [NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/2/22/Turkish_Van_Cat.jpg"];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSError *error = nil;
        NSData *data = [NSURLConnection
                        sendSynchronousRequest:request
                        returningResponse:NULL
                        error:&error];
        if(!data){
            NSLog(@"Fetch failed: %@", [error localizedDescription]);
            return 1;
        }
        
        NSLog(@"The file is %lu",[data length]);
        
        BOOL written = [data writeToFile:@"/tmp/cat.png"
                                 options:NSDataWritingAtomic
                                   error:&error];
        
        if(!written){
            NSLog(@"Write failed: %@", [error localizedDescription]);
            return 1;
        }
        NSLog(@"Success!");
        
        NSData *readData = [NSData dataWithContentsOfFile:@"/tmp/cat.png"];
        NSLog(@"The file read from the disk has %lu bytes", [readData length]);
    
    }
    return 0;
}

