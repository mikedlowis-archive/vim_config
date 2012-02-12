" Vim syntax file
" Language:	   Clojure
" Last Change: 2008-05-14
" Maintainer:  Toralf Wittner <toralf.wittner@gmail.com>

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

syn match cljError "]\|}\|)"

syn keyword cljConstant    nil true false

syn keyword cljConditional if cond condp case
syn keyword cljConditional if-not if-let when when-not when-let when-first

syn keyword cljException   try catch finally throw

syn keyword cljRepeat      recur map mapcat reduce filter for doseq dorun 
syn keyword cljRepeat      doall dotimes map-indexed keep keep-indexed

syn keyword cljSpecial     . def do fn if let new quote var loop

syn keyword cljVariable    *warn-on-reflection* this *assert* 
syn keyword cljVariable    *agent* *ns* *in* *out* *err* *command-line-args* 
syn keyword cljVariable    *print-meta* *print-readably* *print-length* 
syn keyword cljVariable    *allow-unresolved-args* *compile-files* 
syn keyword cljVariable    *compile-path* *file* *flush-on-newline* 
syn keyword cljVariable    *math-context* *unchecked-math* *print-dup* 
syn keyword cljVariable    *print-level* *use-context-classloader* 
syn keyword cljVariable    *source-path* *clojure-version* *read-eval* 
syn keyword cljVariable    *1 *2 *3 *e

syn keyword cljDefine      def- defn defn- defmacro defmulti defmethod 
syn keyword cljDefine      defstruct defonce declare definline definterface 
syn keyword cljDefine      defprotocol defrecord deftype

syn keyword cljMacro       and or -> assert with-out-str with-in-str with-open 
syn keyword cljMacro       locking destructure ns dosync binding delay 
syn keyword cljMacro       lazy-cons lazy-cat time assert doc with-precision 
syn keyword cljMacro       with-local-vars .. doto memfn proxy amap areduce 
syn keyword cljMacro       refer-clojure future lazy-seq letfn 
syn keyword cljMacro       with-loading-context bound-fn extend extend-protocol 
syn keyword cljMacro       extend-type reify with-bindings ->>

