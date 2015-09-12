### Edit these lines ###
RubyLib  = /usr/lib/ruby/site_ruby
# RubyLib  = /usr/local/lib/ruby/site_ruby
BinDir   = /usr/local/bin
### End ################

Obi2Dir  = /usr/local/share/obi2

Library = nagoyaobi.rb
Bin     = obi2
Jchar   = jchar.utf8 jchar_without_katakana.utf8
Model   = Obi2-T13.model Obi2-T13U.model Obi2-T14.model 

install: install_lib install_bin install_model

install_lib: $(Library)
	install $(Library) $(RubyLib) 

install_bin: $(Bin)
	install $(Bin) $(BinDir) 

install_model: $(Model) $(Jchar)
	install -d $(Obi2Dir) && install $(Model) $(Jchar) $(Obi2Dir)

