" Vim syntax file
" Language:     CSS Modules
" Maintainer:   Amadeus Demarzi, http://github.com/amadeus
" URL:          https://github.com/amadeus/vim-css

if !exists("main_syntax")
  let main_syntax = "css.module"
endif

if exists("b:current_syntax") && b:current_syntax == "css.module"
  finish
endif

syntax clear
syntax match  cssmVariable           /\<[_a-zA-Z$]\+[_a-zA-Z0-9-]*\>/ containedin=cssValueBlock,cssTransitionBlock

let b:embedded_rules = 1
runtime! syntax/css.vim
unlet b:embedded_rules

syntax region cssmImport matchgroup=cssmImportKeywords start=/import/ end=/from/ contains=cssmClass skipwhite skipempty nextgroup=cssString
syntax match cssmNoise /;/

syntax match  cssmAmpersand containedin=cssDefinitionBlock /&/ nextgroup=@cssSelectors,cssDefinitionBlock skipwhite skipempty

syntax match cssmComposes contained /composes/ skipwhite skipempty nextgroup=cssmComposesValue containedin=cssDefinitionBlock
syntax region cssmComposesValue contained matchgroup=cssComposesValueDelims start=/:/ end=/;/ contains=cssmClass
syntax match cssmComposesFrom /from/ contained skipwhite skipempty nextgroup=cssString

syntax match cssmClass contained /\k\+/ skipwhite skipempty nextgroup=cssmComposesFrom

syntax match cssmGlobal /:global/ skipwhite skipempty nextgroup=cssmGlobalArgs contains=cssmGlobalKeyword,cssmGlobalColon containedin=cssDefinitionBlock
syntax region cssmGlobalArgs contained matchgroup=cssmGlobalParens start=/(/ end=/)/  contains=cssClassSelector skipwhite skipempty nextgroup=cssDefinitionBlock
syntax match cssmGlobalKeyword contained /global/ contains=cssmGlobalColon
syntax match cssmGlobalColon contained /:/
syntax match  cssmComment "//.*" contains=@Spell containedin=cssDefinitionBlock

highlight default link cssmAmpersand    Special
highlight default link cssmComment Comment
highlight default link cssmImportKeywords Comment
highlight default link cssmComposesFrom Comment
highlight default link cssmClass cssClassSelector
highlight default link cssmNoise Noise
highlight default link cssmGlobalColon Noise
highlight default link cssmGlobalParens Noise
highlight default link cssComposesValueDelims Noise
highlight default link cssmComposes cssProp
highlight default link cssmGlobalKeyword cssProp

setlocal iskeyword+=$

let b:current_syntax = "css.module"