syn keyword cljFunc        = not= not nil? false? true? complement identical? 
syn keyword cljFunc        string? symbol? map? seq? vector? keyword? var? 
syn keyword cljFunc        special-symbol? apply partial comp constantly 
syn keyword cljFunc        identity comparator fn? re-matcher re-find re-matches 
syn keyword cljFunc        re-groups re-seq re-pattern str pr prn print 
syn keyword cljFunc        println pr-str prn-str print-str println-str newline 
syn keyword cljFunc        macroexpand macroexpand-1 monitor-enter monitor-exit 
syn keyword cljFunc        eval find-doc file-seq flush hash load load-file 
syn keyword cljFunc        print-doc read read-line scan slurp subs sync test 
syn keyword cljFunc        format printf loaded-libs use require load-reader 
syn keyword cljFunc        load-string + - * / < <= == >= > dec inc min max neg? 
syn keyword cljFunc        pos? quot rem zero? rand rand-int decimal? even? odd? 
syn keyword cljFunc        float? integer? number? ratio? rational? 
syn keyword cljFunc        bit-and bit-or bit-xor bit-not bit-shift-left 
syn keyword cljFunc        bit-shift-right symbol keyword gensym count conj seq 
syn keyword cljFunc        first rest ffirst fnext nfirst nnext second every? 
syn keyword cljFunc        not-every? some not-any? concat reverse cycle 
syn keyword cljFunc        interleave interpose split-at split-with take 
syn keyword cljFunc        take-nth take-while drop drop-while repeat replicate 
syn keyword cljFunc        iterate range into distinct sort sort-by zipmap 
syn keyword cljFunc        line-seq butlast last nth nthnext next 
syn keyword cljFunc        repeatedly tree-seq enumeration-seq iterator-seq 
syn keyword cljFunc        coll? associative? empty? list? reversible? 
syn keyword cljFunc        sequential? sorted? list list* cons peek pop vec 
syn keyword cljFunc        vector peek pop rseq subvec array-map hash-map 
syn keyword cljFunc        sorted-map sorted-map-by assoc assoc-in dissoc get 
syn keyword cljFunc        get-in contains? find select-keys update-in key val 
syn keyword cljFunc        keys vals merge merge-with max-key min-key 
syn keyword cljFunc        create-struct struct-map struct accessor 
syn keyword cljFunc        remove-method meta with-meta in-ns refer create-ns 
syn keyword cljFunc        find-ns all-ns remove-ns import ns-name ns-map 
syn keyword cljFunc        ns-interns ns-publics ns-imports ns-refers ns-resolve 
syn keyword cljFunc        resolve ns-unmap name namespace require use 
syn keyword cljFunc        set! find-var var-get var-set ref deref 
syn keyword cljFunc        ensure alter ref-set commute agent send send-off 
syn keyword cljFunc        agent-errors clear-agent-errors await await-for 
syn keyword cljFunc        instance? bean alength aget aset aset-boolean 
syn keyword cljFunc        aset-byte aset-char aset-double aset-float 
syn keyword cljFunc        aset-int aset-long aset-short make-array 
syn keyword cljFunc        to-array to-array-2d into-array int long float 
syn keyword cljFunc        double char boolean short byte parse add-classpath 
syn keyword cljFunc        cast class get-proxy-class proxy-mappings 
syn keyword cljFunc        update-proxy hash-set sorted-set set disj set? 
syn keyword cljFunc        aclone add-watch alias alter-var-root 
syn keyword cljFunc        ancestors await1 bases bigdec bigint bit-and-not 
syn keyword cljFunc        bit-clear bit-flip bit-set bit-test counted?
syn keyword cljFunc        char-escape-string char-name-string class? 
syn keyword cljFunc        compare compile construct-proxy delay? 
syn keyword cljFunc        derive descendants distinct? double-array 
syn keyword cljFunc        doubles drop-last empty float-array floats 
syn keyword cljFunc        force gen-class get-validator int-array ints 
syn keyword cljFunc        isa? long-array longs make-hierarchy method-sig 
syn keyword cljFunc        not-empty ns-aliases ns-unalias num partition 
syn keyword cljFunc        parents pmap prefer-method primitives-classnames 
syn keyword cljFunc        print-ctor print-dup print-method print-simple 
syn keyword cljFunc        print-special-doc proxy-call-with-super 
syn keyword cljFunc        proxy-super rationalize read-string remove 
syn keyword cljFunc        remove-watch replace resultset-seq rsubseq 
syn keyword cljFunc        seque set-validator! shutdown-agents subseq 
syn keyword cljFunc        special-form-anchor syntax-symbol-anchor supers 
syn keyword cljFunc        unchecked-add unchecked-dec unchecked-divide 
syn keyword cljFunc        unchecked-inc unchecked-multiply unchecked-negate 
syn keyword cljFunc        unchecked-subtract underive xml-seq trampoline 
syn keyword cljFunc        atom compare-and-set! ifn? gen-interface 
syn keyword cljFunc        intern init-proxy io! memoize proxy-name swap! 
syn keyword cljFunc        release-pending-sends the-ns unquote while 
syn keyword cljFunc        unchecked-remainder alter-meta! 
syn keyword cljFunc        future-call methods mod pcalls prefers pvalues 
syn keyword cljFunc        print-namespace-doc reset! 
syn keyword cljFunc        reset-meta! type vary-meta unquote-splicing 
syn keyword cljFunc        sequence clojure-version counted? 
syn keyword cljFunc        chunk-buffer chunk-append chunk chunk-first 
syn keyword cljFunc        chunk-rest chunk-next chunk-cons chunked-seq? 
syn keyword cljFunc        deliver future? future-done? future-cancel 
syn keyword cljFunc        future-cancelled? get-method promise 
syn keyword cljFunc        ref-history-count ref-min-history ref-max-history 
syn keyword cljFunc        agent-error assoc!  boolean-array booleans bound-fn* 
syn keyword cljFunc        bound?  byte-array bytes char-array char? chars 
syn keyword cljFunc        conj!  denominator disj!  dissoc!  error-handler 
syn keyword cljFunc        error-mode extenders extends?  find-protocol-impl 
syn keyword cljFunc        find-protocol-method flatten frequencies 
syn keyword cljFunc        get-thread-bindings group-by hash-combine juxt 
syn keyword cljFunc        munge namespace-munge numerator object-array 
syn keyword cljFunc        partition-all partition-by persistent! pop! 
syn keyword cljFunc        pop-thread-bindings push-thread-bindings rand-nth 
syn keyword cljFunc        reductions remove-all-methods restart-agent 
syn keyword cljFunc        satisfies?  set-error-handler!  set-error-mode! 
syn keyword cljFunc        short-array shorts shuffle sorted-set-by take-last 
syn keyword cljFunc        thread-bound? transient vector-of with-bindings* fnil 
syn keyword cljFunc        spit

