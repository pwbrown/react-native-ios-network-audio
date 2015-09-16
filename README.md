# react-native-ios-network-audio

IOS class to add react-native implementation for web audio urls(look at AVPlayer documentation for audio compatibility). Tested using mp3 urls.

## Add it to your project
<ol>
	<li>Run '<a href="https://www.npmjs.com/package/react-native-ios-network-audio">npm install react-native-ios-network-audio --save</a>'</li>
	<li>Add .h and .m files to "Libraries" in Xcode and add these to your "build phases"</li>
	<li>var audio = require('react-native').NativeModules.RNAudioPlayerURL;</li>
</ol>

## Basic usage

```javascript
//To initialize the audio clip
audio.initWithURL("http://your_audio_url_here");

//To retrieve the length of the clip in seconds as a float
audio.getDuration((duration) => {
	//do what you need with duration variable
	//***Example
	var minutes = Math.floor(duration/60);
	var seconds = Math.ceil((duration/60 - minutes) * 60);
	this.setState({minutes: minutes, seconds: seconds, totalSeconds: duration});
});

//To play audio clip
audio.play();

//To pause audio clip
audio.pause();
```