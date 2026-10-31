@abstract
class_name TyperPreset extends RefCounted

var faces: SpriteFrames
var face_offset: Vector2
var talk_stream: AudioStream
var talk_speed: float
var talk_volume: float
var talk_freq: int
var font: Font

@abstract
func talk_pitch_calc() -> float
