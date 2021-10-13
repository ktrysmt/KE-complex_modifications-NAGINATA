#!/usr/bin/env ruby
#
# You can generate json by executing the following command on Terminal.
# $ ruby ./japanese_naginata.json.rb v > ../../docs/json/japanese_naginata.json
#
# Horizontal Version
# $ ruby ./japanese_naginata.json.rb h > ../../docs/json/japanese_naginata_h.json
#
# and put here.
# ~/.config/karabiner/assets/complex_modifications/
#
# This script made based example_japanese_nicola.json.rb.
#
#
#
# This software based on カナ配列「薙刀式」
# http://oookaworks.seesaa.net/article/456099128.html
#
# This Mac porting version hosted on https://github.com/sorshi/KE-complex_modifications-NAGINATA
# made by DCC-JPL Japan<http://www.dcc-jpl.com/>/Sorshi<sorshi@dcc-jpl.com>

require 'json'
require 'date'

require_relative '../lib/karabiner.rb'

########################################
# キーコード(親指シフトと違ってそのまんまだから意味ないな…)
# 横書き縦書きオプション
if ARGV[0] == 'h' then
  #横書きキーアサイン
  LEFT_ARROW = 'down_arrow'.freeze
  RIGHT_ARROW = 'up_arrow'.freeze
  UP_ARROW = 'left_arrow'.freeze
  DOWN_ARROW = 'right_arrow'.freeze
  MODE = 'Horizontal'.freeze
elsif ARGV[0] == 'v' then
  #デフォルト(縦書き)キーアサイン
  LEFT_ARROW = 'left_arrow'.freeze
  RIGHT_ARROW = 'right_arrow'.freeze
  UP_ARROW = 'up_arrow'.freeze
  DOWN_ARROW = 'down_arrow'.freeze
  MODE = 'Default(Vertical)'.freeze
else
  #デフォルト(縦書き)キーアサイン
  LEFT_ARROW = 'left_arrow'.freeze
  RIGHT_ARROW = 'right_arrow'.freeze
  UP_ARROW = 'up_arrow'.freeze
  DOWN_ARROW = 'down_arrow'.freeze
  MODE = 'Default(Vertical)'.freeze
end
# T/Yキーアサインオプション
if ARGV[1] == 'm' then
  #Mac版のみの拡張
  TKEY = 'え'.freeze
  YKEY = 'へ'.freeze
  TYKEYMODE = ' T/Y Key Exchange '.freeze
else
  #オリジナル
  TKEY = '選←'.freeze
  YKEY = '選→'.freeze
  TYKEYMODE = ' '.freeze
end

VK_NONE = 'vk_none'.freeze
ALWAYS_LEFT_ARROW = 'left_arrow'.freeze
ALWAYS_RIGHT_ARROW = 'right_arrow'.freeze
ALWAYS_UP_ARROW = 'up_arrow'.freeze
ALWAYS_DOWN_ARROW = 'down_arrow'.freeze
SPACEBAR = 'spacebar'.freeze
BACK_SPACE = 'delete_or_backspace'.freeze
ENTER = 'return_or_enter'.freeze
HYPHEN = 'hyphen'.freeze
COMMA = 'comma'.freeze
PERIOD = 'period'.freeze
SEMICOLON = 'semicolon'.freeze
COLON = 'quote'.freeze
SLASH = 'slash'.freeze
HOME = 'home'.freeze
ENDKEY = 'end'.freeze
LEFT_CORNER_BRACKET = 'open_bracket'.freeze #このへんJISで認識されてないキーボードだと変わる（US用に変えた
RIGHT_CORNER_BRACKET = 'close_bracket'.freeze #このへんJISで認識されてないキーボードだと変わる
YEN = 'international3'.freeze
PAGEUP = 'page_up'.freeze
PAGEDOWN = 'page_down'.freeze
ESC = 'escape'.freeze

JPN = 'lang1'.freeze
ENG = 'lang2'.freeze
########################################
# 有効になる条件

CONDITIONS = [
  Karabiner.input_source_if([
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.Hiragana',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.Katakana',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.HalfWidthKana',
    },
  ]),
  Karabiner.frontmost_application_unless(['loginwindow']),
].freeze

# 連続シフト用
CONDITIONS_SHIFT = [
  Karabiner.input_source_if([
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.Hiragana',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.Katakana',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.HalfWidthKana',
    },
  ]),
  Karabiner.frontmost_application_unless(['loginwindow']),
  {
    'type' =>'variable_if',
    'name' => 'shifted',
    'value' =>  1
  }
].freeze

########################################
# ローマ字入力の定義

def key(key_code)
  {
    'key_code' => key_code,
    'repeat' => false,
  }
end

def key_with_repeat(key_code)
  {
    'key_code' => key_code,
    'repeat' => true,
  }
