@abstract
class_name TyperPreset extends RefCounted

var faces: SpriteFrames
var talk_stream: AudioStream
var font: Font

@abstract
func talk_pitch() -> float
