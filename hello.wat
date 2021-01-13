(module
    (import "console" "log" (func $writelog (param i32) ))
    (import "console" "logUsingMem" (func $writelogUsingMem (param i32 i32) ))
    (import "time" "now" (func $timenow))
    (data (i32.const 0) "hello wasm")
    (import "wasm" "mem" (memory 1))
    (func $adds (param $p1 i32) (param $p2 i32)(param $p3 i32)(param $p4 i32) (result i32)
        local.get $p1
        local.get $p2
        i32.add
        local.get $p3
        i32.add
        local.get $p4
        i32.add
    )
    (export "adds" (func $adds))
    (func $returnConst(result i32)
        i32.const 35
    )
    (func $constAdds (export "constAdds")(result i32)
        call $returnConst
        call $returnConst
        call $returnConst
        call $returnConst
        call $adds
        call $returnConst
        call $returnConst
        call $returnConst
        call $adds
    )
    
    (func (export "write")
        call $constAdds
        call $writelog
        i32.const 9999
        call $writelog
    )
    (func (export "shownow")
        call $timenow
    )
     (func (export "writeString")
        i32.const 0 ;; offset
        i32.const 10 ;; length
        call $writelogUsingMem
    )
    (table 4 anyfunc)
    (elem (i32.const 1) $func1 $func2 $func3)
    (func $func1  (param $p1 i32)(param $p2 i32)(result i32)
        local.get $p1
        local.get $p2
        i32.add
    )
    (func $func2 (result i32)
        i32.const 22
    )
    (func $func3 (result i32)
        i32.const 33
    )
    (type $return_i32(func (result i32)))
    (type $return_add(func (param i32 i32)(result i32)))
    (func (export "funcUsingTable")(result i32)
        i32.const 2
        call_indirect (type $return_i32)
        i32.const 3
        call_indirect (type $return_i32)
        i32.const 3
        call_indirect (type $return_i32)
        i32.const 1
        call_indirect (type $return_add)
        i32.const 1
        call_indirect (type $return_add)
    )
     (func (export "throwRuntimeErr")(result i32)
        i32.const 1
        call_indirect (type $return_i32) ;; unmatch signature
    )
     (func (export "callUndefindIndex")(result i32)
        i32.const 0
        call_indirect (type $return_i32)
    )
)