end

def key_with_control(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_control',
    ],
    'repeat' => false,
  }
end

def key_with_control_shift(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_control',
      'left_shift'
    ],
    'repeat' => false,
  }
end

def key_with_shift(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_shift',
    ],
    'repeat' => false,
  }
end

def key_with_repeat_shift(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_shift',
    ],
    'repeat' => true,
  }
end

def key_with_option(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_alt',
    ],
    'repeat' => false,
  }
end

def key_with_option_shift(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_shift',
      'left_alt'
    ],
    'repeat' => false,
  }
end

def key_with_command(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_gui'
    ],
    'repeat' => false,
  }
end

def key_with_command_shift(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_shift',
      'left_gui'
    ],
    'repeat' => false,
  }
end

def start_unicodemode()
  {
      'select_input_source' => {
        'input_source_id' => 'com.apple.keylayout.UnicodeHexInput',
      }
  }
end

ROMAN_MAP = {
  '' => [key(VK_NONE)],
  'あ' => [key('a')],
  'い' => [key('i')],
  'う' => [key('u')],
  'え' => [key('e')],
  'お' => [key('o')],
  'か' => [key('k'), key('a')],
  'き' => [key('k'), key('i')],
  'く' => [key('k'), key('u')],
  'け' => [key('k'), key('e')],
  'こ' => [key('k'), key('o')],
  'さ' => [key('s'), key('a')],
  'し' => [key('s'), key('i')],
  'す' => [key('s'), key('u')],
  'せ' => [key('s'), key('e')],
  'そ' => [key('s'), key('o')],
  'た' => [key('t'), key('a')],
  'ち' => [key('t'), key('i')],
  'つ' => [key('t'), key('u')],
  'て' => [key('t'), key('e')],
  'と' => [key('t'), key('o')],
  'な' => [key('n'), key('a')],
  'に' => [key('n'), key('i')],
  'ぬ' => [key('n'), key('u')],
  'ね' => [key('n'), key('e')],
  'の' => [key('n'), key('o')],
  'は' => [key('h'), key('a')],
  'ひ' => [key('h'), key('i')],
  'ふ' => [key('h'), key('u')],
  'へ' => [key('h'), key('e')],
  'ほ' => [key('h'), key('o')],
  'ま' => [key('m'), key('a')],
  'み' => [key('m'), key('i')],
  'む' => [key('m'), key('u')],
  'め' => [key('m'), key('e')],
  'も' => [key('m'), key('o')],
  'や' => [key('y'), key('a')],
  'ゆ' => [key('y'), key('u')],
  'よ' => [key('y'), key('o')],
  'ら' => [key('r'), key('a')],
  'り' => [key('r'), key('i')],
  'る' => [key('r'), key('u')],
  'れ' => [key('r'), key('e')],
  'ろ' => [key('r'), key('o')],
  'わ' => [key('w'), key('a')],
  'を' => [key('w'), key('o')],
  'ん' => [key('n'), key('n')],
  'ゃ' => [key('x'), key('y'), key('a')],
  'ゅ' => [key('x'), key('y'), key('u')],
  'ょ' => [key('x'), key('y'), key('o')],
  'ぁ' => [key('x'), key('a')],
  'ぃ' => [key('x'), key('i')],
  'ぅ' => [key('x'), key('u')],
  'ぇ' => [key('x'), key('e')],
  'ぉ' => [key('x'), key('o')],
  'っ' => [key('x'), key('t'), key('u')],
  'ゎ' => [key('x'), key('w'), key('a')],
  'が' => [key('g'), key('a')],
  'ぎ' => [key('g'), key('i')],
  'ぐ' => [key('g'), key('u')],
  'げ' => [key('g'), key('e')],
  'ご' => [key('g'), key('o')],
  'ざ' => [key('z'), key('a')],
  'じ' => [key('z'), key('i')],
  'ず' => [key('z'), key('u')],
  'ぜ' => [key('z'), key('e')],
  'ぞ' => [key('z'), key('o')],
  'だ' => [key('d'), key('a')],
  'ぢ' => [key('d'), key('i')],
  'づ' => [key('d'), key('u')],
  'で' => [key('d'), key('e')],
  'ど' => [key('d'), key('o')],
  'ば' => [key('b'), key('a')],
  'び' => [key('b'), key('i')],
  'ぶ' => [key('b'), key('u')],
  'べ' => [key('b'), key('e')],
  'ぼ' => [key('b'), key('o')],
  'ぱ' => [key('p'),key('a')],
  'ぴ' => [key('p'),key('i')],
  'ぷ' => [key('p'),key('u')],
  'ぺ' => [key('p'),key('e')],
  'ぽ' => [key('p'),key('o')],
  'ヴ' => [key('v'), key('u')],
  'きゃ' => [key('k'), key('y'), key('a')],
  'きゅ' => [key('k'), key('y'), key('u')],
  'きょ' => [key('k'), key('y'), key('o')],
  'しゃ' => [key('s'), key('y'), key('a')],
  'しゅ' => [key('s'), key('y'), key('u')],
  'しょ' => [key('s'), key('y'), key('o')],
  'ちゃ' => [key('t'), key('y'), key('a')],
  'ちゅ' => [key('t'), key('y'), key('u')],
  'ちょ' => [key('t'), key('y'), key('o')],
  'にゃ' => [key('n'), key('y'), key('a')],
  'にゅ' => [key('n'), key('y'), key('u')],
  'にょ' => [key('n'), key('y'), key('o')],
  'ひゃ' => [key('h'), key('y'), key('a')],
  'ひゅ' => [key('h'), key('y'), key('u')],
  'ひょ' => [key('h'), key('y'), key('o')],
  'ぴゃ' => [key('p'), key('y'), key('a')],
  'ぴゅ' => [key('p'), key('y'), key('u')],
  'ぴょ' => [key('p'), key('y'), key('o')],
  'みゃ' => [key('m'), key('y'), key('a')],
  'みゅ' => [key('m'), key('y'), key('u')],
  'みょ' => [key('m'), key('y'), key('o')],
  'ぎゃ' => [key('g'), key('y'), key('a')],
  'ぎゅ' => [key('g'), key('y'), key('u')],
  'ぎょ' => [key('g'), key('y'), key('o')],
  'ぎぃ' => [key('g'), key('y'), key('i')],
  'ぎぇ' => [key('g'), key('y'), key('e')],
  'じゃ' => [key('z'), key('y'), key('a')],
  'じゅ' => [key('z'), key('y'), key('u')],
  'じょ' => [key('z'), key('y'), key('o')],
  'じぃ' => [key('j'), key('y'), key('i')],
  'じぇ' => [key('j'), key('y'), key('e')],
  'ぢゃ' => [key('d'), key('y'), key('a')],
  'ぢゅ' => [key('d'), key('y'), key('u')],
  'ぢょ' => [key('d'), key('y'), key('o')],
  'ぢぃ' => [key('d'), key('y'), key('i')],
  'ぢぇ' => [key('d'), key('y'), key('e')],
  'びゃ' => [key('b'), key('y'), key('a')],
  'びゅ' => [key('b'), key('y'), key('u')],
  'びょ' => [key('b'), key('y'), key('o')],
  'びぃ' => [key('b'), key('y'), key('i')],
  'びぇ' => [key('b'), key('y'), key('e')],
  'てぃ' => [key('t'), key('h'), key('i')],
  'てゅ' => [key('t'), key('h'), key('u')],
  'でぃ' => [key('d'), key('h'), key('i')],
  'でゅ' => [key('d'), key('h'), key('u')],
  'でゃ' => [key('d'), key('h'), key('a')],
  'でぇ' => [key('d'), key('h'), key('e')],
  'でょ' => [key('d'), key('h'), key('o')],
  'とぅ' => [key('t'), key('w'), key('u')],
  'どぅ' => [key('d'), key('w'), key('u')],
  'ヴぁ' => [key('v'), key('a')],
  'ヴぃ' => [key('v'), key('i')],
  'ヴぇ' => [key('v'), key('e')],
  'ヴぉ' => [key('v'), key('o')],
  'ヴゃ' => [key('v'), key('y'), key('a')],
  'ヴゅ' => [key('v'), key('y'), key('u')],
  'ヴょ' => [key('v'), key('y'), key('o')],
  'つぁ' => [key('t'), key('s'), key('a')],
  'つぃ' => [key('t'), key('s'), key('i')],
  'つぇ' => [key('t'), key('s'), key('e')],
  'つぉ' => [key('t'), key('s'), key('o')],
  'ふぁ' => [key('f'), key('a')],
  'ふぃ' => [key('f'), key('i')],
  'ふぇ' => [key('f'), key('e')],
  'ふぉ' => [key('f'), key('o')],
  'ふゅ' => [key('f'), key('y'), key('u')],
  'しぇ' => [key('s'), key('y'), key('e')],
  'ちぇ' => [key('t'), key('y'), key('e')],
  'いぇ' => [key('y'), key('e')],
  'うぁ' => [key('w'),key('h'),key('a')],
  'うぃ' => [key('w'),key('h'),key('i')],
  'うぇ' => [key('w'),key('h'),key('e')],
  'うぉ' => [key('w'),key('h'),key('o')],
  'りゃ' => [key('r'),key('y'),key('a')],
  'りぃ' => [key('r'),key('y'),key('i')],
  'りゅ' => [key('r'),key('y'),key('u')],
  'りぇ' => [key('r'),key('y'),key('e')],
  'りょ' => [key('r'),key('y'),key('o')],
  'くぁ' => [key('k'),key('u'),key('x'),key('a')],
  'くぃ' => [key('k'),key('u'),key('x'),key('i')],
  'くぇ' => [key('k'),key('u'),key('x'),key('e')],
  'くぉ' => [key('k'),key('u'),key('x'),key('o')],
  'くゎ' => [key('k'),key('u'),key('x'),key('w'),key('a')],
  'ぐぁ' => [key('g'),key('u'),key('x'),key('a')],
  'ぐぃ' => [key('g'),key('u'),key('x'),key('i')],
  'ぐぇ' => [key('g'),key('u'),key('x'),key('e')],
  'ぐぉ' => [key('g'),key('u'),key('x'),key('o')],
  'ぐゎ' => [key('g'),key('u'),key('x'),key('w'),key('a')],
  'ー' => [key(HYPHEN)],
  '、' => [key(COMMA)],
  '。' => [key(PERIOD)],
  '削' => [key_with_repeat(BACK_SPACE)],
  '→' => [key(RIGHT_ARROW)],
  '←' => [key(LEFT_ARROW)],
  '選→' => [key_with_repeat_shift(RIGHT_ARROW)],
  '選←' => [key_with_repeat_shift(LEFT_ARROW)],
  '改' => [key(ENTER)],
  '英' => [key(ENG)],
  '仮' => [key(JPN)],
  '。改' => [key(PERIOD),key(ENTER)],
  #編集モード1定義
  '文末' => [key_with_command(LEFT_ARROW)],
  '文頭' => [key_with_command(RIGHT_ARROW)],
  '十字目' => [key_with_control('a'),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW)],
  'リドゥ' => [key_with_command_shift('z')],
  '保存' => [key_with_command('s')],
  '頁下' => [key(PAGEDOWN)],
  '頁上' => [key(PAGEUP)],
  '二十字目' => [key_with_control('a'),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW)],
  'アンドゥ' => [key_with_command('z')],
  'カット' => [key_with_command('x')],
  'コピー' => [key_with_command('c')],
  'ペースト' => [key_with_command('v')],
  '三十字目' => [key_with_control('a'),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW)],

  '行頭' => [key_with_control('a')],
  '行末削除' => [key_with_control('k')], #カーソル位置から行末まで削除
  '再変換' => [key_with_control_shift('r')],
  '削除' => [key_with_control('d')],
  '入力撤回' => [key(ESC),key(ESC)],
  '確定エンド' => [key(ENTER),key_with_control('e')],
  '上矢印' => [key(UP_ARROW)],
  'シフト上矢印' => [key_with_shift(UP_ARROW)],
  '五上矢印' => [key(UP_ARROW),key(UP_ARROW),key(UP_ARROW),key(UP_ARROW),key(UP_ARROW)],
  'カタカナに' => [key_with_control('k')],
  '行末' => [key_with_control('e')],
  '下矢印' => [key(DOWN_ARROW)],
  'シフト下矢印' => [key_with_shift(DOWN_ARROW)],
  '五下矢印' => [key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW)],
  'ひらがなに' => [key_with_control('j')],

  #編集モード2定義
  '／改' => [key(SLASH),key(ENTER)],
  '：改' => [key(COLON),key(ENTER)],
  '・' => [key_with_option(SLASH)],
  '○改' => [start_unicodemode(),key_with_option('3'),key_with_option('0'),key_with_option('0'),key_with_option('7'),key(JPN)],
  '行頭空白改' => [key_with_control('a'),key(SPACEBAR),key(ENTER),key_with_control('e')],

  '【改' => [key_with_option('9'),key(ENTER)],
  '〈改' => [start_unicodemode(),key_with_option('3'),key_with_option('0'),key_with_option('0'),key_with_option('8'),key(JPN)],
  '！改' => [key_with_shift('1'),key(ENTER)],
  '？改' => [key_with_shift(SLASH),key(ENTER)],
  '行頭空白三改' => [key_with_control('a'),key(SPACEBAR),key(SPACEBAR),key(SPACEBAR),key(ENTER),key_with_control('e')],

  '】改' => [key_with_option('0'),key(ENTER)],
  '〉改' => [start_unicodemode(),key_with_option('3'),key_with_option('0'),key_with_option('0'),key_with_option('9'),key(JPN)],
  '……改' => [key_with_option(SEMICOLON),key_with_option(SEMICOLON),key(ENTER)],
  '──改' => [key_with_option_shift(HYPHEN),key_with_option_shift(HYPHEN),key(ENTER)],
  '三空白' => [key(SPACEBAR),key(SPACEBAR),key(SPACEBAR)],

  '」改改空' => [key(RIGHT_CORNER_BRACKET),key(ENTER),key(ENTER),key(SPACEBAR)],
  '行頭削除' => [key_with_command_shift(UP_ARROW),key_with_repeat(BACK_SPACE)], #カーソル位置から行頭まで削除
  '確定復行' => [key(JPN),key(JPN)],#再変換と同一
  '縦棒改' => [key_with_shift(YEN),key(ENTER)],
  'ルビ' => [key_with_shift(YEN),key(ENTER),key_with_control('e'),start_unicodemode(),key_with_option('3'),key_with_option('0'),key_with_option('0'),key_with_option('a'),key(JPN),start_unicodemode(),key_with_option('3'),key_with_option('0'),key_with_option('0'),key_with_option('b'),key(JPN),key(UP_ARROW)],
  '」改「' => [key(RIGHT_CORNER_BRACKET),key(ENTER),key(ENTER),key(LEFT_CORNER_BRACKET),key(ENTER)],
  '「改' => [key(LEFT_CORNER_BRACKET),key(ENTER),],
  '『改' => [key_with_shift(LEFT_CORNER_BRACKET),key(ENTER)],
  '《改' => [start_unicodemode(),key_with_option('3'),key_with_option('0'),key_with_option('0'),key_with_option('a'),key(JPN)],
  '（改' => [key_with_shift('9'),key(ENTER)],

  '」改改' => [key(RIGHT_CORNER_BRACKET),key(ENTER),key(ENTER)],
  '」改' => [key(RIGHT_CORNER_BRACKET),key(ENTER)],
  '』改' => [key_with_shift(RIGHT_CORNER_BRACKET),key(ENTER)],
  '》改' => [start_unicodemode(),key_with_option('3'),key_with_option('0'),key_with_option('0'),key_with_option('b'),key(JPN)],
  '）改' => [key_with_shift('0'),key(ENTER)],

}.freeze
########################################

