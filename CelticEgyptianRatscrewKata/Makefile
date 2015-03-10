default: all
.SECONDEXPANSION:

all: CelticEgyptianRatscrewKata.so

CERK_SOURCE_DIRS=. GameSetup Game Tests SnapRules
CelticEgyptianRatscrewKata_SOURCES=$(foreach folder, $(CERK_SOURCE_DIRS),$(wildcard CelticEgyptianRatscrewKata/$(folder)/*.vala))



%.so %.vapi %.h: $$($$*_SOURCES)
	valac-0.24 $(foreach pkg, $($*_PACKAGES),--pkg $(pkg)) -X -I. --vapidir=. --library=$* -H $*.h $($*_SOURCES) -X -fpic -X -shared -g -o $*.so -X -w
