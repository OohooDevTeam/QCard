//
//  audioControl.h
//  iPhoneCMU
//
//  Created by Rajeevan on 07/03/2010.
//  Copyright 2010 Rajeevan. All rights reserved. Inspired by TrailsintheSand.com 2008
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioQueue.h>
#import <AudioToolbox/AudioFile.h>

#define NUM_BUFFERS 3
#define SECONDS_TO_RECORD 10

typedef struct
{
    AudioStreamBasicDescription  dataFormat;
    AudioQueueRef                queue;
    AudioQueueBufferRef          buffers[NUM_BUFFERS];
    AudioFileID                  audioFile;
    SInt64                       currentPacket;
    bool                         recording;    
} RecordState;

typedef struct
{
    AudioStreamBasicDescription  dataFormat;
    AudioQueueRef                queue;
    AudioQueueBufferRef          buffers[NUM_BUFFERS];
    AudioFileID                  audioFile;
    SInt64                       currentPacket;
    bool                         playing;
} PlayState;



@interface audioControl : NSObject {
	RecordState recordState;
    PlayState playState;
    CFURLRef fileURL;
	NSString *statusMSG;
}
- (void)startRecording;
- (void)stopRecording;
- (void)startPlayback;
- (void)stopPlayback;
- (BOOL)isRecording;
- (BOOL)isPlaying;
- (BOOL)getFilename:(char*)buffer maxLenth:(int)maxBufferLength;
- (void)setupAudioFormat:(AudioStreamBasicDescription*)format;
- (NSString*) getStatus;

@end