syn cluster cljAtomCluster   contains=cljError,cljFunc,cljMacro,cljConditional,cljDefine,cljRepeat,cljException,cljConstant,cljVariable,cljSpecial,cljKeyword,cljString,cljCharacter,cljNumber,cljBoolean,cljQuote,cljUnquote,cljDispatch,cljPattern
syn cluster cljTopCluster    contains=@cljAtomCluster,cljComment,cljSexp,cljAnonFn,cljVector,cljMap,cljSet

syn keyword cljTodo contained FIXME XXX TODO FIXME: XXX: TODO:
syn match   cljComment contains=cljTodo ";.*$"

syn match   cljKeyword "\c:\{1,2}[a-z?!\-_+*./=<>#$][a-z0-9?!\-_+*\./=<>#$]*"

syn region  cljString start=/L\="/ skip=/\\\\\|\\"/ end=/"/

syn match   cljCharacter "\\."
syn match   cljCharacter "\\[0-7]\{3\}"
syn match   cljCharacter "\\u[0-9]\{4\}"
syn match   cljCharacter "\\space"
syn match   cljCharacter "\\tab"
syn match   cljCharacter "\\newline"
syn match   cljCharacter "\\return"
syn match   cljCharacter "\\backspace"
syn match   cljCharacter "\\formfeed"

let radixChars = "0123456789abcdefghijklmnopqrstuvwxyz"
for radix in range(2, 36)
	execute 'syn match cljNumber "\c\<-\?' . radix . 'r['
				\ . strpart(radixChars, 0, radix)
				\ . ']\+\>"'
endfor

syn match   cljNumber "\<-\=[0-9]\+\(\.[0-9]*\)\=\(M\|\([eE][-+]\?[0-9]\+\)\)\?\>"
syn match   cljNumber "\<-\=0x[0-9a-fA-F]\+\>"
syn match   cljNumber "\<-\=[0-9]\+/[0-9]\+\>"

syn match   cljQuote "\('\|`\)"
syn match   cljUnquote "\(\~@\|\~\)"
syn match   cljDispatch "\(#^\|#'\)"

syn match   cljAnonArg contained "%\(\d\|&\)\?"
syn match   cljVarArg contained "&"

syn region cljSexpLevel0 matchgroup=cljParen0 start="(" matchgroup=cljParen0 end=")"           contains=@cljTopCluster,cljSexpLevel1
syn region cljSexpLevel1 matchgroup=cljParen1 start="(" matchgroup=cljParen1 end=")" contained contains=@cljTopCluster,cljSexpLevel2
syn region cljSexpLevel2 matchgroup=cljParen2 start="(" matchgroup=cljParen2 end=")" contained contains=@cljTopCluster,cljSexpLevel3
syn region cljSexpLevel3 matchgroup=cljParen3 start="(" matchgroup=cljParen3 end=")" contained contains=@cljTopCluster,cljSexpLevel4
syn region cljSexpLevel4 matchgroup=cljParen4 start="(" matchgroup=cljParen4 end=")" contained contains=@cljTopCluster,cljSexpLevel5
syn region cljSexpLevel5 matchgroup=cljParen5 start="(" matchgroup=cljParen5 end=")" contained contains=@cljTopCluster,cljSexpLevel6
syn region cljSexpLevel6 matchgroup=cljParen6 start="(" matchgroup=cljParen6 end=")" contained contains=@cljTopCluster,cljSexpLevel7
syn region cljSexpLevel7 matchgroup=cljParen7 start="(" matchgroup=cljParen7 end=")" contained contains=@cljTopCluster,cljSexpLevel8
syn region cljSexpLevel8 matchgroup=cljParen8 start="(" matchgroup=cljParen8 end=")" contained contains=@cljTopCluster,cljSexpLevel9
syn region cljSexpLevel9 matchgroup=cljParen9 start="(" matchgroup=cljParen9 end=")" contained contains=@cljTopCluster,cljSexpLevel0

