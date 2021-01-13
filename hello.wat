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
        i32.const 0
        i32.const 10
        call $writelogUsingMem
    )
)