def main
  now = Time.now.to_i
  puts JSON.pretty_generate(
    'title' => 'Japanese NAGINATA STYLE (v13)',
    'rules' => [
      {
        'description' => "Japanese NAGINATA STYLE (v13) #{MODE}#{TYKEYMODE}Build #{now} ",
        'manipulators' => [
          # 同時打鍵数の多いものから書く
          shiftkeydef(),#連続シフト用定義
          #編集モード1定義
          editmode_one_left('q','文末'),
          editmode_one_left('w','縦棒改'),
          editmode_one_left('e','でぃ'),
          editmode_one_left('r','保存'),
          editmode_one_left('t','・'),
          editmode_one_left('a','……改'),
          editmode_one_left('s','『改'),
          editmode_one_left('d','？改'),
          editmode_one_left('f','「改'),
          editmode_one_left('g','（改'),
          editmode_one_left('z','──改'),
          editmode_one_left('x','』改'),
          editmode_one_left('c','！改'),
          editmode_one_left('v','」改'),
          editmode_one_left('b','）改'),
          editmode_one_right('y','行頭'),
          editmode_one_right('u','行末削除'),
          editmode_one_right('i','再変換'),
          editmode_one_right('o','削除'),
          editmode_one_right('p','入力撤回'),
          editmode_one_right('h','確定エンド'),
          editmode_one_right('j','上矢印'),
          editmode_one_right('k','シフト上矢印'),
          editmode_one_right('l','五上矢印'),
          editmode_one_right(SEMICOLON,'カタカナに'),
          editmode_one_right('n','行末'),
          editmode_one_right('m','下矢印'),
          editmode_one_right(COMMA,'シフト下矢印'),
          editmode_one_right(PERIOD,'五下矢印'),
          editmode_one_right(SLASH,'ひらがなに'),
          #編集モード2定義
          editmode_two_left('q','／改'),
          editmode_two_left('w','：改'),
          editmode_two_left('e','・改'),
          #editmode_two_left('r','○改'),
          three_keys('m',COMMA,'r','○改'),
          editmode_two_left('t','行頭空白改'),
          editmode_two_left('a','【改'),
          editmode_two_left('s','〈改'),
          editmode_two_left('d','『改'),
          editmode_two_left('f','？改'),
          editmode_two_left('g','行頭空白三改'),
          editmode_two_left('z','】改'),
          editmode_two_left('x','〉改'),
          editmode_two_left('c','』改'),
          editmode_two_left('v','──改'),
          editmode_two_left('b','三空白'),
          editmode_two_right('y','行頭'),
          editmode_two_right('u','カット'),
          editmode_two_right('i','ペースト'),
          editmode_two_right('o','リドゥ'),
          editmode_two_right('p','アンドゥ'),
          three_keys('v','c','p','アンドゥ'),
          editmode_two_right('h','コピー'),
          editmode_two_right('j','「改'),
          editmode_two_right('k','『改'),
          # editmode_two_right('l','《改'),
          three_keys('v','c','l','《改'),
          editmode_two_right(SEMICOLON,'（改'),
          editmode_two_right('n','」改改'),
          editmode_two_right('m','」改'),
          editmode_two_right(COMMA,'』改'),
          # editmode_two_right(PERIOD,'》改'),
          three_keys('v','c',PERIOD,'》改'),
          editmode_two_right(SLASH,'）改'),
          # 3同時打鍵
          # シフト「りゅ」のみ「てゅ」に定義
          # three_keys(SPACEBAR, 'e','p','てゅ'),
          three_keys('w','j','h','ぎゃ'),
          three_keys('r','j','h','じゃ'),
          three_keys('g','j','h','ぢゃ'),
          three_keys('x','j','h','びゃ'),
          three_keys('w','j','p','ぎゅ'),
          three_keys('r','j','p','じゅ'),
          three_keys('g','j','p','ぢゅ'),
          three_keys('x','j','p','びゅ'),
          three_keys('w','j','i','ぎょ'),
          three_keys('r','j','i','じょ'),
          three_keys('g','j','i','ぢょ'),
          three_keys('x','j','i','びょ'),
          # じゅぎゅが打ちにくいので、例外的に半濁音キーでもオーケーとする
          three_keys('r','m','i','じょ'),
          three_keys('r','m','h','じゃ'),
          three_keys('r','m','p','じゅ'),
          three_keys('w','m','i','ぎょ'),
          three_keys('w','m','h','ぎゃ'),
          three_keys('w','m','p','ぎゅ'),
          three_keys('g','m','i','ぢょ'),
          three_keys('g','m','h','ぢゃ'),
          three_keys('g','m','p','ぢゅ'),
          three_keys('x','j','i','びょ'),
          three_keys('x','j','p','びゅ'),
          # 半濁音ゃゅょは「ぴ」のみ
          three_keys('x','m','i','ぴょ'),
          three_keys('x','m','h','ぴゃ'),
          three_keys('x','m','p','ぴゅ'),
          three_keys('e','j','p','でゅ'),
          three_keys('r','j','o','じぇ'),
          three_keys('g','j','o','ぢぇ'),
          three_keys('e','j','k','でぃ'),
          three_keys('d','j','l','どぅ'),
          # 外来音
          three_keys('v', SEMICOLON,'j','つぁ'),
          three_keys('v', SEMICOLON,'k','つぃ'),
          three_keys('v', SEMICOLON,'o','つぇ'),
          three_keys('v', SEMICOLON,'n','つぉ'),
          three_keys('f','l','o','ヴぇ'), # 出ない
          three_keys('f','l','j','ヴぁ'),
          three_keys('f','l','k','ヴぃ'),
          three_keys('f','l','n','ヴぉ'),
          three_keys('f','l','p','ヴゅ'),
          three_keys('m','e','k','てぃ'),
          three_keys('m','e','p','てゅ'),
          three_keys('m','d','l','とぅ'),
          three_keys('v','l','j','うぁ'),
          three_keys('v','l','k','うぃ'),
          three_keys('v','l','o','うぇ'),
          three_keys('v','l','n','うぉ'),
          three_keys('v',PERIOD,'j','ふぁ'),
          three_keys('v',PERIOD,'k','ふぃ'),
          three_keys('v',PERIOD,'o','ふぇ'), # 出ない
          three_keys('v',PERIOD,'n','ふぉ'),
          three_keys('v',PERIOD,'p','ふゅ'),
          three_keys('m','r','o','しぇ'),
          three_keys('m','g','o','ちぇ'),
          three_keys('v','h','j','くぁ'),
          three_keys('v','h','k','くぃ'),
          three_keys('v','h','o','くぇ'),
          three_keys('v','h','n','くぉ'),
          three_keys('v','h','l','くゎ'),
          three_keys('f','h','j','ぐぁ'),
          three_keys('f','h','k','ぐぃ'),
          three_keys('f','h','o','ぐぇ'),
          three_keys('f','h','n','ぐぉ'),
          three_keys('f','h','l','ぐゎ'),
          # ------------------------------
          # 小書き： シフト半濁音同時押し
          three_keys(SPACEBAR,'q','l','ゎ'),
          # 2同時打鍵
          # 小書き： シフト半濁音同時押し
          two_keys('q','j','ぁ'),
          two_keys('q','k','ぃ'),
          two_keys('q','l','ぅ'),
          two_keys('q','o','ぇ'),
          two_keys('q','n','ぉ'),
          two_keys('q','h','ゃ'),
          two_keys('q','p','ゅ'),
          two_keys('q','i','ょ'),
          # 右手濁点
          two_keys('l','f','ヴ'),
          two_keys('u','f','ざ'),
          two_keys('o','f','ず'),
          two_keys('p','f','べ'),
          two_keys('h','f','ぐ'),
          two_keys(SEMICOLON,'f','づ'),
          two_keys('n','f','だ'),
          two_keys(PERIOD,'f','ぶ'),
          # 左手濁点
          two_keys('w','j','ぎ'),
          two_keys('e','j','で'),
          two_keys('r','j','じ'),
          two_keys('z','j','ぼ'),
          two_keys('s','j','げ'),
          two_keys('d','j','ど'),
          two_keys('f','j','が'),
          two_keys('g','j','ぢ'),
          two_keys('a','j','ぜ'),
          two_keys('x','j','び'),
          two_keys('c','j','ば'),
          two_keys('v','j','ご'),
          two_keys('b','j','ぞ'),
          # 右手半濁音
          two_keys('p','v','ぺ'),
          two_keys(PERIOD,'v','ぷ'),
          # 左手半濁音
          two_keys('z','m','ぽ'),
          two_keys('x','m','ぴ'),
          two_keys('c','m','ぱ'),
          # 拗音シフト やゆよと同時押しで、ゃゅょが付く
          two_keys('w','h','きゃ'),
          two_keys('e','h','りゃ'),
          two_keys('r','h','しゃ'),
          two_keys('b','h','みゃ'),
          two_keys('d','h','にゃ'),
          two_keys('g','h','ちゃ'),
          two_keys('x','h','ひゃ'),
          two_keys('w','p','きゅ'),
          two_keys('e','p','りゅ'),
          two_keys('r','p','しゅ'),
          two_keys('b','p','みゅ'),
          two_keys('d','p','にゅ'),
          two_keys('g','p','ちゅ'),
          two_keys('x','p','ひゅ'),
          two_keys('w','i','きょ'),
          two_keys('e','i','りょ'),
          two_keys('r','i','しょ'),
          two_keys('d','i','にょ'),
          two_keys('g','i','ちょ'),
          two_keys('x','i','ひょ'),
          two_keys('b','i','みょ'),
          two_keys('b','h','みゃ'),
          two_keys('b','p','みゅ'),
          two_keys('r','i','しょ'),
          two_keys('r','h','しゃ'),
          two_keys('r','p','しゅ'),
          two_keys('w','i','きょ'),
          two_keys('w','h','きゃ'),
          two_keys('w','p','きゅ'),
          two_keys('d','i','にょ'),
          two_keys('d','h','にゃ'),
          two_keys('d','p','にゅ'),
          two_keys('g','i','ちょ'),
          two_keys('g','h','ちゃ'),
          two_keys('g','p','ちゅ'),
          two_keys('x','i','ひょ'),
          two_keys('x','h','ひゃ'),
          two_keys('x','p','ひゅ'),
          #特殊操作
          two_keys('v','m','改'),
          two_keys_always('h','j','仮'),#USモードでも効く定義
          two_keys('f','g','英'),
          # #Mac版のみの拡張
          # two_keys('y','f','べ'),
          # two_keys('y','v','ぺ'),
          # two_keys('q','t','ヴぇ'),
          # two_keys('l','t','うぇ'),
          # two_keys(PERIOD,'t','ふぇ'),
          # two_keys('r','t','しぇ'),
          # two_keys('g','t','ちぇ'),
          # ------------------------------
          # シフト(スペースキー)
          #shift_key('q', ''),
          shift_key('w', 'ぬ'),
          shift_key('e', 'り'),
          shift_key(COMMA, 'ね'),
          shift_key('u', 'さ'),
          shift_key('i', 'よ'),
          shift_key('o', 'え'),
          shift_key('r', 'む'),
          shift_key('b', 'み'),
          shift_key('d', 'に'),
          shift_key('f', 'ま'),
          shift_key('g', 'ち'),
          shift_key('l', 'わ'),
          shift_key('j', 'の'),
          shift_key('k', 'も'),
          shift_key(SEMICOLON, 'つ'),
          shift_key('h', 'や'),
          shift_key('a', 'せ'),
          #shift_key('z', ''),
          #shift_key('x', ''),
          shift_key('c', 'を'),
          shift_key('v', '、'),
          shift_key('s', 'め'),
          shift_key('n', 'お'),
          shift_key('m', '。改'),
          shift_key('p', 'ゆ'),
          shift_key(PERIOD, 'ふ'),
          shift_key('t', TKEY),
          shift_key('y', YKEY),
          #shift_key('/', ''),
          # ------------------------------
          # 連続シフトシフト(スペースキー)
          continuous_shift('q', ''),
          continuous_shift('w', 'ぬ'),
          continuous_shift('e', 'り'),
          continuous_shift(COMMA, 'ね'),
          continuous_shift('u', 'さ'),
          continuous_shift('i', 'よ'),
          continuous_shift('o', 'え'),
          continuous_shift('r', 'む'),
          continuous_shift('b', 'み'),
          continuous_shift('d', 'に'),
          continuous_shift('f', 'ま'),
          continuous_shift('g', 'ち'),
          continuous_shift('l', 'わ'),
          continuous_shift('j', 'の'),
          continuous_shift('k', 'も'),
          continuous_shift(SEMICOLON, 'つ'),
          continuous_shift('h', 'や'),
          continuous_shift('a', 'せ'),
          #continuous_shift('z', ''),
          #continuous_shift('x', ''),
          continuous_shift('c', 'を'),
          continuous_shift('v', '、'),
          continuous_shift('s', 'め'),
          continuous_shift('n', 'お'),
          continuous_shift('m', '。改'),
          continuous_shift('p', 'ゆ'),
          continuous_shift(PERIOD, 'ふ'),
          continuous_shift('t', TKEY),
          continuous_shift('y', YKEY),
          #continuous_shift('/', ''),
          # ------------------------------
          # シフトなし(単打)
          normal_key('q', ''),
          normal_key('w', 'き'),
          normal_key('e', 'て'),
          normal_key('r', 'し'),
          normal_key('t', '←'),
          normal_key('y', '→'),
          normal_key('u', '削'),
          normal_key('i', 'る'),
          normal_key('o', 'す'),
          normal_key('p', 'へ'),
          normal_key('z', 'ほ'),
          normal_key('s', 'け'),
          normal_key('d', 'と'),
          normal_key('f', 'か'),
          normal_key('g', 'っ'),
          normal_key('h', 'く'),
          normal_key('j', 'あ'),
          normal_key('k', 'い'),
          normal_key('l', 'う'),
          normal_key(SEMICOLON, 'ー'),
          normal_key('a', 'ろ'),
          normal_key('x', 'ひ'),
          normal_key('c', 'は'),
          normal_key('v', 'こ'),
          normal_key('b', 'そ'),
          normal_key('n', 'た'),
          normal_key('m', 'な'),
          normal_key(COMMA, 'ん'),
          normal_key(PERIOD, 'ら'),
          normal_key(SLASH, 'れ'),
          #PC用キーボード定義
          normal_key_always('international4','仮'),#PC用JISキーボードつないだときの定義 (変換)& USモードでも効く定義
          normal_key('international5','英'),#PC用JISキーボードつないだときの定義 (無変換)
        ],
      },
    ]
  )
