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
//  [[NSNotificationCenter defaultCenter]
//   addObserver:self
//   selector:@selector(volumeChanged:)
//   name:@"AVSystemController_SystemVolumeDidChangeNotification"
//   object:nil];
}

//- (void)volumeChanged:(NSNotification *)notification{
//  float volume = [[[notification userInfo] objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
//  [self.bridge.eventDispatcher sendAppEventWithName:@"currentVolume" body:@{@"volume": [[NSNumber alloc] initWithFloat:volume]}];
//}

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

@end
