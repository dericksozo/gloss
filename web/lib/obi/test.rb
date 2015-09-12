load 'nagoyaobi.rb'
require 'getoptlong'

show_param = Hash.new

DefaultModelName = 'T13'
ModelDir   = './'
RequiredFrequency = 0
KanjiCode = nil
OpCharDef = "#{ModelDir}/jchar.utf8"
Smoothing = nil
op_char = NagoyaObi.load_operative_character_file(OpCharDef)

model = NagoyaObi.load_model(DefaultModelName, ModelDir, RequiredFrequency)

file = [
  "最初、妙なクライアントが一人いるだけだと思った。そのクライアントは毎月十億単位のコールを処理し、「大量のデータストリーム」があると話した。"
]

#puts model.readability(file, KanjiCode, op_char, Smoothing).show([file], show_param)
#puts model.readability0(file, nil)

#puts model.readability0(NagoyaObi.load_text(IO, KanjiCode, op_char),
#                        Smoothing)
                        
puts model.readability(file, KanjiCode, op_char, smoothing=nil).grade