end


def shiftkeydef()
  {
    'type' => 'basic',
    'from' => {
      'key_code' => SPACEBAR,
    },
    'to' => [
      'set_variable'=>
        {'name' => 'shifted','value' => 1}
    ],
    'to_if_alone' => [
      'key_code' => SPACEBAR
    ],
    'to_after_key_up' => [
      'set_variable'=>
        {'name' => 'shifted','value' => 0}
    ],
    'parameters': { 'basic.to_if_held_down_threshold_milliseconds': 800 },
    'to_if_held_down': [
      {
        'key_code': SPACEBAR,
        'repeat': true
      }
    ],
    'conditions' => CONDITIONS,
  }
end

def normal_key(key, char)
  {
    'type' => 'basic',
    'from' => {
      'key_code' => key,
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def normal_key_always(key, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        }
      ],
    },
    'to' => ROMAN_MAP[char],
  }
end

def continuous_shift(key, char)
  {
    'type' => 'basic',
    'from' => {
      'key_code' => key,
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS_SHIFT,
  }
end

def shift_key(key, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        },
        {
          'key_code' => SPACEBAR,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    #'set_variable': { 'name': 'shifted','value': 1 },
    'conditions' => CONDITIONS,
    'to_after_key_up': [
      {
        'set_variable': {
          'name': 'shifted',
          'value': 0
        }
      }
    ]
  }
end

def two_keys(key,key2, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        },
        {
          'key_code' => key2,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def two_keys_always(key,key2, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        },
        {
          'key_code' => key2,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
  }
end

def three_keys(key,key2,key3, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        },
        {
          'key_code' => key2,
        },
        {
          'key_code' => key3,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def four_keys(key,key2,key3,key4, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        },
        {
          'key_code' => key2,
        },
        {
          'key_code' => key3,
        },
        {
          'key_code' => key4,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def editmode_two_left(key,char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => 'm',
        },
        {
          'key_code' => COMMA,
        },
        {
          'key_code' => key,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def editmode_two_right(key,char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => 'v',
        },
        {
          'key_code' => 'c',
        },
        {
          'key_code' => key,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def editmode_one_left(key,char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => 'j',
        },
        {
          'key_code' => 'k',
        },
        {
          'key_code' => key,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def editmode_one_right(key,char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => 'd',
        },
        {
          'key_code' => 'f',
        },
        {
          'key_code' => key,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

main
