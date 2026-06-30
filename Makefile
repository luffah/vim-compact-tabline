tags: docs
	nvim -u NONE -c "helptags doc/ | qa!"

docs:
	nvim -c "call genhelp#GenHelp('plugin/compact_tabline.vim') | qa!"

zip:
	mkdir compact_tabline; cp -r doc plugin README.md compact_tabline; zip -rm compact_tabline.zip compact_tabline