syn region  cljAnonFn  matchgroup=cljParen0 start="#(" matchgroup=cljParen0 end=")"  contains=@cljTopCluster,cljAnonArg,cljSexpLevel0
syn region  cljVector  matchgroup=cljParen0 start="\[" matchgroup=cljParen0 end="\]" contains=@cljTopCluster,cljVarArg,cljSexpLevel0
syn region  cljMap     matchgroup=cljParen0 start="{"  matchgroup=cljParen0 end="}"  contains=@cljTopCluster,cljSexpLevel0
syn region  cljSet     matchgroup=cljParen0 start="#{" matchgroup=cljParen0 end="}"  contains=@cljTopCluster,cljSexpLevel0

syn region  cljPattern start=/L\=\#"/ skip=/\\\\\|\\"/ end=/"/

syn region  cljCommentSexp                          start="("                                       end=")" transparent contained contains=cljCommentSexp
syn region  cljComment     matchgroup=cljParen0 start="(comment"rs=s+1 matchgroup=cljParen0 end=")"                       contains=cljCommentSexp
syn region  cljComment                              start="#!" end="\n"
syn match   cljComment "#_"

syn sync fromstart

" Create a convenience higlighting command
if version >= 600
	command -nargs=+ HiLink highlight default link <args>
else
	command -nargs=+ HiLink highlight         link <args>
endif

HiLink cljConstant  Constant
HiLink cljBoolean   Boolean
HiLink cljCharacter Character
HiLink cljKeyword   Operator
HiLink cljNumber    Number
HiLink cljString    String
HiLink cljPattern   Constant

HiLink cljVariable  Identifier
HiLink cljCond      Conditional
HiLink cljDefine    Define
HiLink cljException Exception
HiLink cljFunc      Function
HiLink cljMacro     Macro
HiLink cljRepeat    Repeat

HiLink cljQuote     Special
HiLink cljUnquote   Special
HiLink cljDispatch  Special
HiLink cljAnonArg   Special
HiLink cljVarArg    Special
HiLink cljSpecial   Special

HiLink cljComment   Comment
HiLink cljTodo      Todo

HiLink cljError Error

if &background == "dark"
	highlight default cljParen1 ctermfg=yellow      guifg=orange1
	highlight default cljParen2 ctermfg=green       guifg=yellow1
	highlight default cljParen3 ctermfg=cyan        guifg=greenyellow
	highlight default cljParen4 ctermfg=magenta     guifg=green1
	highlight default cljParen5 ctermfg=red         guifg=springgreen1
	highlight default cljParen6 ctermfg=yellow      guifg=cyan1
	highlight default cljParen7 ctermfg=green       guifg=slateblue1
	highlight default cljParen8 ctermfg=cyan        guifg=magenta1
	highlight default cljParen9 ctermfg=magenta     guifg=purple1
else
	highlight default cljParen1 ctermfg=darkyellow  guifg=orangered3
	highlight default cljParen2 ctermfg=darkgreen   guifg=orange2
	highlight default cljParen3 ctermfg=blue        guifg=yellow3
	highlight default cljParen4 ctermfg=darkmagenta guifg=olivedrab4
	highlight default cljParen5 ctermfg=red         guifg=green4
	highlight default cljParen6 ctermfg=darkyellow  guifg=paleturquoise3
	highlight default cljParen7 ctermfg=darkgreen   guifg=deepskyblue4
	highlight default cljParen8 ctermfg=blue        guifg=darkslateblue
	highlight default cljParen9 ctermfg=darkmagenta guifg=darkviolet
endif

" delete our temporary command
delcommand HiLink

