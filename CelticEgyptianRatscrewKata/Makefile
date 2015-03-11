default: all
.SECONDEXPANSION:

all: ConsoleBasedGam

CERK_SOURCE_DIRS=. GameSetup Game SnapRules
CelticEgyptianRatscrewKata_SOURCES=$(foreach folder, $(CERK_SOURCE_DIRS),$(wildcard CelticEgyptianRatscrewKata/$(folder)/*.vala))
CelticEgyptianRatscrewKata_PACKAGES=gee-0.8

CBG_SOURCE_DIRS=.
ConsoleBasedGame_SOURCES=$(foreach folder, $(CBG_SOURCE_DIRS),$(wildcard ConsoleBasedGame/$(folder)/*.vala))
ConsoleBasedGame_PACKAGES=gee-0.8 CelticEgyptianRatscrewKata

%.so %.vapi %.h: $$($$*_SOURCES)
	valac-0.24 $(foreach pkg, $($*_PACKAGES),--pkg $(pkg)) -X -I. --vapidir=. --library=$* -H $*.h $($*_SOURCES) -X -fpic -X -shared -g -o $*.so -X -w

ConsoleBasedGam: $(ConsoleBasedGame_SOURCES) CelticEgyptianRatscrewKata.so CelticEgyptianRatscrewKata.vapi
	valac-0.24 $(foreach pkg, $(ConsoleBasedGame_PACKAGES),--pkg $(pkg)) -X -I. --vapidir=. --library=$* -H $*.h $(ConsoleBasedGame_SOURCES) -g -o ConsoleBasedGam -X -w


clean:
	rm -f *.so *.h *.vapi ConsoleBasedGam
	rm -f $(patsubst %.vala,%.vala.c,$(SOURCES) $(CelticEgyptianRatscrewKata_SOURCES))
	rm -f $(patsubst %.vala,%.c,$(SOURCES) $(CelticEgyptianRatscrewKata_SOURCES))
