```
*compact_tabline.vim*

Vim plugin to have all tabs visibles.

Example: with 10 openned tabs openned the worse way :
  - Tabs 1 and 2 contains buffer Makefile
  - Tabs 3 and 8 contains buffer doc/tags
  - Tabs 4 and 5 contains buffer README.md
  - Active Tab is number 5
  - Tabs 6 and 7 contains buffer doc/compact_line.txt
  - Tab 9 contains buffer compact_line.vim
  - Tab 10 contains buffer all.snippets and an unmamed
    buffer (buf number is 15) starting with '# Global' at 1st line


With standard tabline, this give:
| kefile | kefile | d/tags | + E.md | + E.md | + .txt | + .txt | d/tags | + .vim | 2 petsX |

With compact_tabline, this give (and you can set colors given filetypes):
| ¹ Makef | ² | ³ tags | ⁴ ⏵  |  READM▕▒ | ⁶ com_t | ⁷ | ⁸ | ⁹ com_t | ¹⁰all¦₁₅# G |

For more informations. See :help compact_tabline
```
