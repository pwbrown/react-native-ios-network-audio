//React Native Audio Player logic(no UI)

#import "RNAudioPlayerURL.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

@implementation RNAudioPlayerURL

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(initWithURL:(NSString *)url){
  NSURL *soundUrl = [[NSURL alloc] initWithString:url];
  self.audioItem = [AVPlayerItem playerItemWithURL:soundUrl];
  self.audioPlayer = [AVPlayer playerWithPlayerItem:self.audioItem];
  [[NSNotificationCenter defaultCenter]
  	addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.audioItem];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification{
	[self.audioItem seekToTime:kCMTimeZero];
	[self.bridge.eventDispatcher sendAppEventWithName:@"AudioEnded" body:@{@"event": @"finished"}];
}

RCT_EXPORT_METHOD(getDuration:(RCTResponseSenderBlock)callback){
  while(self.audioItem.status != AVPlayerItemStatusReadyToPlay){
  }  //this is kind of crude but it will prevent the app from crashing due to a "NAN" return(this allows the getDuration method to be executed in the componentDidMount function of the React class without the app crashing
  float duration = CMTimeGetSeconds(self.audioItem.duration);
  callback(@[[[NSNumber alloc] initWithFloat:duration]]);
}

RCT_EXPORT_METHOD(play){
  [self.audioPlayer play];
}

RCT_EXPORT_METHOD(pause){
  [self.audioPlayer pause];
}

RCT_EXPORT_METHOD(seekToTime:(nonnull NSNumber *)toTime){
	[self.audioPlayer seekToTime: CMTimeMakeWithSeconds([toTime floatValue], NSEC_PER_SEC)];
}

@end
