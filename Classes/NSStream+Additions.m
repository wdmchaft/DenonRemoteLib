/*
 *  NSStream+Additions.m
 *  DenonTool
 *
 *  Created by Jeffrey Hutchison on 3/22/09.
 *  Copyright 2009 Jeff Hutchison. All rights reserved.
 *
 */
#import "NSStream+Additions.h"

@implementation NSStream (DRAdditions)

+ (void)getStreamsToHostNamed:(NSString *)hostName 
                         port:(NSInteger)port 
                  inputStream:(NSInputStream **)inputStreamPtr 
                 outputStream:(NSOutputStream **)outputStreamPtr{

  CFReadStreamRef     readStream;
  CFWriteStreamRef    writeStream;
  
  assert(hostName != nil);
  assert( (port > 0) && (port < 65536) );
  assert( (inputStreamPtr != NULL) || (outputStreamPtr != NULL) );
  
  readStream = NULL;
  writeStream = NULL;
  
  CFStreamCreatePairWithSocketToHost(
                                     NULL, 
                                     (CFStringRef) hostName, 
                                     port, 
                                     ((inputStreamPtr  != nil) ? &readStream : NULL),
                                     ((outputStreamPtr != nil) ? &writeStream : NULL)
                                     );
  
  if (inputStreamPtr != NULL) {
    *inputStreamPtr  = [NSMakeCollectable(readStream) autorelease];
  }
  if (outputStreamPtr != NULL) {
    *outputStreamPtr = [NSMakeCollectable(writeStream) autorelease];
  }
}

@end