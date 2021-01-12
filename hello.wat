(module
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
)