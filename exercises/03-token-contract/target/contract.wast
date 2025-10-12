(module
 (type $i32_=>_i32 (func (param i32) (result i32)))
 (type $i32_i32_=>_i32 (func (param i32 i32) (result i32)))
 (type $i32_i32_=>_none (func (param i32 i32)))
 (type $i32_i32_i32_=>_none (func (param i32 i32 i32)))
 (type $none_=>_i32 (func (result i32)))
 (type $i32_=>_none (func (param i32)))
 (type $i32_i32_i32_i32_=>_none (func (param i32 i32 i32 i32)))
 (type $i32_i32_i32_=>_i32 (func (param i32 i32 i32) (result i32)))
 (type $i32_i64_=>_i32 (func (param i32 i64) (result i32)))
 (type $i32_=>_i64 (func (param i32) (result i64)))
 (type $i32_i64_=>_none (func (param i32 i64)))
 (type $i64_=>_i32 (func (param i64) (result i32)))
 (type $i32_i32_i64_i32_=>_i32 (func (param i32 i32 i64 i32) (result i32)))
 (type $i64_=>_none (func (param i64)))
 (type $i32_i32_i32_i32_i32_=>_none (func (param i32 i32 i32 i32 i32)))
 (type $i32_i32_i32_i32_i32_i32_=>_none (func (param i32 i32 i32 i32 i32 i32)))
 (type $i64_i64_i64_i64_=>_i32 (func (param i64 i64 i64 i64) (result i32)))
 (type $none_=>_none (func))
 (type $i32_i32_i32_i64_=>_none (func (param i32 i32 i32 i64)))
 (type $i32_i64_i32_i32_=>_none (func (param i32 i64 i32 i32)))
 (type $i32_i64_i32_i64_=>_none (func (param i32 i64 i32 i64)))
 (type $i64_i64_i64_=>_none (func (param i64 i64 i64)))
 (type $i32_i32_i32_i32_=>_i32 (func (param i32 i32 i32 i32) (result i32)))
 (type $i32_i64_i64_i64_=>_i32 (func (param i32 i64 i64 i64) (result i32)))
 (type $i64_i32_=>_i32 (func (param i64 i32) (result i32)))
 (type $i64_i64_i64_i64_i32_i32_=>_i32 (func (param i64 i64 i64 i64 i32 i32) (result i32)))
 (import "env" "eosio_assert" (func $~lib/as-chain/env/eosio_assert (param i32 i32)))
 (import "env" "db_lowerbound_i64" (func $~lib/as-chain/env/db_lowerbound_i64 (param i64 i64 i64 i64) (result i32)))
 (import "env" "db_get_i64" (func $~lib/as-chain/env/db_get_i64 (param i32 i32 i32) (result i32)))
 (import "env" "is_account" (func $~lib/as-chain/env/is_account (param i64) (result i32)))
 (import "env" "db_find_i64" (func $~lib/as-chain/env/db_find_i64 (param i64 i64 i64 i64) (result i32)))
 (import "env" "memcpy" (func $~lib/as-chain/env/memcpy (param i32 i32 i32) (result i32)))
 (import "env" "db_store_i64" (func $~lib/as-chain/env/db_store_i64 (param i64 i64 i64 i64 i32 i32) (result i32)))
 (import "env" "require_auth" (func $~lib/as-chain/env/require_auth (param i64)))
 (import "env" "db_update_i64" (func $~lib/as-chain/env/db_update_i64 (param i32 i64 i32 i32)))
 (import "env" "require_recipient" (func $~lib/as-chain/env/require_recipient (param i64)))
 (import "env" "prints_l" (func $~lib/as-chain/env/prints_l (param i32 i32)))
 (import "env" "action_data_size" (func $~lib/as-chain/env/action_data_size (result i32)))
 (import "env" "read_action_data" (func $~lib/as-chain/env/read_action_data (param i32 i32) (result i32)))
 (global $~lib/rt/stub/offset (mut i32) (i32.const 0))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $contract/erc20like i32 (i32.const 7))
 (memory $0 1)
 (data (i32.const 1036) "\1c")
 (data (i32.const 1048) "\03\00\00\00\08\00\00\00\01")
 (data (i32.const 1068) "<")
 (data (i32.const 1084) " \00\00\00.12345abcdefghijklmnopqrstuvwxyz")
 (data (i32.const 1132) ",")
 (data (i32.const 1144) "\04\00\00\00\10\00\00\00@\04\00\00@\04\00\00 \00\00\00 ")
 (data (i32.const 1180) "\dc")
 (data (i32.const 1192) "\01\00\00\00\cc\00\00\00F\00a\00i\00l\00e\00d\00 \00t\00o\00 \00\'\00s\00t\00o\00r\00e\00\'\00 \00v\00a\00l\00u\00e\00 \00a\00s\00 \00i\00t\00 \00a\00l\00r\00e\00a\00d\00y\00 \00e\00x\00i\00s\00t\00s\00,\00 \00p\00l\00e\00a\00s\00e\00 \00u\00s\00e\00 \00\'\00s\00e\00t\00\'\00 \00o\00r\00 \00\'\00u\00p\00d\00a\00t\00e\00\'\00 \00i\00f\00 \00y\00o\00u\00 \00w\00i\00s\00h\00 \00t\00o\00 \00u\00p\00d\00a\00t\00e\00 \00v\00a\00l\00u\00e")
 (data (i32.const 1404) "\dc")
 (data (i32.const 1416) "\01\00\00\00\c0\00\00\00F\00a\00i\00l\00e\00d\00 \00t\00o\00 \00\'\00u\00p\00d\00a\00t\00e\00\'\00 \00v\00a\00l\00u\00e\00 \00a\00s\00 \00i\00t\00e\00m\00 \00d\00o\00e\00s\00 \00n\00o\00t\00 \00e\00x\00i\00s\00t\00,\00 \00p\00l\00e\00a\00s\00e\00 \00u\00s\00e\00 \00\'\00s\00e\00t\00\'\00 \00o\00r\00 \00\'\00s\00t\00o\00r\00e\00\'\00 \00t\00o\00 \00s\00a\00v\00e\00 \00v\00a\00l\00u\00e\00 \00f\00i\00r\00s\00t")
 (data (i32.const 1628) "\dc")
 (data (i32.const 1640) "\01\00\00\00\c0\00\00\00F\00a\00i\00l\00e\00d\00 \00t\00o\00 \00\'\00r\00e\00m\00o\00v\00e\00\'\00 \00v\00a\00l\00u\00e\00 \00a\00s\00 \00i\00t\00e\00m\00 \00d\00o\00e\00s\00 \00n\00o\00t\00 \00e\00x\00i\00s\00t\00,\00 \00p\00l\00e\00a\00s\00e\00 \00u\00s\00e\00 \00\'\00s\00e\00t\00\'\00 \00o\00r\00 \00\'\00s\00t\00o\00r\00e\00\'\00 \00t\00o\00 \00s\00a\00v\00e\00 \00v\00a\00l\00u\00e\00 \00f\00i\00r\00s\00t")
 (data (i32.const 1852) "\8c")
 (data (i32.const 1864) "\01\00\00\00t\00\00\00F\00a\00i\00l\00e\00d\00 \00t\00o\00 \00f\00i\00n\00d\00 \00\'\00n\00e\00x\00t\00\'\00 \00v\00a\00l\00u\00e\00 \00a\00s\00 \00c\00u\00r\00r\00e\00n\00t\00 \00i\00t\00e\00m\00 \00d\00o\00e\00s\00 \00n\00o\00t\00 \00e\00x\00i\00s\00t")
 (data (i32.const 1996) "\8c")
 (data (i32.const 2008) "\01\00\00\00|\00\00\00F\00a\00i\00l\00e\00d\00 \00t\00o\00 \00f\00i\00n\00d\00 \00\'\00p\00r\00e\00v\00i\00o\00u\00s\00\'\00 \00v\00a\00l\00u\00e\00 \00a\00s\00 \00c\00u\00r\00r\00e\00n\00t\00 \00i\00t\00e\00m\00 \00d\00o\00e\00s\00 \00n\00o\00t\00 \00e\00x\00i\00s\00t")
 (data (i32.const 2140) "|")
 (data (i32.const 2152) "\01\00\00\00f\00\00\00n\00e\00x\00t\00 \00p\00r\00i\00m\00a\00r\00y\00 \00k\00e\00y\00 \00i\00n\00 \00t\00a\00b\00l\00e\00 \00i\00s\00 \00a\00t\00 \00a\00u\00t\00o\00i\00n\00c\00r\00e\00m\00e\00n\00t\00 \00l\00i\00m\00i\00t")
 (data (i32.const 2268) "<")
 (data (i32.const 2280) "\01\00\00\00\1e\00\00\00b\00a\00d\00 \00s\00y\00m\00b\00o\00l\00 \00n\00a\00m\00e")
 (data (i32.const 2332) "<")
 (data (i32.const 2344) "\01\00\00\00\"\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00c\00h\00a\00r\00a\00c\00t\00e\00r")
 (data (i32.const 2396) "\1c")
 (data (i32.const 2408) "\01\00\00\00\0c\00\00\00C\00I\00N\00F\00R\00A")
 (data (i32.const 2428) "\1c")
 (data (i32.const 2440) "\01")
 (data (i32.const 2460) "\1c")
 (data (i32.const 2492) "\\")
 (data (i32.const 2504) "\01\00\00\00>\00\00\00D\00e\00c\00o\00d\00e\00r\00.\00i\00n\00c\00P\00o\00s\00:\00 \00b\00u\00f\00f\00e\00r\00 \00o\00v\00e\00r\00f\00l\00o\00w")
 (data (i32.const 2588) "\ac")
 (data (i32.const 2600) "\01\00\00\00\96\00\00\00T\00o\00k\00e\00n\00 \00i\00s\00 \00n\00o\00t\00 \00i\00n\00i\00t\00i\00a\00l\00i\00z\00e\00d\00.\00 \00C\00a\00l\00l\00 \00m\00i\00n\00t\00 \00o\00n\00c\00e\00 \00w\00i\00t\00h\00 \00d\00e\00s\00i\00r\00e\00d\00 \00s\00y\00m\00b\00o\00l\00 \00t\00o\00 \00i\00n\00i\00t\00i\00a\00l\00i\00z\00e\00.")
 (data (i32.const 2764) "<")
 (data (i32.const 2776) "\01\00\00\00\1e\00\00\00u\00n\00e\00x\00p\00e\00c\00t\00e\00d\00 \00n\00u\00l\00l")
 (data (i32.const 2828) "\1c")
 (data (i32.const 2860) "\1c")
 (data (i32.const 2892) "\1c")
 (data (i32.const 2904) "\1f\00\00\00\08\00\00\00\02")
 (data (i32.const 2924) "<")
 (data (i32.const 2936) "\01\00\00\00\1e\00\00\00s\00y\00m\00b\00o\00l\00 \00m\00i\00s\00m\00a\00t\00c\00h")
 (data (i32.const 2988) "L")
 (data (i32.const 3000) "\01\00\00\002\00\00\00t\00o\00 \00a\00c\00c\00o\00u\00n\00t\00 \00d\00o\00e\00s\00 \00n\00o\00t\00 \00e\00x\00i\00s\00t")
 (data (i32.const 3068) "<")
 (data (i32.const 3080) "\01\00\00\00 \00\00\00i\00n\00v\00a\00l\00i\00d\00 \00q\00u\00a\00n\00t\00i\00t\00y")
 (data (i32.const 3132) "L")
 (data (i32.const 3144) "\01\00\00\006\00\00\00m\00u\00s\00t\00 \00m\00i\00n\00t\00 \00p\00o\00s\00i\00t\00i\00v\00e\00 \00q\00u\00a\00n\00t\00i\00t\00y")
 (data (i32.const 3212) "L")
 (data (i32.const 3224) "\01\00\00\002\00\00\00c\00h\00e\00c\00k\00P\00o\00s\00:\00 \00b\00u\00f\00f\00e\00r\00 \00o\00v\00e\00r\00f\00l\00o\00w")
 (data (i32.const 3292) "L")
 (data (i32.const 3304) "\01\00\00\00.\00\00\00i\00n\00c\00P\00o\00s\00:\00 \00b\00u\00f\00f\00e\00r\00 \00o\00v\00e\00r\00f\00l\00o\00w")
 (data (i32.const 3372) "<")
 (data (i32.const 3384) "\01\00\00\00&\00\00\00n\00o\00 \00s\00e\00c\00o\00n\00d\00a\00r\00y\00 \00v\00a\00l\00u\00e\00!")
 (data (i32.const 3436) "<")
 (data (i32.const 3448) "\01\00\00\00&\00\00\00s\00y\00m\00b\00o\00l\00 \00n\00o\00t\00 \00t\00h\00e\00 \00s\00a\00m\00e")
 (data (i32.const 3500) "<")
 (data (i32.const 3512) "\01\00\00\00$\00\00\00a\00d\00d\00i\00t\00i\00o\00n\00 \00u\00n\00d\00e\00r\00f\00l\00o\00w")
 (data (i32.const 3564) "<")
 (data (i32.const 3576) "\01\00\00\00\"\00\00\00a\00d\00d\00i\00t\00i\00o\00n\00 \00o\00v\00e\00r\00f\00l\00o\00w")
 (data (i32.const 3628) "<")
 (data (i32.const 3640) "\01\00\00\00&\00\00\00u\00p\00d\00a\00t\00e\00:\00b\00a\00d\00 \00i\00t\00e\00r\00a\00t\00o\00r")
 (data (i32.const 3692) "L")
 (data (i32.const 3704) "\01\00\00\00:\00\00\00g\00e\00t\00 \00p\00r\00i\00m\00a\00r\00y\00:\00 \00i\00n\00v\00a\00l\00i\00d\00 \00i\00t\00e\00r\00a\00t\00o\00r")
 (data (i32.const 3772) "l")
 (data (i32.const 3784) "\01\00\00\00V\00\00\00p\00r\00i\00m\00a\00r\00y\00 \00k\00e\00y\00 \00c\00a\00n\00\'\00t\00 \00b\00e\00 \00c\00h\00a\00n\00g\00e\00d\00 \00d\00u\00r\00i\00n\00g\00 \00u\00p\00d\00a\00t\00e\00!")
 (data (i32.const 3884) ",")
 (data (i32.const 3896) "\01\00\00\00\0e\00\00\00[\00M\00i\00n\00t\00]\00 ")
 (data (i32.const 3932) "\1c")
 (data (i32.const 3944) "\01\00\00\00\08\00\00\00 \00-\00>\00 ")
 (data (i32.const 3964) ",")
 (data (i32.const 3976) "&\00\00\00\14\00\00\00@\0f\00\00\00\00\00\00p\0f\00\00\00\00\00\00\90\t")
 (data (i32.const 4012) "\1c")
 (data (i32.const 4024) "\01\00\00\00\02\00\00\000")
 (data (i32.const 4044) "\\")
 (data (i32.const 4056) "\01\00\00\00H\00\00\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z")
 (data (i32.const 4140) "\1c")
 (data (i32.const 4152) "\01\00\00\00\02\00\00\00.")
 (data (i32.const 4172) "\1c")
 (data (i32.const 4184) "\01\00\00\00\02\00\00\00 ")
 (data (i32.const 4204) "L")
 (data (i32.const 4216) "\01\00\00\00.\00\00\00c\00a\00n\00n\00o\00t\00 \00t\00r\00a\00n\00s\00f\00e\00r\00 \00t\00o\00 \00s\00e\00l\00f")
 (data (i32.const 4284) "\\")
 (data (i32.const 4296) "\01\00\00\00>\00\00\00m\00u\00s\00t\00 \00t\00r\00a\00n\00s\00f\00e\00r\00 \00p\00o\00s\00i\00t\00i\00v\00e\00 \00q\00u\00a\00n\00t\00i\00t\00y")
 (data (i32.const 4380) "L")
 (data (i32.const 4392) "\01\00\00\00.\00\00\00n\00o\00 \00b\00a\00l\00a\00n\00c\00e\00 \00o\00b\00j\00e\00c\00t\00 \00f\00o\00u\00n\00d")
 (data (i32.const 4460) "<")
 (data (i32.const 4472) "\01\00\00\00\"\00\00\00o\00v\00e\00r\00d\00r\00a\00w\00n\00 \00b\00a\00l\00a\00n\00c\00e")
 (data (i32.const 4524) "<")
 (data (i32.const 4536) "\01\00\00\00*\00\00\00s\00u\00b\00t\00r\00a\00c\00t\00i\00o\00n\00 \00u\00n\00d\00e\00r\00f\00l\00o\00w")
 (data (i32.const 4588) "<")
 (data (i32.const 4600) "\01\00\00\00(\00\00\00s\00u\00b\00t\00r\00a\00c\00t\00i\00o\00n\00 \00o\00v\00e\00r\00f\00l\00o\00w")
 (data (i32.const 4652) ",")
 (data (i32.const 4664) "\01\00\00\00\16\00\00\00[\00T\00r\00a\00n\00s\00f\00e\00r\00]\00 ")
 (data (i32.const 4700) "\1c")
 (data (i32.const 4712) "\01\00\00\00\06\00\00\00 \00:\00 ")
 (data (i32.const 4732) ",")
 (data (i32.const 4744) "\01\00\00\00\12\00\00\00 \00|\00 \00m\00e\00m\00o\00=\00\"")
 (data (i32.const 4780) "\1c")
 (data (i32.const 4792) "\01\00\00\00\02\00\00\00\"")
 (data (i32.const 4812) "<")
 (data (i32.const 4824) "&\00\00\00$\00\00\00@\12\00\00\00\00\00\00p\0f\00\00\00\00\00\00p\12\00\00\00\00\00\00\90\12\00\00\00\00\00\00\c0\12")
 (data (i32.const 4876) "L")
 (data (i32.const 4888) "\01\00\00\00<\00\00\00s\00p\00e\00n\00d\00e\00r\00 \00a\00c\00c\00o\00u\00n\00t\00 \00d\00o\00e\00s\00 \00n\00o\00t\00 \00e\00x\00i\00s\00t")
 (data (i32.const 4956) "<")
 (data (i32.const 4968) "\01\00\00\00&\00\00\00c\00a\00n\00n\00o\00t\00 \00a\00p\00p\00r\00o\00v\00e\00 \00s\00e\00l\00f")
 (data (i32.const 5020) ",")
 (data (i32.const 5032) "\01\00\00\00\1a\00\00\00i\00n\00v\00a\00l\00i\00d\00 \00a\00s\00s\00e\00t")
 (data (i32.const 5068) "L")
 (data (i32.const 5080) "\01\00\00\006\00\00\00a\00m\00o\00u\00n\00t\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00o\00n\00-\00n\00e\00g\00a\00t\00i\00v\00e")
 (data (i32.const 5148) ",")
 (data (i32.const 5160) "\01\00\00\00\16\00\00\00[\00A\00p\00p\00r\00o\00v\00a\00l\00]\00 ")
 (data (i32.const 5196) ",")
 (data (i32.const 5208) "&\00\00\00\1c\00\00\000\14\00\00\00\00\00\00p\0f\00\00\00\00\00\00p\12\00\00\00\00\00\00\90\t")
 (data (i32.const 5244) "L")
 (data (i32.const 5256) "\01\00\00\00:\00\00\00m\00u\00s\00t\00 \00t\00r\00a\00n\00s\00f\00e\00r\00 \00p\00o\00s\00i\00t\00i\00v\00e\00 \00a\00m\00o\00u\00n\00t")
 (data (i32.const 5324) "L")
 (data (i32.const 5336) "\01\00\00\000\00\00\00n\00o\00 \00a\00l\00l\00o\00w\00a\00n\00c\00e\00 \00f\00o\00r\00 \00s\00p\00e\00n\00d\00e\00r")
 (data (i32.const 5404) "<")
 (data (i32.const 5416) "\01\00\00\00,\00\00\00i\00n\00s\00u\00f\00f\00i\00c\00i\00e\00n\00t\00 \00a\00l\00l\00o\00w\00a\00n\00c\00e")
 (data (i32.const 5468) "<")
 (data (i32.const 5480) "\01\00\00\00\1e\00\00\00[\00T\00r\00a\00n\00s\00f\00e\00r\00F\00r\00o\00m\00]\00 ")
 (data (i32.const 5532) "<")
 (data (i32.const 5544) "&\00\00\00,\00\00\00p\15\00\00\00\00\00\00p\12\00\00\00\00\00\00p\0f\00\00\00\00\00\00p\12\00\00\00\00\00\00\90\12\00\00\00\00\00\00\c0\12")
 (data (i32.const 5596) ",")
 (data (i32.const 5608) "\01\00\00\00\18\00\00\00[\00B\00a\00l\00a\00n\00c\00e\00O\00f\00]\00 ")
 (data (i32.const 5644) "\1c")
 (data (i32.const 5656) "\01\00\00\00\06\00\00\00 \00=\00 ")
 (data (i32.const 5676) ",")
 (data (i32.const 5688) "&\00\00\00\14\00\00\00\f0\15\00\00\00\00\00\00 \16\00\00\00\00\00\00\90\t")
 (data (i32.const 5724) "<")
 (data (i32.const 5736) "\01\00\00\00$\00\00\00[\00A\00l\00l\00o\00w\00a\00n\00c\00e\00]\00 \00o\00w\00n\00e\00r\00=")
 (data (i32.const 5788) ",")
 (data (i32.const 5800) "\01\00\00\00\12\00\00\00 \00s\00p\00e\00n\00d\00e\00r\00=")
 (data (i32.const 5836) ",")
 (data (i32.const 5848) "\01\00\00\00\10\00\00\00 \00a\00m\00o\00u\00n\00t\00=")
 (data (i32.const 5884) ",")
 (data (i32.const 5896) "&\00\00\00\1c\00\00\00p\16\00\00\00\00\00\00\b0\16\00\00\00\00\00\00\e0\16\00\00\00\00\00\00\90\t")
 (data (i32.const 5932) "\1c")
 (data (i32.const 5944) "\01\00\00\00\08\00\00\00m\00i\00n\00t")
 (data (i32.const 5964) ",")
 (data (i32.const 5976) "\01\00\00\00\10\00\00\00t\00r\00a\00n\00s\00f\00e\00r")
 (data (i32.const 6012) ",")
 (data (i32.const 6024) "\01\00\00\00\0e\00\00\00a\00p\00p\00r\00o\00v\00e")
 (data (i32.const 6060) ",")
 (data (i32.const 6072) "\01\00\00\00\18\00\00\00t\00r\00a\00n\00s\00f\00e\00r\00f\00r\00o\00m")
 (data (i32.const 6108) ",")
 (data (i32.const 6120) "\01\00\00\00\12\00\00\00b\00a\00l\00a\00n\00c\00e\00o\00f")
 (data (i32.const 6156) ",")
 (data (i32.const 6168) "\01\00\00\00\12\00\00\00a\00l\00l\00o\00w\00a\00n\00c\00e")
 (data (i32.const 6204) ",")
 (data (i32.const 6216) "\01\00\00\00\1c\00\00\00i\00n\00v\00a\00l\00i\00d\00 \00s\00y\00m\00b\00o\00l")
 (export "erc20like" (global $contract/erc20like))
 (export "erc20like#get:receiver" (func $~lib/as-chain/helpers/Contract#get:receiver))
 (export "erc20like#set:receiver" (func $~lib/rt/common/BLOCK#set:mmInfo))
 (export "erc20like#get:firstReceiver" (func $~lib/as-chain/helpers/Contract#get:firstReceiver))
 (export "erc20like#set:firstReceiver" (func $~lib/rt/common/OBJECT#set:gcInfo))
 (export "erc20like#get:action" (func $~lib/as-chain/helpers/Contract#get:action))
 (export "erc20like#set:action" (func $~lib/rt/common/OBJECT#set:gcInfo2))
 (export "erc20like#constructor" (func $contract/erc20like#constructor))
 (export "erc20like#mint" (func $contract/erc20like#mint))
 (export "erc20like#transfer" (func $contract/erc20like#transfer@varargs))
 (export "erc20like#approve" (func $contract/erc20like#approve))
 (export "erc20like#transferFrom" (func $contract/erc20like#transferFrom@varargs))
 (export "erc20like#balanceOf" (func $contract/erc20like#balanceOf))
 (export "erc20like#allowance" (func $contract/erc20like#allowance))
 (export "apply" (func $contract/apply))
 (export "memory" (memory $0))
 (export "__setArgumentsLength" (func $~setArgumentsLength))
 (start $~start)
 (func $~lib/as-chain/name/Name#set:N (param $0 i32) (param $1 i64)
  (i64.store
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/rt/stub/maybeGrowMemory (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (if
   (i32.gt_u
    (local.get $0)
    (local.tee $1
     (i32.and
      (i32.add
       (i32.shl
        (local.tee $2
         (memory.size)
        )
        (i32.const 16)
       )
       (i32.const 15)
      )
      (i32.const -16)
     )
    )
   )
   (if
    (i32.lt_s
     (memory.grow
      (select
       (local.get $2)
       (local.tee $1
        (i32.shr_u
         (i32.and
          (i32.add
           (i32.sub
            (local.get $0)
            (local.get $1)
           )
           (i32.const 65535)
          )
          (i32.const -65536)
         )
         (i32.const 16)
        )
       )
       (i32.lt_s
        (local.get $1)
        (local.get $2)
       )
      )
     )
     (i32.const 0)
    )
    (if
     (i32.lt_s
      (memory.grow
       (local.get $1)
      )
      (i32.const 0)
     )
     (unreachable)
    )
   )
  )
  (global.set $~lib/rt/stub/offset
   (local.get $0)
  )
 )
 (func $~lib/rt/common/BLOCK#set:mmInfo (param $0 i32) (param $1 i32)
  (i32.store
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/rt/stub/__alloc (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (if
   (i32.gt_u
    (local.get $0)
    (i32.const 1073741820)
   )
   (unreachable)
  )
  (local.set $1
   (global.get $~lib/rt/stub/offset)
  )
  (call $~lib/rt/stub/maybeGrowMemory
   (i32.add
    (local.tee $2
     (i32.add
      (global.get $~lib/rt/stub/offset)
      (i32.const 4)
     )
    )
    (local.tee $0
     (i32.sub
      (i32.and
       (i32.add
        (local.get $0)
        (i32.const 19)
       )
       (i32.const -16)
      )
      (i32.const 4)
     )
    )
   )
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $1)
   (local.get $0)
  )
  (local.get $2)
 )
 (func $~lib/rt/common/OBJECT#set:gcInfo (param $0 i32) (param $1 i32)
  (i32.store offset=4
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/rt/common/OBJECT#set:gcInfo2 (param $0 i32) (param $1 i32)
  (i32.store offset=8
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/rt/common/OBJECT#set:rtId (param $0 i32) (param $1 i32)
  (i32.store offset=12
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/rt/common/OBJECT#set:rtSize (param $0 i32) (param $1 i32)
  (i32.store offset=16
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/rt/stub/__new (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (if
   (i32.gt_u
    (local.get $0)
    (i32.const 1073741804)
   )
   (unreachable)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.tee $2
    (i32.sub
     (local.tee $3
      (call $~lib/rt/stub/__alloc
       (i32.add
        (local.get $0)
        (i32.const 16)
       )
      )
     )
     (i32.const 4)
    )
   )
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $2)
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:rtId
   (local.get $2)
   (local.get $1)
  )
  (call $~lib/rt/common/OBJECT#set:rtSize
   (local.get $2)
   (local.get $0)
  )
  (i32.add
   (local.get $3)
   (i32.const 16)
  )
 )
 (func $contract/Stat#constructor (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $3
    (call $~lib/rt/stub/__new
     (i32.const 12)
     (i32.const 9)
    )
   )
   (local.get $0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $3)
   (local.get $1)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $3)
   (local.get $2)
  )
  (local.get $3)
 )
 (func $~lib/string/String#get:length (param $0 i32) (result i32)
  (i32.shr_u
   (i32.load offset=16
    (i32.sub
     (local.get $0)
     (i32.const 20)
    )
   )
   (i32.const 1)
  )
 )
 (func $~lib/string/String.UTF8.byteLength (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local.set $4
   (i32.add
    (local.get $0)
    (i32.load offset=16
     (i32.sub
      (local.get $0)
      (i32.const 20)
     )
    )
   )
  )
  (local.set $2
   (i32.ne
    (local.get $1)
    (i32.const 0)
   )
  )
  (loop $while-continue|0
   (if
    (i32.lt_u
     (local.get $0)
     (local.get $4)
    )
    (block $while-break|0
     (local.set $2
      (if (result i32)
       (i32.lt_u
        (local.tee $3
         (i32.load16_u
          (local.get $0)
         )
        )
        (i32.const 128)
       )
       (block (result i32)
        (br_if $while-break|0
         (i32.and
          (local.get $1)
          (i32.eqz
           (local.get $3)
          )
         )
        )
        (i32.add
         (local.get $2)
         (i32.const 1)
        )
       )
       (if (result i32)
        (i32.lt_u
         (local.get $3)
         (i32.const 2048)
        )
        (i32.add
         (local.get $2)
         (i32.const 2)
        )
        (block (result i32)
         (if
          (select
           (i32.gt_u
            (local.get $4)
            (i32.add
             (local.get $0)
             (i32.const 2)
            )
           )
           (i32.const 0)
           (i32.eq
            (i32.and
             (local.get $3)
             (i32.const 64512)
            )
            (i32.const 55296)
           )
          )
          (if
           (i32.eq
            (i32.and
             (i32.load16_u offset=2
              (local.get $0)
             )
             (i32.const 64512)
            )
            (i32.const 56320)
           )
           (block
            (local.set $2
             (i32.add
              (local.get $2)
              (i32.const 4)
             )
            )
            (local.set $0
             (i32.add
              (local.get $0)
              (i32.const 4)
             )
            )
            (br $while-continue|0)
           )
          )
         )
         (i32.add
          (local.get $2)
          (i32.const 3)
         )
        )
       )
      )
     )
     (local.set $0
      (i32.add
       (local.get $0)
       (i32.const 2)
      )
     )
     (br $while-continue|0)
    )
   )
  )
  (local.get $2)
 )
 (func $~lib/string/String.UTF8.encodeUnsafe (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local.set $4
   (i32.add
    (local.get $0)
    (i32.shl
     (local.get $1)
     (i32.const 1)
    )
   )
  )
  (local.set $1
   (local.get $2)
  )
  (loop $while-continue|0
   (if
    (i32.lt_u
     (local.get $0)
     (local.get $4)
    )
    (block
     (local.set $1
      (if (result i32)
       (i32.lt_u
        (local.tee $2
         (i32.load16_u
          (local.get $0)
         )
        )
        (i32.const 128)
       )
       (block (result i32)
        (i32.store8
         (local.get $1)
         (local.get $2)
        )
        (i32.add
         (local.get $1)
         (i32.const 1)
        )
       )
       (if (result i32)
        (i32.lt_u
         (local.get $2)
         (i32.const 2048)
        )
        (block (result i32)
         (i32.store16
          (local.get $1)
          (i32.or
           (i32.or
            (i32.shr_u
             (local.get $2)
             (i32.const 6)
            )
            (i32.const 192)
           )
           (i32.shl
            (i32.or
             (i32.and
              (local.get $2)
              (i32.const 63)
             )
             (i32.const 128)
            )
            (i32.const 8)
           )
          )
         )
         (i32.add
          (local.get $1)
          (i32.const 2)
         )
        )
        (block (result i32)
         (if
          (select
           (i32.gt_u
            (local.get $4)
            (i32.add
             (local.get $0)
             (i32.const 2)
            )
           )
           (i32.const 0)
           (i32.eq
            (i32.and
             (local.get $2)
             (i32.const 64512)
            )
            (i32.const 55296)
           )
          )
          (if
           (i32.eq
            (i32.and
             (local.tee $5
              (i32.load16_u offset=2
               (local.get $0)
              )
             )
             (i32.const 64512)
            )
            (i32.const 56320)
           )
           (block
            (i32.store
             (local.get $1)
             (i32.or
              (i32.or
               (i32.or
                (i32.shl
                 (i32.or
                  (i32.and
                   (local.tee $2
                    (i32.or
                     (i32.add
                      (i32.shl
                       (i32.and
                        (local.get $2)
                        (i32.const 1023)
                       )
                       (i32.const 10)
                      )
                      (i32.const 65536)
                     )
                     (i32.and
                      (local.get $5)
                      (i32.const 1023)
                     )
                    )
                   )
                   (i32.const 63)
                  )
                  (i32.const 128)
                 )
                 (i32.const 24)
                )
                (i32.shl
                 (i32.or
                  (i32.and
                   (i32.shr_u
                    (local.get $2)
                    (i32.const 6)
                   )
                   (i32.const 63)
                  )
                  (i32.const 128)
                 )
                 (i32.const 16)
                )
               )
               (i32.shl
                (i32.or
                 (i32.and
                  (i32.shr_u
                   (local.get $2)
                   (i32.const 12)
                  )
                  (i32.const 63)
                 )
                 (i32.const 128)
                )
                (i32.const 8)
               )
              )
              (i32.or
               (i32.shr_u
                (local.get $2)
                (i32.const 18)
               )
               (i32.const 240)
              )
             )
            )
            (local.set $1
             (i32.add
              (local.get $1)
              (i32.const 4)
             )
            )
            (local.set $0
             (i32.add
              (local.get $0)
              (i32.const 4)
             )
            )
            (br $while-continue|0)
           )
          )
         )
         (i32.store16
          (local.get $1)
          (i32.or
           (i32.or
            (i32.shr_u
             (local.get $2)
             (i32.const 12)
            )
            (i32.const 224)
           )
           (i32.shl
            (i32.or
             (i32.and
              (i32.shr_u
               (local.get $2)
               (i32.const 6)
              )
              (i32.const 63)
             )
             (i32.const 128)
            )
            (i32.const 8)
           )
          )
         )
         (i32.store8 offset=2
          (local.get $1)
          (i32.or
           (i32.and
            (local.get $2)
            (i32.const 63)
           )
           (i32.const 128)
          )
         )
         (i32.add
          (local.get $1)
          (i32.const 3)
         )
        )
       )
      )
     )
     (local.set $0
      (i32.add
       (local.get $0)
       (i32.const 2)
      )
     )
     (br $while-continue|0)
    )
   )
  )
  (if
   (local.get $3)
   (i32.store8
    (local.get $1)
    (i32.const 0)
   )
  )
 )
 (func $~lib/string/String.UTF8.encode (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local.set $2
   (call $~lib/rt/stub/__new
    (call $~lib/string/String.UTF8.byteLength
     (local.get $0)
     (local.get $1)
    )
    (i32.const 0)
   )
  )
  (call $~lib/string/String.UTF8.encodeUnsafe
   (local.get $0)
   (call $~lib/string/String#get:length
    (local.get $0)
   )
   (local.get $2)
   (local.get $1)
  )
  (local.get $2)
 )
 (func $~lib/arraybuffer/ArrayBuffer#get:byteLength (param $0 i32) (result i32)
  (i32.load offset=16
   (i32.sub
    (local.get $0)
    (i32.const 20)
   )
  )
 )
 (func $~lib/dataview/DataView#constructor@varargs (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (block $2of2
   (block $1of2
    (block $outOfRange
     (br_table $1of2 $1of2 $2of2 $outOfRange
      (i32.sub
       (global.get $~argumentsLength)
       (i32.const 1)
      )
     )
    )
    (unreachable)
   )
   (local.set $2
    (call $~lib/arraybuffer/ArrayBuffer#get:byteLength
     (local.get $0)
    )
   )
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $1
    (call $~lib/rt/stub/__new
     (i32.const 12)
     (i32.const 19)
    )
   )
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $1)
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $1)
   (i32.const 0)
  )
  (if
   (i32.or
    (i32.lt_u
     (call $~lib/arraybuffer/ArrayBuffer#get:byteLength
      (local.get $0)
     )
     (local.get $2)
    )
    (i32.gt_u
     (local.get $2)
     (i32.const 1073741820)
    )
   )
   (unreachable)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $1)
   (local.get $0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $1)
   (local.get $0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $1)
   (local.get $2)
  )
  (local.get $1)
 )
 (func $~lib/as-chain/system/check (param $0 i32) (param $1 i32)
  (if
   (i32.eqz
    (local.get $0)
   )
   (block
    (local.set $0
     (call $~lib/string/String.UTF8.encode
      (local.get $1)
      (i32.const 1)
     )
    )
    (global.set $~argumentsLength
     (i32.const 1)
    )
    (call $~lib/as-chain/env/eosio_assert
     (i32.const 0)
     (i32.load offset=4
      (call $~lib/dataview/DataView#constructor@varargs
       (local.get $0)
      )
     )
    )
   )
  )
 )
 (func $~lib/as-chain/asset/Symbol#constructor (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i64)
  (local $5 i32)
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 12)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/system/check
   (i32.le_s
    (call $~lib/string/String#get:length
     (local.get $0)
    )
    (i32.const 7)
   )
   (i32.const 2288)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $2)
   (i64.const 0)
  )
  (loop $for-loop|0
   (if
    (i32.gt_s
     (call $~lib/string/String#get:length
      (local.get $0)
     )
     (local.get $3)
    )
    (block
     (call $~lib/as-chain/system/check
      (select
       (i64.le_u
        (local.tee $4
         (i64.extend_i32_s
          (block $__inlined_func$~lib/string/String#charCodeAt (result i32)
           (drop
            (br_if $__inlined_func$~lib/string/String#charCodeAt
             (i32.const -1)
             (i32.ge_u
              (local.tee $5
               (i32.sub
                (i32.sub
                 (call $~lib/string/String#get:length
                  (local.get $0)
                 )
                 (i32.const 1)
                )
                (local.get $3)
               )
              )
              (call $~lib/string/String#get:length
               (local.get $0)
              )
             )
            )
           )
           (i32.load16_u
            (i32.add
             (local.get $0)
             (i32.shl
              (local.get $5)
              (i32.const 1)
             )
            )
           )
          )
         )
        )
        (i64.const 90)
       )
       (i32.const 0)
       (i64.ge_u
        (local.get $4)
        (i64.const 65)
       )
      )
      (i32.const 2352)
     )
     (call $~lib/as-chain/name/Name#set:N
      (local.get $2)
      (i64.or
       (local.get $4)
       (i64.load
        (local.get $2)
       )
      )
     )
     (call $~lib/as-chain/name/Name#set:N
      (local.get $2)
      (i64.shl
       (i64.load
        (local.get $2)
       )
       (i64.const 8)
      )
     )
     (local.set $3
      (i32.add
       (local.get $3)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $2)
   (i64.or
    (i64.load
     (local.get $2)
    )
    (i64.extend_i32_u
     (i32.and
      (local.get $1)
      (i32.const 255)
     )
    )
   )
  )
  (local.get $2)
 )
 (func $~lib/as-chain/asset/Asset#constructor (param $0 i64) (param $1 i32) (result i32)
  (local $2 i32)
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 12)
     (i32.const 13)
    )
   )
   (local.get $0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $2)
   (local.get $1)
  )
  (local.get $2)
 )
 (func $~lib/as-chain/asset/Asset#constructor@varargs (result i32)
  (local $0 i32)
  (block $2of2
   (block $1of2
    (block $outOfRange
     (br_table $1of2 $1of2 $2of2 $outOfRange
      (global.get $~argumentsLength)
     )
    )
    (unreachable)
   )
   (local.set $0
    (call $~lib/as-chain/asset/Symbol#constructor
     (i32.const 2448)
     (i32.const 0)
    )
   )
  )
  (call $~lib/as-chain/asset/Asset#constructor
   (i64.const 0)
   (local.get $0)
  )
 )
 (func $contract/Stat#constructor@varargs (result i32)
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (block $3of3
   (block $2of3
    (block $1of3
     (block $0of3
      (block $outOfRange
       (br_table $0of3 $1of3 $2of3 $3of3 $outOfRange
        (global.get $~argumentsLength)
       )
      )
      (unreachable)
     )
     (local.set $2
      (call $~lib/as-chain/asset/Symbol#constructor
       (i32.const 2416)
       (i32.const 4)
      )
     )
    )
    (global.set $~argumentsLength
     (i32.const 0)
    )
    (local.set $1
     (call $~lib/as-chain/asset/Asset#constructor@varargs)
    )
   )
   (call $~lib/as-chain/name/Name#set:N
    (local.tee $0
     (call $~lib/rt/stub/__new
      (i32.const 8)
      (i32.const 5)
     )
    )
    (i64.const 0)
   )
   (call $~lib/as-chain/name/Name#set:N
    (local.get $0)
    (i64.const 0)
   )
  )
  (call $contract/Stat#constructor
   (local.get $2)
   (local.get $1)
   (local.get $0)
  )
 )
 (func $contract/Stat.get:tableName (result i32)
  (local $0 i32)
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $0
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $0)
   (i64.const -4157508551318700032)
  )
  (local.get $0)
 )
 (func $~lib/memory/memory.copy (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (block $~lib/util/memory/memmove|inlined.0
   (local.set $4
    (local.get $2)
   )
   (br_if $~lib/util/memory/memmove|inlined.0
    (i32.eq
     (local.get $0)
     (local.get $1)
    )
   )
   (if
    (i32.lt_u
     (local.get $0)
     (local.get $1)
    )
    (loop $while-continue|0
     (if
      (local.get $4)
      (block
       (local.set $0
        (i32.add
         (local.tee $2
          (local.get $0)
         )
         (i32.const 1)
        )
       )
       (local.set $1
        (i32.add
         (local.tee $3
          (local.get $1)
         )
         (i32.const 1)
        )
       )
       (i32.store8
        (local.get $2)
        (i32.load8_u
         (local.get $3)
        )
       )
       (local.set $4
        (i32.sub
         (local.get $4)
         (i32.const 1)
        )
       )
       (br $while-continue|0)
      )
     )
    )
    (loop $while-continue|1
     (if
      (local.get $4)
      (block
       (i32.store8
        (i32.add
         (local.tee $4
          (i32.sub
           (local.get $4)
           (i32.const 1)
          )
         )
         (local.get $0)
        )
        (i32.load8_u
         (i32.add
          (local.get $1)
          (local.get $4)
         )
        )
       )
       (br $while-continue|1)
      )
     )
    )
   )
  )
 )
 (func $~lib/rt/__newArray (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (result i32)
  (local $4 i32)
  (local $5 i32)
  (local.set $5
   (local.tee $4
    (i32.shl
     (local.get $0)
     (local.get $1)
    )
   )
  )
  (local.set $1
   (call $~lib/rt/stub/__new
    (local.get $4)
    (i32.const 0)
   )
  )
  (if
   (local.get $3)
   (call $~lib/memory/memory.copy
    (local.get $1)
    (local.get $3)
    (local.get $5)
   )
  )
  (local.set $3
   (local.get $1)
  )
  (i32.store
   (local.tee $1
    (call $~lib/rt/stub/__new
     (i32.const 16)
     (local.get $2)
    )
   )
   (local.get $3)
  )
  (i32.store offset=4
   (local.get $1)
   (local.get $3)
  )
  (i32.store offset=8
   (local.get $1)
   (local.get $4)
  )
  (i32.store offset=12
   (local.get $1)
   (local.get $0)
  )
  (local.get $1)
 )
 (func $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope (param $0 i32) (param $1 i64)
  (i64.store offset=8
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:table (param $0 i32) (param $1 i64)
  (i64.store offset=16
   (local.get $0)
   (local.get $1)
  )
 )
 (func $contract/erc20like#constructor (param $0 i32) (param $1 i64) (param $2 i64) (param $3 i64) (result i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (call $~lib/rt/common/OBJECT#set:rtId
   (block (result i32)
    (if
     (i32.eqz
      (local.get $0)
     )
     (local.set $0
      (call $~lib/rt/stub/__new
       (i32.const 16)
       (i32.const 7)
      )
     )
    )
    (local.get $0)
   )
   (i32.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $4
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $4)
   (local.get $1)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $7
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $7)
   (local.get $2)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $5
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $5)
   (local.get $3)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (block (result i32)
    (if
     (i32.eqz
      (local.get $0)
     )
     (local.set $0
      (call $~lib/rt/stub/__new
       (i32.const 12)
       (i32.const 8)
      )
     )
    )
    (local.get $0)
   )
   (local.get $4)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (local.get $7)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $0)
   (local.get $5)
  )
  (local.set $5
   (i32.load
    (local.get $0)
   )
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $8
    (call $~lib/rt/stub/__new
     (i32.const 16)
     (i32.const 14)
    )
   )
   (i32.const 0)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
   (local.get $8)
   (i64.const -1)
  )
  (global.set $~argumentsLength
   (i32.const 0)
  )
  (drop
   (call $contract/Stat#constructor@varargs)
  )
  (local.set $4
   (call $contract/Stat.get:tableName)
  )
  (drop
   (i64.load
    (call $contract/Stat.get:tableName)
   )
  )
  (local.set $7
   (call $~lib/rt/__newArray
    (i32.const 0)
    (i32.const 2)
    (i32.const 18)
    (i32.const 2480)
   )
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $6
    (call $~lib/rt/stub/__new
     (i32.const 16)
     (i32.const 15)
    )
   )
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $6)
   (i32.const 0)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
   (local.get $6)
   (i64.const -1)
  )
  (local.set $3
   (i64.load
    (local.get $5)
   )
  )
  (local.set $2
   (i64.load
    (local.get $5)
   )
  )
  (local.set $1
   (i64.load
    (local.get $4)
   )
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $4
    (call $~lib/rt/stub/__new
     (i32.const 24)
     (i32.const 16)
    )
   )
   (local.get $3)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
   (local.get $4)
   (local.get $2)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:table
   (local.get $4)
   (local.get $1)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $6)
   (local.get $4)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $6)
   (local.get $7)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $8)
   (local.get $6)
  )
  (call $~lib/rt/common/OBJECT#set:rtId
   (local.get $0)
   (local.get $8)
  )
  (local.get $0)
 )
 (func $~lib/as-chain/helpers/Contract#get:receiver (param $0 i32) (result i32)
  (i32.load
   (local.get $0)
  )
 )
 (func $~lib/as-chain/helpers/Contract#get:firstReceiver (param $0 i32) (result i32)
  (i32.load offset=4
   (local.get $0)
  )
 )
 (func $~lib/as-chain/helpers/Contract#get:action (param $0 i32) (result i32)
  (i32.load offset=8
   (local.get $0)
  )
 )
 (func $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#set:validPrimary (param $0 i32) (param $1 i32)
  (i32.store8 offset=8
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#constructor (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32) (result i32)
  (local $4 i32)
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $4
    (call $~lib/rt/stub/__new
     (i32.const 24)
     (i32.const 21)
    )
   )
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $4)
   (i32.const 0)
  )
  (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#set:validPrimary
   (local.get $4)
   (i32.const 0)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:table
   (local.get $4)
   (i64.const 0)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $4)
   (local.get $0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $4)
   (local.get $1)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:table
   (local.get $4)
   (local.get $2)
  )
  (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#set:validPrimary
   (local.get $4)
   (local.get $3)
  )
  (local.get $4)
 )
 (func $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk (param $0 i32) (result i32)
  (i32.ge_s
   (i32.load offset=4
    (local.get $0)
   )
   (i32.const 0)
  )
 )
 (func $~lib/memory/memory.fill (param $0 i32) (param $1 i32)
  (local $2 i32)
  (loop $while-continue|0
   (if
    (local.get $1)
    (block
     (local.set $0
      (i32.add
       (local.tee $2
        (local.get $0)
       )
       (i32.const 1)
      )
     )
     (i32.store8
      (local.get $2)
      (i32.const 0)
     )
     (local.set $1
      (i32.sub
       (local.get $1)
       (i32.const 1)
      )
     )
     (br $while-continue|0)
    )
   )
  )
 )
 (func $~lib/array/Array<u8>#constructor (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $1
    (call $~lib/rt/stub/__new
     (i32.const 16)
     (i32.const 4)
    )
   )
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $1)
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $1)
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:rtId
   (local.get $1)
   (i32.const 0)
  )
  (if
   (i32.gt_u
    (local.get $0)
    (i32.const 1073741820)
   )
   (unreachable)
  )
  (call $~lib/memory/memory.fill
   (local.tee $3
    (call $~lib/rt/stub/__new
     (local.tee $2
      (select
       (local.get $0)
       (i32.const 8)
       (i32.gt_u
        (local.get $0)
        (i32.const 8)
       )
      )
     )
     (i32.const 0)
    )
   )
   (local.get $2)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $1)
   (local.get $3)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $1)
   (local.get $3)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $1)
   (local.get $2)
  )
  (call $~lib/rt/common/OBJECT#set:rtId
   (local.get $1)
   (local.get $0)
  )
  (local.get $1)
 )
 (func $~lib/as-chain/serializer/Decoder#constructor (param $0 i32) (result i32)
  (local $1 i32)
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $1
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 22)
    )
   )
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $1)
   (i32.const 0)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $1)
   (local.get $0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $1)
   (i32.const 0)
  )
  (local.get $1)
 )
 (func $~lib/array/Array<u8>#slice (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (local.set $3
   (i32.load offset=12
    (local.get $0)
   )
  )
  (local.set $1
   (if (result i32)
    (i32.lt_s
     (local.get $1)
     (i32.const 0)
    )
    (select
     (local.tee $1
      (i32.add
       (local.get $1)
       (local.get $3)
      )
     )
     (i32.const 0)
     (i32.gt_s
      (local.get $1)
      (i32.const 0)
     )
    )
    (select
     (local.get $1)
     (local.get $3)
     (i32.lt_s
      (local.get $1)
      (local.get $3)
     )
    )
   )
  )
  (call $~lib/memory/memory.copy
   (i32.load offset=4
    (local.tee $3
     (call $~lib/rt/__newArray
      (local.tee $2
       (select
        (local.tee $2
         (i32.sub
          (if (result i32)
           (i32.lt_s
            (local.get $2)
            (i32.const 0)
           )
           (select
            (local.tee $2
             (i32.add
              (local.get $2)
              (local.get $3)
             )
            )
            (i32.const 0)
            (i32.gt_s
             (local.get $2)
             (i32.const 0)
            )
           )
           (select
            (local.get $2)
            (local.get $3)
            (i32.lt_s
             (local.get $2)
             (local.get $3)
            )
           )
          )
          (local.get $1)
         )
        )
        (i32.const 0)
        (i32.gt_s
         (local.get $2)
         (i32.const 0)
        )
       )
      )
      (i32.const 0)
      (i32.const 4)
      (i32.const 0)
     )
    )
   )
   (i32.add
    (i32.load offset=4
     (local.get $0)
    )
    (local.get $1)
   )
   (local.get $2)
  )
  (local.get $3)
 )
 (func $~lib/as-chain/serializer/Decoder#incPos (param $0 i32) (param $1 i32)
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (i32.add
    (local.get $1)
    (i32.load offset=4
     (local.get $0)
    )
   )
  )
  (if
   (i32.gt_u
    (i32.load offset=4
     (local.get $0)
    )
    (i32.load offset=12
     (i32.load
      (local.get $0)
     )
    )
   )
   (call $~lib/as-chain/system/check
    (i32.const 0)
    (i32.const 2512)
   )
  )
 )
 (func $~lib/as-chain/serializer/Decoder#unpack (param $0 i32) (param $1 i32)
  (call $~lib/as-chain/serializer/Decoder#incPos
   (local.get $0)
   (call $~lib/as-chain/serializer/Packer#unpack@virtual
    (local.get $1)
    (call $~lib/array/Array<u8>#slice
     (i32.load
      (local.get $0)
     )
     (i32.load offset=4
      (local.get $0)
     )
     (i32.load offset=12
      (i32.load
       (local.get $0)
      )
     )
    )
   )
  )
 )
 (func $contract/Stat#unpack (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.tee $1
    (call $~lib/as-chain/serializer/Decoder#constructor
     (local.get $1)
    )
   )
   (local.tee $2
    (call $~lib/as-chain/asset/Symbol#constructor
     (i32.const 2448)
     (i32.const 0)
    )
   )
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $0)
   (local.get $2)
  )
  (global.set $~argumentsLength
   (i32.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.tee $2
    (call $~lib/as-chain/asset/Asset#constructor@varargs)
   )
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (local.get $2)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $2)
   (i64.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.get $2)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $0)
   (local.get $2)
  )
  (i32.load offset=4
   (local.get $1)
  )
 )
 (func $~lib/as-chain/dbi64/DBI64<contract/Stat>#getEx (param $0 i32) (param $1 i32) (result i32)
  (if
   (i32.eqz
    (local.tee $0
     (call $~lib/as-chain/env/db_get_i64
      (local.get $1)
      (i32.const 0)
      (i32.const 0)
     )
    )
   )
   (return
    (i32.const 0)
   )
  )
  (drop
   (call $~lib/as-chain/env/db_get_i64
    (local.get $1)
    (i32.load offset=4
     (local.tee $1
      (call $~lib/array/Array<u8>#constructor
       (local.get $0)
      )
     )
    )
    (local.get $0)
   )
  )
  (global.set $~argumentsLength
   (i32.const 0)
  )
  (drop
   (call $contract/Stat#unpack
    (local.tee $0
     (call $contract/Stat#constructor@varargs)
    )
    (local.get $1)
   )
  )
  (local.get $0)
 )
 (func $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#getValue (param $0 i32) (result i32)
  (if
   (i32.eqz
    (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
     (local.get $0)
    )
   )
   (return
    (i32.const 0)
   )
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#getEx
   (i32.load
    (local.get $0)
   )
   (i32.load offset=4
    (local.get $0)
   )
  )
 )
 (func $~lib/proton-tsc/modules/store/store/TableStore<contract/Stat>#first (param $0 i32) (result i32)
  (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#getValue
   (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#constructor
    (local.tee $0
     (i32.load
      (i32.load
       (local.get $0)
      )
     )
    )
    (call $~lib/as-chain/env/db_lowerbound_i64
     (i64.load
      (local.get $0)
     )
     (i64.load offset=8
      (local.get $0)
     )
     (i64.load offset=16
      (local.get $0)
     )
     (i64.const 0)
    )
    (i64.const 0)
    (i32.const 0)
   )
  )
 )
 (func $contract/erc20like#readStatRequired (param $0 i32) (result i32)
  (call $~lib/as-chain/system/check
   (i32.ne
    (local.tee $0
     (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Stat>#first
      (i32.load offset=12
       (local.get $0)
      )
     )
    )
    (i32.const 0)
   )
   (i32.const 2608)
  )
  (if
   (i32.eqz
    (local.get $0)
   )
   (unreachable)
  )
  (local.get $0)
 )
 (func $contract/Account#constructor (param $0 i32) (result i32)
  (local $1 i32)
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $1
    (call $~lib/rt/stub/__new
     (i32.const 4)
     (i32.const 23)
    )
   )
   (local.get $0)
  )
  (local.get $1)
 )
 (func $contract/Account#constructor@varargs (result i32)
  (local $0 i32)
  (block $1of1
   (block $0of1
    (block $outOfRange
     (br_table $0of1 $1of1 $outOfRange
      (global.get $~argumentsLength)
     )
    )
    (unreachable)
   )
   (global.set $~argumentsLength
    (i32.const 0)
   )
   (local.set $0
    (call $~lib/as-chain/asset/Asset#constructor@varargs)
   )
  )
  (call $contract/Account#constructor
   (local.get $0)
  )
 )
 (func $contract/Account.get:tableName (result i32)
  (local $0 i32)
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $0
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $0)
   (i64.const 3607749779137757184)
  )
  (local.get $0)
 )
 (func $contract/erc20like#getAccountsTable (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i64)
  (local $8 i64)
  (local.set $3
   (i32.load
    (local.get $0)
   )
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 16)
     (i32.const 24)
    )
   )
   (i32.const 0)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
   (local.get $2)
   (i64.const -1)
  )
  (global.set $~argumentsLength
   (i32.const 0)
  )
  (drop
   (call $contract/Account#constructor@varargs)
  )
  (local.set $4
   (call $contract/Account.get:tableName)
  )
  (drop
   (i64.load
    (call $contract/Account.get:tableName)
   )
  )
  (local.set $5
   (call $~lib/rt/__newArray
    (i32.const 0)
    (i32.const 2)
    (i32.const 18)
    (i32.const 2848)
   )
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $0
    (call $~lib/rt/stub/__new
     (i32.const 16)
     (i32.const 25)
    )
   )
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (i32.const 0)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
   (local.get $0)
   (i64.const -1)
  )
  (local.set $6
   (i64.load
    (local.get $3)
   )
  )
  (local.set $7
   (i64.load
    (local.get $1)
   )
  )
  (local.set $8
   (i64.load
    (local.get $4)
   )
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $1
    (call $~lib/rt/stub/__new
     (i32.const 24)
     (i32.const 26)
    )
   )
   (local.get $6)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
   (local.get $1)
   (local.get $7)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:table
   (local.get $1)
   (local.get $8)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (local.get $5)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $2)
   (local.get $0)
  )
  (local.get $2)
 )
 (func $contract/Allowance#constructor (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 27)
    )
   )
   (local.get $0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $2)
   (local.get $1)
  )
  (local.get $2)
 )
 (func $contract/Allowance#constructor@varargs (result i32)
  (local $0 i32)
  (local $1 i32)
  (block $2of2
   (block $1of2
    (block $0of2
     (block $outOfRange
      (br_table $0of2 $1of2 $2of2 $outOfRange
       (global.get $~argumentsLength)
      )
     )
     (unreachable)
    )
    (call $~lib/as-chain/name/Name#set:N
     (local.tee $0
      (call $~lib/rt/stub/__new
       (i32.const 8)
       (i32.const 5)
      )
     )
     (i64.const 0)
    )
    (call $~lib/as-chain/name/Name#set:N
     (local.get $0)
     (i64.const 0)
    )
   )
   (global.set $~argumentsLength
    (i32.const 0)
   )
   (local.set $1
    (call $~lib/as-chain/asset/Asset#constructor@varargs)
   )
  )
  (call $contract/Allowance#constructor
   (local.get $0)
   (local.get $1)
  )
 )
 (func $contract/Allowance.get:tableName (result i32)
  (local $0 i32)
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $0
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $0)
   (i64.const 3774946787993190400)
  )
  (local.get $0)
 )
 (func $contract/erc20like#getAllowancesTable (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i64)
  (local $8 i64)
  (local.set $3
   (i32.load
    (local.get $0)
   )
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 16)
     (i32.const 28)
    )
   )
   (i32.const 0)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
   (local.get $2)
   (i64.const -1)
  )
  (global.set $~argumentsLength
   (i32.const 0)
  )
  (drop
   (call $contract/Allowance#constructor@varargs)
  )
  (local.set $4
   (call $contract/Allowance.get:tableName)
  )
  (drop
   (i64.load
    (call $contract/Allowance.get:tableName)
   )
  )
  (local.set $5
   (call $~lib/rt/__newArray
    (i32.const 0)
    (i32.const 2)
    (i32.const 18)
    (i32.const 2880)
   )
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $0
    (call $~lib/rt/stub/__new
     (i32.const 16)
     (i32.const 29)
    )
   )
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (i32.const 0)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
   (local.get $0)
   (i64.const -1)
  )
  (local.set $6
   (i64.load
    (local.get $3)
   )
  )
  (local.set $7
   (i64.load
    (local.get $1)
   )
  )
  (local.set $8
   (i64.load
    (local.get $4)
   )
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $1
    (call $~lib/rt/stub/__new
     (i32.const 24)
     (i32.const 30)
    )
   )
   (local.get $6)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
   (local.get $1)
   (local.get $7)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:table
   (local.get $1)
   (local.get $8)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (local.get $5)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $2)
   (local.get $0)
  )
  (local.get $2)
 )
 (func $~lib/as-chain/asset/Symbol#code (param $0 i32) (result i64)
  (i64.shr_u
   (i64.load
    (local.get $0)
   )
   (i64.const 8)
  )
 )
 (func $contract/erc20like#sameSymbol (param $0 i32) (param $1 i32)
  (call $~lib/as-chain/system/check
   (i64.eq
    (call $~lib/as-chain/asset/Symbol#code
     (i32.load offset=8
      (local.get $0)
     )
    )
    (call $~lib/as-chain/asset/Symbol#code
     (i32.load offset=8
      (local.get $1)
     )
    )
   )
   (i32.const 2944)
  )
 )
 (func $~lib/as-chain/action/isAccount (param $0 i32) (result i32)
  (call $~lib/as-chain/env/is_account
   (i64.load
    (local.get $0)
   )
  )
 )
 (func $~lib/as-chain/asset/Symbol#isValid (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i64)
  (block $__inlined_func$~lib/as-chain/asset/isValid (result i32)
   (drop
    (br_if $__inlined_func$~lib/as-chain/asset/isValid
     (i32.const 0)
     (i64.eqz
      (local.tee $3
       (call $~lib/as-chain/asset/Symbol#code
        (local.get $0)
       )
      )
     )
    )
   )
   (drop
    (br_if $__inlined_func$~lib/as-chain/asset/isValid
     (i32.const 0)
     (i64.ne
      (i64.and
       (local.get $3)
       (i64.const -72057594037927936)
      )
      (i64.const 0)
     )
    )
   )
   (loop $for-loop|0
    (if
     (i32.le_s
      (local.get $2)
      (i32.const 6)
     )
     (block $for-break0
      (local.set $1
       (local.get $2)
      )
      (drop
       (br_if $__inlined_func$~lib/as-chain/asset/isValid
        (i32.const 0)
        (i32.eqz
         (select
          (i32.le_u
           (local.tee $0
            (i32.wrap_i64
             (i64.and
              (local.get $3)
              (i64.const 255)
             )
            )
           )
           (i32.const 90)
          )
          (i32.const 0)
          (i32.ge_u
           (local.get $0)
           (i32.const 65)
          )
         )
        )
       )
      )
      (br_if $for-break0
       (i64.eqz
        (i64.and
         (local.tee $3
          (i64.shr_u
           (local.get $3)
           (i64.const 8)
          )
         )
         (i64.const 255)
        )
       )
      )
      (local.set $2
       (i32.add
        (local.get $1)
        (i32.const 1)
       )
      )
      (br $for-loop|0)
     )
    )
   )
   (local.set $1
    (i32.add
     (local.get $1)
     (i32.const 1)
    )
   )
   (loop $for-loop|1
    (if
     (i32.le_s
      (local.get $1)
      (i32.const 6)
     )
     (block
      (drop
       (br_if $__inlined_func$~lib/as-chain/asset/isValid
        (i32.const 0)
        (i64.ne
         (i64.and
          (local.tee $3
           (i64.shr_u
            (local.get $3)
            (i64.const 8)
           )
          )
          (i64.const 255)
         )
         (i64.const 0)
        )
       )
      )
      (local.set $1
       (i32.add
        (local.get $1)
        (i32.const 1)
       )
      )
      (br $for-loop|1)
     )
    )
   )
   (i32.const 1)
  )
 )
 (func $~lib/as-chain/asset/Asset#isValid (param $0 i32) (result i32)
  (if (result i32)
   (if (result i32)
    (i64.ge_s
     (i64.load
      (local.get $0)
     )
     (i64.const -4611686018427387903)
    )
    (i64.le_s
     (i64.load
      (local.get $0)
     )
     (i64.const 4611686018427387903)
    )
    (i32.const 0)
   )
   (call $~lib/as-chain/asset/Symbol#isValid
    (i32.load offset=8
     (local.get $0)
    )
   )
   (i32.const 0)
  )
 )
 (func $contract/Stat#getPrimaryValue (param $0 i32) (result i64)
  (call $~lib/as-chain/asset/Symbol#code
   (i32.load
    (local.get $0)
   )
  )
 )
 (func $~lib/as-chain/mi/MultiIndex<contract/Stat>#find (param $0 i32) (param $1 i64) (result i32)
  (local $2 i32)
  (block $__inlined_func$~lib/as-chain/dbi64/DBI64<contract/Stat>#find (result i32)
   (if
    (i32.ge_s
     (local.tee $2
      (call $~lib/as-chain/env/db_find_i64
       (i64.load
        (local.tee $0
         (i32.load
          (local.get $0)
         )
        )
       )
       (i64.load offset=8
        (local.get $0)
       )
       (i64.load offset=16
        (local.get $0)
       )
       (local.get $1)
      )
     )
     (i32.const 0)
    )
    (br $__inlined_func$~lib/as-chain/dbi64/DBI64<contract/Stat>#find
     (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#constructor
      (local.get $0)
      (local.get $2)
      (local.get $1)
      (i32.const 1)
     )
    )
   )
   (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#constructor
    (local.get $0)
    (local.get $2)
    (i64.const 0)
    (i32.const 0)
   )
  )
 )
 (func $~lib/as-chain/serializer/Encoder#constructor (param $0 i32) (result i32)
  (local $1 i32)
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $1
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 32)
    )
   )
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $1)
   (i32.const 0)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $1)
   (call $~lib/array/Array<u8>#constructor
    (local.get $0)
   )
  )
  (local.get $1)
 )
 (func $~lib/as-chain/serializer/Encoder#incPos (param $0 i32) (param $1 i32)
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (i32.add
    (local.get $1)
    (i32.load offset=4
     (local.get $0)
    )
   )
  )
  (if
   (i32.gt_u
    (i32.load offset=4
     (local.get $0)
    )
    (i32.load offset=12
     (i32.load
      (local.get $0)
     )
    )
   )
   (call $~lib/as-chain/system/check
    (i32.const 0)
    (i32.const 3312)
   )
  )
 )
 (func $~lib/as-chain/serializer/Encoder#pack (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local.set $1
   (i32.load offset=12
    (local.tee $2
     (call $~lib/as-chain/serializer/Packer#pack@virtual
      (local.get $1)
     )
    )
   )
  )
  (if
   (i32.lt_u
    (i32.load offset=12
     (i32.load
      (local.get $0)
     )
    )
    (i32.add
     (local.get $1)
     (i32.load offset=4
      (local.get $0)
     )
    )
   )
   (call $~lib/as-chain/system/check
    (i32.const 0)
    (i32.const 3232)
   )
  )
  (local.set $2
   (i32.load offset=4
    (local.get $2)
   )
  )
  (local.set $3
   (i32.load offset=4
    (local.get $0)
   )
  )
  (call $~lib/as-chain/serializer/Encoder#incPos
   (local.get $0)
   (local.get $1)
  )
  (drop
   (call $~lib/as-chain/env/memcpy
    (i32.add
     (local.get $3)
     (i32.load offset=4
      (i32.load
       (local.get $0)
      )
     )
    )
    (local.get $2)
    (local.get $1)
   )
  )
 )
 (func $~lib/as-chain/serializer/Encoder#getBytes (param $0 i32) (result i32)
  (call $~lib/array/Array<u8>#slice
   (i32.load
    (local.get $0)
   )
   (i32.const 0)
   (i32.load offset=4
    (local.get $0)
   )
  )
 )
 (func $contract/Stat#pack (param $0 i32) (result i32)
  (local $1 i32)
  (call $~lib/as-chain/serializer/Encoder#pack
   (local.tee $1
    (call $~lib/as-chain/serializer/Encoder#constructor
     (block (result i32)
      (drop
       (i32.load
        (local.get $0)
       )
      )
      (drop
       (i32.load offset=4
        (local.get $0)
       )
      )
      (drop
       (i32.load offset=8
        (local.get $0)
       )
      )
      (i32.const 32)
     )
    )
   )
   (i32.load
    (local.get $0)
   )
  )
  (call $~lib/as-chain/serializer/Encoder#pack
   (local.get $1)
   (i32.load offset=4
    (local.get $0)
   )
  )
  (call $~lib/as-chain/serializer/Encoder#pack
   (local.get $1)
   (i32.load offset=8
    (local.get $0)
   )
  )
  (call $~lib/as-chain/serializer/Encoder#getBytes
   (local.get $1)
  )
 )
 (func $~lib/array/Array<~lib/as-chain/idxdb/IDXDB>#__get (param $0 i32) (param $1 i32) (result i32)
  (if
   (i32.ge_u
    (local.get $1)
    (i32.load offset=12
     (local.get $0)
    )
   )
   (unreachable)
  )
  (if
   (i32.eqz
    (local.tee $0
     (i32.load
      (i32.add
       (i32.load offset=4
        (local.get $0)
       )
       (i32.shl
        (local.get $1)
        (i32.const 2)
       )
      )
     )
    )
   )
   (unreachable)
  )
  (local.get $0)
 )
 (func $contract/Stat#getSecondaryValue (result i32)
  (local $0 i32)
  (local $1 i32)
  (call $~lib/as-chain/system/check
   (i32.const 0)
   (i32.const 3392)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $0
    (call $~lib/rt/stub/__new
     (i32.const 16)
     (i32.const 34)
    )
   )
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $0)
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:rtId
   (local.get $0)
   (i32.const 0)
  )
  (call $~lib/memory/memory.fill
   (local.tee $1
    (call $~lib/rt/stub/__new
     (i32.const 64)
     (i32.const 0)
    )
   )
   (i32.const 64)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $0)
   (i32.const 64)
  )
  (call $~lib/rt/common/OBJECT#set:rtId
   (local.get $0)
   (i32.const 0)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $1
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 33)
    )
   )
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $1)
   (local.get $0)
  )
  (local.get $1)
 )
 (func $~lib/proton-tsc/modules/store/store/TableStore<contract/Stat>#store (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i64)
  (local $4 i64)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i64)
  (local $9 i32)
  (local $10 i32)
  (local.set $4
   (call $contract/Stat#getPrimaryValue
    (local.get $1)
   )
  )
  (call $~lib/as-chain/system/check
   (i32.eqz
    (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
     (call $~lib/as-chain/mi/MultiIndex<contract/Stat>#find
      (i32.load
       (local.get $0)
      )
      (local.get $4)
     )
    )
   )
   (i32.const 1200)
  )
  (local.set $7
   (i32.load
    (local.tee $6
     (i32.load
      (local.get $0)
     )
    )
   )
  )
  (local.set $3
   (call $contract/Stat#getPrimaryValue
    (local.get $1)
   )
  )
  (local.set $8
   (i64.load
    (local.get $2)
   )
  )
  (local.set $10
   (i32.load offset=12
    (local.tee $9
     (call $contract/Stat#pack
      (local.get $1)
     )
    )
   )
  )
  (drop
   (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#constructor
    (local.get $7)
    (call $~lib/as-chain/env/db_store_i64
     (i64.load offset=8
      (local.get $7)
     )
     (i64.load offset=16
      (local.get $7)
     )
     (local.get $8)
     (local.get $3)
     (i32.load offset=4
      (local.get $9)
     )
     (local.get $10)
    )
    (local.get $3)
    (i32.const 1)
   )
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $5)
     (i32.load offset=12
      (i32.load offset=4
       (local.get $6)
      )
     )
    )
    (block
     (call $~lib/as-chain/idxdb/IDXDB#storeEx@virtual
      (call $~lib/array/Array<~lib/as-chain/idxdb/IDXDB>#__get
       (i32.load offset=4
        (local.get $6)
       )
       (local.get $5)
      )
      (call $contract/Stat#getPrimaryValue
       (local.get $1)
      )
      (call $contract/Stat#getSecondaryValue)
      (i64.load
       (local.get $2)
      )
     )
     (local.set $5
      (i32.add
       (local.get $5)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (if
   (i64.ge_u
    (local.tee $3
     (call $contract/Stat#getPrimaryValue
      (local.get $1)
     )
    )
    (i64.load offset=8
     (local.get $6)
    )
   )
   (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
    (local.get $6)
    (select
     (i64.const -2)
     (i64.add
      (local.get $3)
      (i64.const 1)
     )
     (i64.ge_u
      (local.get $3)
      (i64.const -2)
     )
    )
   )
  )
  (if
   (i64.ge_u
    (local.get $4)
    (i64.load offset=8
     (local.get $0)
    )
   )
   (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
    (local.get $0)
    (select
     (i64.const -2)
     (i64.add
      (local.get $4)
      (i64.const 1)
     )
     (i64.ge_u
      (local.get $4)
      (i64.const -2)
     )
    )
   )
  )
 )
 (func $~lib/as-chain/action/requireAuth (param $0 i32)
  (call $~lib/as-chain/env/require_auth
   (i64.load
    (local.get $0)
   )
  )
 )
 (func $~lib/as-chain/asset/Symbol.fromU64 (param $0 i64) (result i32)
  (local $1 i32)
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $1
    (call $~lib/as-chain/asset/Symbol#constructor
     (i32.const 2448)
     (i32.const 0)
    )
   )
   (local.get $0)
  )
  (local.get $1)
 )
 (func $~lib/as-chain/mi/MultiIndex<contract/Stat>#update (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i64)
  (call $~lib/as-chain/system/check
   (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
    (local.get $1)
   )
   (i32.const 3648)
  )
  (call $~lib/as-chain/system/check
   (i64.eq
    (local.tee $5
     (call $contract/Stat#getPrimaryValue
      (local.get $2)
     )
    )
    (block $__inlined_func$~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#get:primary (result i64)
     (call $~lib/as-chain/system/check
      (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
       (local.get $1)
      )
      (i32.const 3712)
     )
     (if
      (i32.load8_u offset=8
       (local.get $1)
      )
      (br $__inlined_func$~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#get:primary
       (i64.load offset=16
        (local.get $1)
       )
      )
     )
     (if
      (i32.eqz
       (local.tee $6
        (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#getValue
         (local.get $1)
        )
       )
      )
      (unreachable)
     )
     (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:table
      (local.get $1)
      (call $contract/Stat#getPrimaryValue
       (local.get $6)
      )
     )
     (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#set:validPrimary
      (local.get $1)
      (i32.const 1)
     )
     (i64.load offset=16
      (local.get $1)
     )
    )
   )
   (i32.const 3792)
  )
  (drop
   (i32.load
    (local.get $0)
   )
  )
  (local.set $7
   (i64.load
    (local.get $3)
   )
  )
  (local.set $6
   (i32.load offset=12
    (local.tee $2
     (call $contract/Stat#pack
      (local.get $2)
     )
    )
   )
  )
  (call $~lib/as-chain/env/db_update_i64
   (i32.load offset=4
    (local.get $1)
   )
   (local.get $7)
   (i32.load offset=4
    (local.get $2)
   )
   (local.get $6)
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $4)
     (i32.load offset=12
      (i32.load offset=4
       (local.get $0)
      )
     )
    )
    (block
     (local.set $1
      (call $~lib/as-chain/idxdb/IDXDB#findPrimaryEx@virtual
       (call $~lib/array/Array<~lib/as-chain/idxdb/IDXDB>#__get
        (i32.load offset=4
         (local.get $0)
        )
        (local.get $4)
       )
      )
     )
     (local.set $2
      (call $contract/Stat#getSecondaryValue)
     )
     (if
      (i32.eqz
       (if (result i32)
        (i32.eq
         (i32.load
          (i32.load offset=4
           (local.get $1)
          )
         )
         (i32.load
          (local.get $2)
         )
        )
        (i32.eq
         (i32.load offset=4
          (i32.load offset=4
           (local.get $1)
          )
         )
         (i32.load offset=4
          (local.get $2)
         )
        )
        (i32.const 0)
       )
      )
      (call $~lib/as-chain/idxdb/IDXDB#updateEx@virtual
       (call $~lib/array/Array<~lib/as-chain/idxdb/IDXDB>#__get
        (i32.load offset=4
         (local.get $0)
        )
        (local.get $4)
       )
       (i32.load
        (local.get $1)
       )
       (call $contract/Stat#getSecondaryValue)
       (i64.load
        (local.get $3)
       )
      )
     )
     (local.set $4
      (i32.add
       (local.get $4)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (if
   (i64.ge_u
    (local.get $5)
    (i64.load offset=8
     (local.get $0)
    )
   )
   (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
    (local.get $0)
    (select
     (i64.const -2)
     (i64.add
      (local.get $5)
      (i64.const 1)
     )
     (i64.ge_u
      (local.get $5)
      (i64.const -2)
     )
    )
   )
  )
 )
 (func $~lib/as-chain/dbi64/PrimaryIterator<contract/Account>#constructor (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32) (result i32)
  (local $4 i32)
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $4
    (call $~lib/rt/stub/__new
     (i32.const 24)
     (i32.const 37)
    )
   )
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $4)
   (i32.const 0)
  )
  (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#set:validPrimary
   (local.get $4)
   (i32.const 0)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:table
   (local.get $4)
   (i64.const 0)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $4)
   (local.get $0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $4)
   (local.get $1)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:table
   (local.get $4)
   (local.get $2)
  )
  (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#set:validPrimary
   (local.get $4)
   (local.get $3)
  )
  (local.get $4)
 )
 (func $~lib/as-chain/mi/MultiIndex<contract/Account>#find (param $0 i32) (param $1 i64) (result i32)
  (local $2 i32)
  (block $__inlined_func$~lib/as-chain/dbi64/DBI64<contract/Account>#find (result i32)
   (if
    (i32.ge_s
     (local.tee $2
      (call $~lib/as-chain/env/db_find_i64
       (i64.load
        (local.tee $0
         (i32.load
          (local.get $0)
         )
        )
       )
       (i64.load offset=8
        (local.get $0)
       )
       (i64.load offset=16
        (local.get $0)
       )
       (local.get $1)
      )
     )
     (i32.const 0)
    )
    (br $__inlined_func$~lib/as-chain/dbi64/DBI64<contract/Account>#find
     (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Account>#constructor
      (local.get $0)
      (local.get $2)
      (local.get $1)
      (i32.const 1)
     )
    )
   )
   (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Account>#constructor
    (local.get $0)
    (local.get $2)
    (i64.const 0)
    (i32.const 0)
   )
  )
 )
 (func $contract/Account#unpack (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local.set $1
   (call $~lib/as-chain/serializer/Decoder#constructor
    (local.get $1)
   )
  )
  (global.set $~argumentsLength
   (i32.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.tee $2
    (call $~lib/as-chain/asset/Asset#constructor@varargs)
   )
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $0)
   (local.get $2)
  )
  (i32.load offset=4
   (local.get $1)
  )
 )
 (func $~lib/as-chain/dbi64/DBI64<contract/Account>#getEx (param $0 i32) (param $1 i32) (result i32)
  (if
   (i32.eqz
    (local.tee $0
     (call $~lib/as-chain/env/db_get_i64
      (local.get $1)
      (i32.const 0)
      (i32.const 0)
     )
    )
   )
   (return
    (i32.const 0)
   )
  )
  (drop
   (call $~lib/as-chain/env/db_get_i64
    (local.get $1)
    (i32.load offset=4
     (local.tee $1
      (call $~lib/array/Array<u8>#constructor
       (local.get $0)
      )
     )
    )
    (local.get $0)
   )
  )
  (global.set $~argumentsLength
   (i32.const 0)
  )
  (drop
   (call $contract/Account#unpack
    (local.tee $0
     (call $contract/Account#constructor@varargs)
    )
    (local.get $1)
   )
  )
  (local.get $0)
 )
 (func $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#get (param $0 i32) (param $1 i64) (result i32)
  (local $2 i32)
  (local $3 i32)
  (block $__inlined_func$~lib/as-chain/mi/MultiIndex<contract/Account>#getByKey (result i32)
   (drop
    (br_if $__inlined_func$~lib/as-chain/mi/MultiIndex<contract/Account>#getByKey
     (i32.const 0)
     (i32.eqz
      (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
       (local.tee $2
        (call $~lib/as-chain/mi/MultiIndex<contract/Account>#find
         (local.tee $0
          (i32.load
           (local.get $0)
          )
         )
         (local.get $1)
        )
       )
      )
     )
    )
   )
   (block $__inlined_func$~lib/as-chain/dbi64/DBI64<contract/Account>#get (result i32)
    (local.set $3
     (i32.load
      (local.get $0)
     )
    )
    (drop
     (br_if $__inlined_func$~lib/as-chain/dbi64/DBI64<contract/Account>#get
      (i32.const 0)
      (i32.eqz
       (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
        (local.tee $0
         (local.get $2)
        )
       )
      )
     )
    )
    (call $~lib/as-chain/dbi64/DBI64<contract/Account>#getEx
     (local.get $3)
     (i32.load offset=4
      (local.get $0)
     )
    )
   )
  )
 )
 (func $contract/Account#getPrimaryValue (param $0 i32) (result i64)
  (call $~lib/as-chain/asset/Symbol#code
   (i32.load offset=8
    (i32.load
     (local.get $0)
    )
   )
  )
 )
 (func $contract/Account#pack (param $0 i32) (result i32)
  (local $1 i32)
  (call $~lib/as-chain/serializer/Encoder#pack
   (local.tee $1
    (call $~lib/as-chain/serializer/Encoder#constructor
     (block (result i32)
      (drop
       (i32.load
        (local.get $0)
       )
      )
      (i32.const 16)
     )
    )
   )
   (i32.load
    (local.get $0)
   )
  )
  (call $~lib/as-chain/serializer/Encoder#getBytes
   (local.get $1)
  )
 )
 (func $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#store (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i64)
  (local $4 i64)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i64)
  (local $9 i32)
  (local $10 i32)
  (local.set $4
   (call $contract/Account#getPrimaryValue
    (local.get $1)
   )
  )
  (call $~lib/as-chain/system/check
   (i32.eqz
    (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
     (call $~lib/as-chain/mi/MultiIndex<contract/Account>#find
      (i32.load
       (local.get $0)
      )
      (local.get $4)
     )
    )
   )
   (i32.const 1200)
  )
  (local.set $7
   (i32.load
    (local.tee $6
     (i32.load
      (local.get $0)
     )
    )
   )
  )
  (local.set $3
   (call $contract/Account#getPrimaryValue
    (local.get $1)
   )
  )
  (local.set $8
   (i64.load
    (local.get $2)
   )
  )
  (local.set $10
   (i32.load offset=12
    (local.tee $9
     (call $contract/Account#pack
      (local.get $1)
     )
    )
   )
  )
  (drop
   (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Account>#constructor
    (local.get $7)
    (call $~lib/as-chain/env/db_store_i64
     (i64.load offset=8
      (local.get $7)
     )
     (i64.load offset=16
      (local.get $7)
     )
     (local.get $8)
     (local.get $3)
     (i32.load offset=4
      (local.get $9)
     )
     (local.get $10)
    )
    (local.get $3)
    (i32.const 1)
   )
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $5)
     (i32.load offset=12
      (i32.load offset=4
       (local.get $6)
      )
     )
    )
    (block
     (call $~lib/as-chain/idxdb/IDXDB#storeEx@virtual
      (call $~lib/array/Array<~lib/as-chain/idxdb/IDXDB>#__get
       (i32.load offset=4
        (local.get $6)
       )
       (local.get $5)
      )
      (call $contract/Account#getPrimaryValue
       (local.get $1)
      )
      (call $contract/Stat#getSecondaryValue)
      (i64.load
       (local.get $2)
      )
     )
     (local.set $5
      (i32.add
       (local.get $5)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (if
   (i64.ge_u
    (local.tee $3
     (call $contract/Account#getPrimaryValue
      (local.get $1)
     )
    )
    (i64.load offset=8
     (local.get $6)
    )
   )
   (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
    (local.get $6)
    (select
     (i64.const -2)
     (i64.add
      (local.get $3)
      (i64.const 1)
     )
     (i64.ge_u
      (local.get $3)
      (i64.const -2)
     )
    )
   )
  )
  (if
   (i64.ge_u
    (local.get $4)
    (i64.load offset=8
     (local.get $0)
    )
   )
   (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
    (local.get $0)
    (select
     (i64.const -2)
     (i64.add
      (local.get $4)
      (i64.const 1)
     )
     (i64.ge_u
      (local.get $4)
      (i64.const -2)
     )
    )
   )
  )
 )
 (func $~lib/as-chain/mi/MultiIndex<contract/Account>#update (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i32)
  (local $8 i64)
  (call $~lib/as-chain/system/check
   (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
    (local.get $1)
   )
   (i32.const 3648)
  )
  (call $~lib/as-chain/system/check
   (i64.eq
    (local.tee $6
     (call $contract/Account#getPrimaryValue
      (local.get $2)
     )
    )
    (block $__inlined_func$~lib/as-chain/dbi64/PrimaryIterator<contract/Account>#get:primary (result i64)
     (call $~lib/as-chain/system/check
      (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
       (local.tee $4
        (local.get $1)
       )
      )
      (i32.const 3712)
     )
     (if
      (i32.load8_u offset=8
       (local.get $4)
      )
      (br $__inlined_func$~lib/as-chain/dbi64/PrimaryIterator<contract/Account>#get:primary
       (i64.load offset=16
        (local.get $4)
       )
      )
     )
     (if
      (i32.eqz
       (local.tee $7
        (block $__inlined_func$~lib/as-chain/dbi64/PrimaryIterator<contract/Account>#getValue (result i32)
         (drop
          (br_if $__inlined_func$~lib/as-chain/dbi64/PrimaryIterator<contract/Account>#getValue
           (i32.const 0)
           (i32.eqz
            (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
             (local.get $4)
            )
           )
          )
         )
         (call $~lib/as-chain/dbi64/DBI64<contract/Account>#getEx
          (i32.load
           (local.get $4)
          )
          (i32.load offset=4
           (local.get $4)
          )
         )
        )
       )
      )
      (unreachable)
     )
     (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:table
      (local.get $4)
      (call $contract/Account#getPrimaryValue
       (local.get $7)
      )
     )
     (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#set:validPrimary
      (local.get $4)
      (i32.const 1)
     )
     (i64.load offset=16
      (local.get $4)
     )
    )
   )
   (i32.const 3792)
  )
  (drop
   (i32.load
    (local.get $0)
   )
  )
  (local.set $8
   (i64.load
    (local.get $3)
   )
  )
  (local.set $4
   (i32.load offset=12
    (local.tee $2
     (call $contract/Account#pack
      (local.get $2)
     )
    )
   )
  )
  (call $~lib/as-chain/env/db_update_i64
   (i32.load offset=4
    (local.get $1)
   )
   (local.get $8)
   (i32.load offset=4
    (local.get $2)
   )
   (local.get $4)
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $5)
     (i32.load offset=12
      (i32.load offset=4
       (local.get $0)
      )
     )
    )
    (block
     (local.set $1
      (call $~lib/as-chain/idxdb/IDXDB#findPrimaryEx@virtual
       (call $~lib/array/Array<~lib/as-chain/idxdb/IDXDB>#__get
        (i32.load offset=4
         (local.get $0)
        )
        (local.get $5)
       )
      )
     )
     (local.set $2
      (call $contract/Stat#getSecondaryValue)
     )
     (if
      (i32.eqz
       (if (result i32)
        (i32.eq
         (i32.load
          (i32.load offset=4
           (local.get $1)
          )
         )
         (i32.load
          (local.get $2)
         )
        )
        (i32.eq
         (i32.load offset=4
          (i32.load offset=4
           (local.get $1)
          )
         )
         (i32.load offset=4
          (local.get $2)
         )
        )
        (i32.const 0)
       )
      )
      (call $~lib/as-chain/idxdb/IDXDB#updateEx@virtual
       (call $~lib/array/Array<~lib/as-chain/idxdb/IDXDB>#__get
        (i32.load offset=4
         (local.get $0)
        )
        (local.get $5)
       )
       (i32.load
        (local.get $1)
       )
       (call $contract/Stat#getSecondaryValue)
       (i64.load
        (local.get $3)
       )
      )
     )
     (local.set $5
      (i32.add
       (local.get $5)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (if
   (i64.ge_u
    (local.get $6)
    (i64.load offset=8
     (local.get $0)
    )
   )
   (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
    (local.get $0)
    (select
     (i64.const -2)
     (i64.add
      (local.get $6)
      (i64.const 1)
     )
     (i64.ge_u
      (local.get $6)
      (i64.const -2)
     )
    )
   )
  )
 )
 (func $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#set (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i64)
  (local $4 i32)
  (if
   (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#get
    (local.get $0)
    (call $contract/Account#getPrimaryValue
     (local.get $1)
    )
   )
   (block
    (local.set $3
     (call $contract/Account#getPrimaryValue
      (local.get $1)
     )
    )
    (call $~lib/as-chain/system/check
     (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
      (local.tee $4
       (call $~lib/as-chain/mi/MultiIndex<contract/Account>#find
        (i32.load
         (local.get $0)
        )
        (local.get $3)
       )
      )
     )
     (i32.const 1424)
    )
    (call $~lib/as-chain/mi/MultiIndex<contract/Account>#update
     (i32.load
      (local.get $0)
     )
     (local.get $4)
     (local.get $1)
     (local.get $2)
    )
   )
   (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#store
    (local.get $0)
    (local.get $1)
    (local.get $2)
   )
  )
 )
 (func $~lib/as-chain/action/requireRecipient (param $0 i32)
  (call $~lib/as-chain/env/require_recipient
   (i64.load
    (local.get $0)
   )
  )
 )
 (func $~lib/util/number/itoa64 (param $0 i64) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (if
   (i64.eqz
    (local.get $0)
   )
   (return
    (i32.const 4032)
   )
  )
  (if
   (i64.le_u
    (local.tee $0
     (select
      (i64.sub
       (i64.const 0)
       (local.get $0)
      )
      (local.get $0)
      (local.tee $3
       (i32.wrap_i64
        (i64.shr_u
         (local.get $0)
         (i64.const 63)
        )
       )
      )
     )
    )
    (i64.const 4294967295)
   )
   (block
    (local.set $5
     (local.tee $4
      (call $~lib/rt/stub/__new
       (i32.shl
        (local.tee $2
         (i32.add
          (local.get $3)
          (select
           (select
            (i32.add
             (i32.ge_u
              (local.tee $1
               (i32.wrap_i64
                (local.get $0)
               )
              )
              (i32.const 10)
             )
             (i32.const 1)
            )
            (i32.add
             (i32.add
              (i32.ge_u
               (local.get $1)
               (i32.const 10000)
              )
              (i32.const 3)
             )
             (i32.ge_u
              (local.get $1)
              (i32.const 1000)
             )
            )
            (i32.lt_u
             (local.get $1)
             (i32.const 100)
            )
           )
           (select
            (i32.add
             (i32.ge_u
              (local.get $1)
              (i32.const 1000000)
             )
             (i32.const 6)
            )
            (i32.add
             (i32.add
              (i32.ge_u
               (local.get $1)
               (i32.const 1000000000)
              )
              (i32.const 8)
             )
             (i32.ge_u
              (local.get $1)
              (i32.const 100000000)
             )
            )
            (i32.lt_u
             (local.get $1)
             (i32.const 10000000)
            )
           )
           (i32.lt_u
            (local.get $1)
            (i32.const 100000)
           )
          )
         )
        )
        (i32.const 1)
       )
       (i32.const 1)
      )
     )
    )
    (loop $do-continue|0
     (i32.store16
      (i32.add
       (local.get $5)
       (i32.shl
        (local.tee $2
         (i32.sub
          (local.get $2)
          (i32.const 1)
         )
        )
        (i32.const 1)
       )
      )
      (i32.add
       (i32.rem_u
        (local.get $1)
        (i32.const 10)
       )
       (i32.const 48)
      )
     )
     (br_if $do-continue|0
      (local.tee $1
       (i32.div_u
        (local.get $1)
        (i32.const 10)
       )
      )
     )
    )
   )
   (block
    (local.set $2
     (local.tee $4
      (call $~lib/rt/stub/__new
       (i32.shl
        (local.tee $1
         (i32.add
          (local.get $3)
          (select
           (select
            (i32.add
             (i32.add
              (i64.ge_u
               (local.get $0)
               (i64.const 100000000000)
              )
              (i32.const 10)
             )
             (i64.ge_u
              (local.get $0)
              (i64.const 10000000000)
             )
            )
            (i32.add
             (i32.add
              (i64.ge_u
               (local.get $0)
               (i64.const 100000000000000)
              )
              (i32.const 13)
             )
             (i64.ge_u
              (local.get $0)
              (i64.const 10000000000000)
             )
            )
            (i64.lt_u
             (local.get $0)
             (i64.const 1000000000000)
            )
           )
           (select
            (i32.add
             (i64.ge_u
              (local.get $0)
              (i64.const 10000000000000000)
             )
             (i32.const 16)
            )
            (i32.add
             (i32.add
              (i64.ge_u
               (local.get $0)
               (i64.const -8446744073709551616)
              )
              (i32.const 18)
             )
             (i64.ge_u
              (local.get $0)
              (i64.const 1000000000000000000)
             )
            )
            (i64.lt_u
             (local.get $0)
             (i64.const 100000000000000000)
            )
           )
           (i64.lt_u
            (local.get $0)
            (i64.const 1000000000000000)
           )
          )
         )
        )
        (i32.const 1)
       )
       (i32.const 1)
      )
     )
    )
    (loop $do-continue|00
     (i32.store16
      (i32.add
       (local.get $2)
       (i32.shl
        (local.tee $1
         (i32.sub
          (local.get $1)
          (i32.const 1)
         )
        )
        (i32.const 1)
       )
      )
      (i32.add
       (i32.wrap_i64
        (i64.rem_u
         (local.get $0)
         (i64.const 10)
        )
       )
       (i32.const 48)
      )
     )
     (br_if $do-continue|00
      (i64.ne
       (local.tee $0
        (i64.div_u
         (local.get $0)
         (i64.const 10)
        )
       )
       (i64.const 0)
      )
     )
    )
   )
  )
  (if
   (local.get $3)
   (i32.store16
    (local.get $4)
    (i32.const 45)
   )
  )
  (local.get $4)
 )
 (func $~lib/string/String#padStart (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local.set $4
   (i32.shl
    (call $~lib/string/String#get:length
     (local.get $0)
    )
    (i32.const 1)
   )
  )
  (if
   (select
    (i32.const 1)
    (i32.eqz
     (local.tee $3
      (i32.shl
       (call $~lib/string/String#get:length
        (i32.const 4032)
       )
       (i32.const 1)
      )
     )
    )
    (i32.gt_u
     (local.get $4)
     (local.tee $2
      (i32.shl
       (local.get $1)
       (i32.const 1)
      )
     )
    )
   )
   (return
    (local.get $0)
   )
  )
  (local.set $1
   (call $~lib/rt/stub/__new
    (local.get $2)
    (i32.const 1)
   )
  )
  (if
   (i32.gt_u
    (local.tee $2
     (i32.sub
      (local.get $2)
      (local.get $4)
     )
    )
    (local.get $3)
   )
   (block
    (local.set $7
     (i32.mul
      (local.tee $5
       (i32.div_u
        (i32.sub
         (local.get $2)
         (i32.const 2)
        )
        (local.get $3)
       )
      )
      (local.get $3)
     )
    )
    (local.set $5
     (i32.mul
      (local.get $3)
      (local.get $5)
     )
    )
    (loop $while-continue|0
     (if
      (i32.gt_u
       (local.get $5)
       (local.get $6)
      )
      (block
       (call $~lib/memory/memory.copy
        (i32.add
         (local.get $1)
         (local.get $6)
        )
        (i32.const 4032)
        (local.get $3)
       )
       (local.set $6
        (i32.add
         (local.get $3)
         (local.get $6)
        )
       )
       (br $while-continue|0)
      )
     )
    )
    (call $~lib/memory/memory.copy
     (i32.add
      (local.get $1)
      (local.get $7)
     )
     (i32.const 4032)
     (i32.sub
      (local.get $2)
      (local.get $7)
     )
    )
   )
   (call $~lib/memory/memory.copy
    (local.get $1)
    (i32.const 4032)
    (local.get $2)
   )
  )
  (call $~lib/memory/memory.copy
   (i32.add
    (local.get $1)
    (local.get $2)
   )
   (local.get $0)
   (local.get $4)
  )
  (local.get $1)
 )
 (func $~lib/string/String#slice (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (local.set $3
   (call $~lib/string/String#get:length
    (local.get $0)
   )
  )
  (local.set $1
   (if (result i32)
    (i32.lt_s
     (local.get $1)
     (i32.const 0)
    )
    (select
     (local.tee $1
      (i32.add
       (local.get $1)
       (local.get $3)
      )
     )
     (i32.const 0)
     (i32.gt_s
      (local.get $1)
      (i32.const 0)
     )
    )
    (select
     (local.get $1)
     (local.get $3)
     (i32.lt_s
      (local.get $1)
      (local.get $3)
     )
    )
   )
  )
  (if
   (i32.le_s
    (local.tee $2
     (i32.sub
      (if (result i32)
       (i32.lt_s
        (local.get $2)
        (i32.const 0)
       )
       (select
        (local.tee $2
         (i32.add
          (local.get $2)
          (local.get $3)
         )
        )
        (i32.const 0)
        (i32.gt_s
         (local.get $2)
         (i32.const 0)
        )
       )
       (select
        (local.get $2)
        (local.get $3)
        (i32.lt_s
         (local.get $2)
         (local.get $3)
        )
       )
      )
      (local.get $1)
     )
    )
    (i32.const 0)
   )
   (return
    (i32.const 2448)
   )
  )
  (call $~lib/memory/memory.copy
   (local.tee $3
    (call $~lib/rt/stub/__new
     (local.tee $2
      (i32.shl
       (local.get $2)
       (i32.const 1)
      )
     )
     (i32.const 1)
    )
   )
   (i32.add
    (local.get $0)
    (i32.shl
     (local.get $1)
     (i32.const 1)
    )
   )
   (local.get $2)
  )
  (local.get $3)
 )
 (func $~lib/string/String.__concat (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (block $__inlined_func$~lib/string/String#concat
   (if
    (i32.eqz
     (local.tee $2
      (i32.add
       (local.tee $3
        (i32.shl
         (call $~lib/string/String#get:length
          (local.get $0)
         )
         (i32.const 1)
        )
       )
       (local.tee $4
        (i32.shl
         (call $~lib/string/String#get:length
          (local.get $1)
         )
         (i32.const 1)
        )
       )
      )
     )
    )
    (block
     (local.set $2
      (i32.const 2448)
     )
     (br $__inlined_func$~lib/string/String#concat)
    )
   )
   (call $~lib/memory/memory.copy
    (local.tee $2
     (call $~lib/rt/stub/__new
      (local.get $2)
      (i32.const 1)
     )
    )
    (local.get $0)
    (local.get $3)
   )
   (call $~lib/memory/memory.copy
    (i32.add
     (local.get $2)
     (local.get $3)
    )
    (local.get $1)
    (local.get $4)
   )
  )
  (local.get $2)
 )
 (func $~lib/typedarray/Uint8Array#constructor (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (block (result i32)
    (if
     (i32.eqz
      (local.tee $1
       (call $~lib/rt/stub/__new
        (i32.const 12)
        (i32.const 39)
       )
      )
     )
     (local.set $1
      (call $~lib/rt/stub/__new
       (i32.const 12)
       (i32.const 2)
      )
     )
    )
    (local.get $1)
   )
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $1)
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $1)
   (i32.const 0)
  )
  (if
   (i32.gt_u
    (local.get $0)
    (i32.const 1073741820)
   )
   (unreachable)
  )
  (call $~lib/memory/memory.fill
   (local.tee $2
    (call $~lib/rt/stub/__new
     (local.get $0)
     (i32.const 0)
    )
   )
   (local.get $0)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $1)
   (local.get $2)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $1)
   (local.get $2)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $1)
   (local.get $0)
  )
  (local.get $1)
 )
 (func $~lib/rt/stub/__renew (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (if
   (i32.gt_u
    (local.get $1)
    (i32.const 1073741804)
   )
   (unreachable)
  )
  (local.set $3
   (i32.add
    (local.get $1)
    (i32.const 16)
   )
  )
  (if
   (i32.eqz
    (select
     (i32.eqz
      (i32.and
       (local.tee $0
        (i32.sub
         (local.get $0)
         (i32.const 16)
        )
       )
       (i32.const 15)
      )
     )
     (i32.const 0)
     (local.get $0)
    )
   )
   (unreachable)
  )
  (local.set $6
   (i32.eq
    (global.get $~lib/rt/stub/offset)
    (i32.add
     (local.get $0)
     (local.tee $4
      (i32.load
       (local.tee $5
        (i32.sub
         (local.get $0)
         (i32.const 4)
        )
       )
      )
     )
    )
   )
  )
  (local.set $2
   (i32.sub
    (i32.and
     (i32.add
      (local.get $3)
      (i32.const 19)
     )
     (i32.const -16)
    )
    (i32.const 4)
   )
  )
  (if
   (i32.gt_u
    (local.get $3)
    (local.get $4)
   )
   (if
    (local.get $6)
    (block
     (if
      (i32.gt_u
       (local.get $3)
       (i32.const 1073741820)
      )
      (unreachable)
     )
     (call $~lib/rt/stub/maybeGrowMemory
      (i32.add
       (local.get $0)
       (local.get $2)
      )
     )
     (call $~lib/rt/common/BLOCK#set:mmInfo
      (local.get $5)
      (local.get $2)
     )
    )
    (block
     (call $~lib/memory/memory.copy
      (local.tee $2
       (call $~lib/rt/stub/__alloc
        (select
         (local.get $2)
         (local.tee $3
          (i32.shl
           (local.get $4)
           (i32.const 1)
          )
         )
         (i32.gt_u
          (local.get $2)
          (local.get $3)
         )
        )
       )
      )
      (local.get $0)
      (local.get $4)
     )
     (local.set $0
      (local.get $2)
     )
    )
   )
   (if
    (local.get $6)
    (block
     (global.set $~lib/rt/stub/offset
      (i32.add
       (local.get $0)
       (local.get $2)
      )
     )
     (call $~lib/rt/common/BLOCK#set:mmInfo
      (local.get $5)
      (local.get $2)
     )
    )
   )
  )
  (call $~lib/rt/common/OBJECT#set:rtSize
   (i32.sub
    (local.get $0)
    (i32.const 4)
   )
   (local.get $1)
  )
  (i32.add
   (local.get $0)
   (i32.const 16)
  )
 )
 (func $~lib/string/String.UTF8.decodeUnsafe (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (if
   (i32.gt_u
    (local.get $0)
    (local.tee $3
     (i32.add
      (local.get $0)
      (local.get $1)
     )
    )
   )
   (unreachable)
  )
  (local.set $1
   (local.tee $5
    (call $~lib/rt/stub/__new
     (i32.shl
      (local.get $1)
      (i32.const 1)
     )
     (i32.const 1)
    )
   )
  )
  (loop $while-continue|0
   (if
    (i32.lt_u
     (local.get $0)
     (local.get $3)
    )
    (block $while-break|0
     (local.set $2
      (i32.load8_u
       (local.get $0)
      )
     )
     (local.set $0
      (i32.add
       (local.get $0)
       (i32.const 1)
      )
     )
     (if
      (i32.and
       (local.get $2)
       (i32.const 128)
      )
      (block
       (br_if $while-break|0
        (i32.eq
         (local.get $0)
         (local.get $3)
        )
       )
       (local.set $4
        (i32.and
         (i32.load8_u
          (local.get $0)
         )
         (i32.const 63)
        )
       )
       (local.set $0
        (i32.add
         (local.get $0)
         (i32.const 1)
        )
       )
       (if
        (i32.eq
         (i32.and
          (local.get $2)
          (i32.const 224)
         )
         (i32.const 192)
        )
        (i32.store16
         (local.get $1)
         (i32.or
          (local.get $4)
          (i32.shl
           (i32.and
            (local.get $2)
            (i32.const 31)
           )
           (i32.const 6)
          )
         )
        )
        (block
         (br_if $while-break|0
          (i32.eq
           (local.get $0)
           (local.get $3)
          )
         )
         (local.set $6
          (i32.and
           (i32.load8_u
            (local.get $0)
           )
           (i32.const 63)
          )
         )
         (local.set $0
          (i32.add
           (local.get $0)
           (i32.const 1)
          )
         )
         (if
          (i32.eq
           (i32.and
            (local.get $2)
            (i32.const 240)
           )
           (i32.const 224)
          )
          (local.set $2
           (i32.or
            (local.get $6)
            (i32.or
             (i32.shl
              (i32.and
               (local.get $2)
               (i32.const 15)
              )
              (i32.const 12)
             )
             (i32.shl
              (local.get $4)
              (i32.const 6)
             )
            )
           )
          )
          (block
           (br_if $while-break|0
            (i32.eq
             (local.get $0)
             (local.get $3)
            )
           )
           (local.set $2
            (i32.or
             (i32.and
              (i32.load8_u
               (local.get $0)
              )
              (i32.const 63)
             )
             (i32.or
              (i32.or
               (i32.shl
                (i32.and
                 (local.get $2)
                 (i32.const 7)
                )
                (i32.const 18)
               )
               (i32.shl
                (local.get $4)
                (i32.const 12)
               )
              )
              (i32.shl
               (local.get $6)
               (i32.const 6)
              )
             )
            )
           )
           (local.set $0
            (i32.add
             (local.get $0)
             (i32.const 1)
            )
           )
          )
         )
         (if
          (i32.lt_u
           (local.get $2)
           (i32.const 65536)
          )
          (i32.store16
           (local.get $1)
           (local.get $2)
          )
          (block
           (i32.store
            (local.get $1)
            (i32.or
             (i32.or
              (i32.shr_u
               (local.tee $2
                (i32.sub
                 (local.get $2)
                 (i32.const 65536)
                )
               )
               (i32.const 10)
              )
              (i32.const 55296)
             )
             (i32.shl
              (i32.or
               (i32.and
                (local.get $2)
                (i32.const 1023)
               )
               (i32.const 56320)
              )
              (i32.const 16)
             )
            )
           )
           (local.set $1
            (i32.add
             (local.get $1)
             (i32.const 2)
            )
           )
          )
         )
        )
       )
      )
      (i32.store16
       (local.get $1)
       (local.get $2)
      )
     )
     (local.set $1
      (i32.add
       (local.get $1)
       (i32.const 2)
      )
     )
     (br $while-continue|0)
    )
   )
  )
  (call $~lib/rt/stub/__renew
   (local.get $5)
   (i32.sub
    (local.get $1)
    (local.get $5)
   )
  )
 )
 (func $~lib/string/String.UTF8.decode (param $0 i32) (result i32)
  (call $~lib/string/String.UTF8.decodeUnsafe
   (local.get $0)
   (call $~lib/arraybuffer/ArrayBuffer#get:byteLength
    (local.get $0)
   )
  )
 )
 (func $~lib/as-chain/asset/Symbol#getSymbolString (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i64)
  (local $4 i32)
  (local.set $2
   (call $~lib/typedarray/Uint8Array#constructor
    (i32.const 7)
   )
  )
  (local.set $3
   (i64.load
    (local.get $0)
   )
  )
  (loop $for-loop|0
   (if
    (i32.eqz
     (i64.eqz
      (local.tee $3
       (i64.shr_u
        (local.get $3)
        (i64.const 8)
       )
      )
     )
    )
    (block
     (local.set $0
      (i32.wrap_i64
       (i64.and
        (local.get $3)
        (i64.const 255)
       )
      )
     )
     (if
      (i32.ge_u
       (local.get $1)
       (i32.load offset=8
        (local.get $2)
       )
      )
      (unreachable)
     )
     (i32.store8
      (i32.add
       (local.get $1)
       (i32.load offset=4
        (local.get $2)
       )
      )
      (local.get $0)
     )
     (local.set $1
      (i32.add
       (local.get $1)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (local.set $4
   (select
    (i32.const 0)
    (local.tee $0
     (i32.load offset=8
      (local.get $2)
     )
    )
    (i32.gt_s
     (local.get $0)
     (i32.const 0)
    )
   )
  )
  (call $~lib/memory/memory.copy
   (i32.load offset=4
    (local.tee $1
     (call $~lib/typedarray/Uint8Array#constructor
      (local.tee $0
       (select
        (local.tee $0
         (i32.sub
          (if (result i32)
           (i32.lt_s
            (local.get $1)
            (i32.const 0)
           )
           (select
            (local.tee $0
             (i32.add
              (local.get $0)
              (local.get $1)
             )
            )
            (i32.const 0)
            (i32.gt_s
             (local.get $0)
             (i32.const 0)
            )
           )
           (select
            (local.get $1)
            (local.get $0)
            (i32.gt_s
             (local.get $0)
             (local.get $1)
            )
           )
          )
          (local.get $4)
         )
        )
        (i32.const 0)
        (i32.gt_s
         (local.get $0)
         (i32.const 0)
        )
       )
      )
     )
    )
   )
   (i32.add
    (local.get $4)
    (i32.load offset=4
     (local.get $2)
    )
   )
   (local.get $0)
  )
  (call $~lib/string/String.UTF8.decode
   (i32.load
    (local.get $1)
   )
  )
 )
 (func $~lib/as-chain/asset/Asset#toString (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local.set $2
   (i32.wrap_i64
    (i64.and
     (i64.load
      (i32.load offset=8
       (local.get $0)
      )
     )
     (i64.const 255)
    )
   )
  )
  (local.set $1
   (call $~lib/string/String#padStart
    (call $~lib/util/number/itoa64
     (i64.load
      (local.get $0)
     )
    )
    (i32.and
     (i32.add
      (local.get $2)
      (i32.const 1)
     )
     (i32.const 255)
    )
   )
  )
  (call $~lib/string/String.__concat
   (call $~lib/string/String.__concat
    (if (result i32)
     (local.get $2)
     (call $~lib/string/String.__concat
      (call $~lib/string/String.__concat
       (call $~lib/string/String#slice
        (local.get $1)
        (i32.const 0)
        (i32.sub
         (call $~lib/string/String#get:length
          (local.get $1)
         )
         (local.get $2)
        )
       )
       (i32.const 4160)
      )
      (call $~lib/string/String#slice
       (local.get $1)
       (i32.sub
        (call $~lib/string/String#get:length
         (local.get $1)
        )
        (local.get $2)
       )
       (call $~lib/string/String#get:length
        (local.get $1)
       )
      )
     )
     (local.get $1)
    )
    (i32.const 4192)
   )
   (call $~lib/as-chain/asset/Symbol#getSymbolString
    (i32.load offset=8
     (local.get $0)
    )
   )
  )
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#__uset (param $0 i32) (param $1 i32) (param $2 i32)
  (i32.store
   (i32.add
    (local.get $0)
    (i32.shl
     (local.get $1)
     (i32.const 2)
    )
   )
   (local.get $2)
  )
 )
 (func $~lib/array/Array<u8>#__get (param $0 i32) (param $1 i32) (result i32)
  (if
   (i32.ge_u
    (local.get $1)
    (i32.load offset=12
     (local.get $0)
    )
   )
   (unreachable)
  )
  (i32.load8_u
   (i32.add
    (i32.load offset=4
     (local.get $0)
    )
    (local.get $1)
   )
  )
 )
 (func $~lib/array/Array<u8>#__set (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (if
   (i32.ge_u
    (local.get $1)
    (i32.load offset=12
     (local.get $0)
    )
   )
   (block
    (if
     (i32.lt_s
      (local.get $1)
      (i32.const 0)
     )
     (unreachable)
    )
    (if
     (i32.gt_u
      (local.tee $3
       (local.tee $6
        (i32.add
         (local.get $1)
         (i32.const 1)
        )
       )
      )
      (local.tee $5
       (i32.load offset=8
        (local.get $0)
       )
      )
     )
     (block
      (if
       (i32.gt_u
        (local.get $3)
        (i32.const 1073741820)
       )
       (unreachable)
      )
      (call $~lib/memory/memory.fill
       (i32.add
        (local.get $5)
        (local.tee $3
         (call $~lib/rt/stub/__renew
          (local.tee $7
           (i32.load
            (local.get $0)
           )
          )
          (local.tee $4
           (select
            (local.tee $4
             (select
              (local.tee $4
               (i32.shl
                (local.get $5)
                (i32.const 1)
               )
              )
              (i32.const 1073741820)
              (i32.lt_u
               (local.get $4)
               (i32.const 1073741820)
              )
             )
            )
            (local.tee $3
             (select
              (local.get $3)
              (i32.const 8)
              (i32.gt_u
               (local.get $3)
               (i32.const 8)
              )
             )
            )
            (i32.lt_u
             (local.get $3)
             (local.get $4)
            )
           )
          )
         )
        )
       )
       (i32.sub
        (local.get $4)
        (local.get $5)
       )
      )
      (if
       (i32.ne
        (local.get $3)
        (local.get $7)
       )
       (block
        (i32.store
         (local.get $0)
         (local.get $3)
        )
        (i32.store offset=4
         (local.get $0)
         (local.get $3)
        )
       )
      )
      (i32.store offset=8
       (local.get $0)
       (local.get $4)
      )
     )
    )
    (call $~lib/rt/common/OBJECT#set:rtId
     (local.get $0)
     (local.get $6)
    )
   )
  )
  (i32.store8
   (i32.add
    (local.get $1)
    (i32.load offset=4
     (local.get $0)
    )
   )
   (local.get $2)
  )
 )
 (func $~lib/as-chain/name/Name#toString (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i64)
  (local.set $2
   (i64.load
    (local.get $0)
   )
  )
  (local.set $0
   (call $~lib/array/Array<u8>#constructor
    (i32.const 13)
   )
  )
  (loop $for-loop|0
   (if
    (i32.le_s
     (local.get $1)
     (i32.const 12)
    )
    (block
     (call $~lib/array/Array<u8>#__set
      (local.get $0)
      (i32.sub
       (i32.const 12)
       (local.get $1)
      )
      (if (result i32)
       (local.get $1)
       (call $~lib/array/Array<u8>#__get
        (i32.const 1152)
        (i32.wrap_i64
         (i64.and
          (local.get $2)
          (i64.const 31)
         )
        )
       )
       (call $~lib/array/Array<u8>#__get
        (i32.const 1152)
        (i32.wrap_i64
         (i64.and
          (local.get $2)
          (i64.const 15)
         )
        )
       )
      )
     )
     (local.set $2
      (select
       (i64.shr_u
        (local.get $2)
        (i64.const 5)
       )
       (i64.shr_u
        (local.get $2)
        (i64.const 4)
       )
       (local.get $1)
      )
     )
     (local.set $1
      (i32.add
       (local.get $1)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (local.set $1
   (i32.sub
    (i32.load offset=12
     (local.get $0)
    )
    (i32.const 1)
   )
  )
  (loop $for-loop|1
   (if
    (i32.ge_s
     (local.get $1)
     (i32.const 0)
    )
    (if
     (i32.eq
      (call $~lib/array/Array<u8>#__get
       (local.get $0)
       (local.get $1)
      )
      (i32.const 46)
     )
     (block
      (local.set $1
       (i32.sub
        (local.get $1)
        (i32.const 1)
       )
      )
      (br $for-loop|1)
     )
    )
   )
  )
  (call $~lib/string/String.UTF8.decode
   (i32.load
    (call $~lib/array/Array<u8>#slice
     (local.get $0)
     (i32.const 0)
     (i32.add
      (local.get $1)
      (i32.const 1)
     )
    )
   )
  )
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#join (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (block $__inlined_func$~lib/util/string/joinReferenceArray<~lib/string/String> (result i32)
   (drop
    (br_if $__inlined_func$~lib/util/string/joinReferenceArray<~lib/string/String>
     (i32.const 2448)
     (i32.lt_s
      (local.tee $3
       (i32.sub
        (i32.shr_u
         (i32.load offset=16
          (i32.sub
           (local.tee $1
            (local.get $0)
           )
           (i32.const 20)
          )
         )
         (i32.const 2)
        )
        (i32.const 1)
       )
      )
      (i32.const 0)
     )
    )
   )
   (if
    (i32.eqz
     (local.get $3)
    )
    (br $__inlined_func$~lib/util/string/joinReferenceArray<~lib/string/String>
     (if (result i32)
      (local.tee $0
       (i32.load
        (local.get $1)
       )
      )
      (local.get $0)
      (i32.const 2448)
     )
    )
   )
   (local.set $0
    (i32.const 2448)
   )
   (local.set $4
    (call $~lib/string/String#get:length
     (i32.const 2448)
    )
   )
   (loop $for-loop|0
    (if
     (i32.lt_s
      (local.get $2)
      (local.get $3)
     )
     (block
      (if
       (local.tee $5
        (i32.load
         (i32.add
          (local.get $1)
          (i32.shl
           (local.get $2)
           (i32.const 2)
          )
         )
        )
       )
       (local.set $0
        (call $~lib/string/String.__concat
         (local.get $0)
         (local.get $5)
        )
       )
      )
      (if
       (local.get $4)
       (local.set $0
        (call $~lib/string/String.__concat
         (local.get $0)
         (i32.const 2448)
        )
       )
      )
      (local.set $2
       (i32.add
        (local.get $2)
        (i32.const 1)
       )
      )
      (br $for-loop|0)
     )
    )
   )
   (if (result i32)
    (local.tee $1
     (i32.load
      (i32.add
       (local.get $1)
       (i32.shl
        (local.get $3)
        (i32.const 2)
       )
      )
     )
    )
    (call $~lib/string/String.__concat
     (local.get $0)
     (local.get $1)
    )
    (local.get $0)
   )
  )
 )
 (func $~lib/as-chain/debug/print (param $0 i32)
  (local.set $0
   (call $~lib/string/String.UTF8.encode
    (local.get $0)
    (i32.const 0)
   )
  )
  (global.set $~argumentsLength
   (i32.const 1)
  )
  (call $~lib/as-chain/env/prints_l
   (i32.load offset=4
    (local.tee $0
     (call $~lib/dataview/DataView#constructor@varargs
      (local.get $0)
     )
    )
   )
   (i32.load offset=8
    (local.get $0)
   )
  )
 )
 (func $contract/erc20like#mint (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (call $~lib/as-chain/system/check
   (call $~lib/as-chain/action/isAccount
    (local.get $1)
   )
   (i32.const 3008)
  )
  (call $~lib/as-chain/system/check
   (call $~lib/as-chain/asset/Asset#isValid
    (local.get $2)
   )
   (i32.const 3088)
  )
  (call $~lib/as-chain/system/check
   (i64.gt_s
    (i64.load
     (local.get $2)
    )
    (i64.const 0)
   )
   (i32.const 3152)
  )
  (if
   (i32.eqz
    (local.tee $3
     (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Stat>#first
      (i32.load offset=12
       (local.get $0)
      )
     )
    )
   )
   (block
    (call $~lib/as-chain/name/Name#set:N
     (local.tee $3
      (call $~lib/rt/stub/__new
       (i32.const 8)
       (i32.const 5)
      )
     )
     (i64.const 0)
    )
    (call $~lib/as-chain/name/Name#set:N
     (local.get $3)
     (i64.const 4849507885651694512)
    )
    (local.set $3
     (call $contract/Stat#constructor
      (i32.load offset=8
       (local.get $2)
      )
      (call $~lib/as-chain/asset/Asset#constructor
       (i64.const 0)
       (i32.load offset=8
        (local.get $2)
       )
      )
      (local.get $3)
     )
    )
    (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Stat>#store
     (i32.load offset=12
      (local.get $0)
     )
     (local.get $3)
     (i32.load
      (local.get $0)
     )
    )
   )
  )
  (call $~lib/as-chain/action/requireAuth
   (i32.load offset=8
    (local.get $3)
   )
  )
  (call $contract/erc20like#sameSymbol
   (local.get $2)
   (i32.load offset=4
    (local.get $3)
   )
  )
  (call $~lib/as-chain/system/check
   (i64.eq
    (i64.load
     (i32.load offset=8
      (local.tee $4
       (i32.load offset=4
        (local.get $3)
       )
      )
     )
    )
    (i64.load
     (i32.load offset=8
      (local.get $2)
     )
    )
   )
   (i32.const 3456)
  )
  (call $~lib/as-chain/system/check
   (i64.ge_s
    (local.tee $5
     (i64.add
      (i64.load
       (local.get $4)
      )
      (i64.load
       (local.get $2)
      )
     )
    )
    (i64.const -4611686018427387903)
   )
   (i32.const 3520)
  )
  (call $~lib/as-chain/system/check
   (i64.le_s
    (local.get $5)
    (i64.const 4611686018427387903)
   )
   (i32.const 3584)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $3)
   (call $~lib/as-chain/asset/Asset#constructor
    (local.get $5)
    (call $~lib/as-chain/asset/Symbol.fromU64
     (i64.load
      (i32.load offset=8
       (local.get $4)
      )
     )
    )
   )
  )
  (local.set $6
   (i32.load offset=12
    (local.get $0)
   )
  )
  (local.set $7
   (i32.load
    (local.get $0)
   )
  )
  (local.set $5
   (call $contract/Stat#getPrimaryValue
    (local.get $3)
   )
  )
  (if
   (block $__inlined_func$~lib/as-chain/mi/MultiIndex<contract/Stat>#getByKey (result i32)
    (drop
     (br_if $__inlined_func$~lib/as-chain/mi/MultiIndex<contract/Stat>#getByKey
      (i32.const 0)
      (i32.eqz
       (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
        (local.tee $8
         (call $~lib/as-chain/mi/MultiIndex<contract/Stat>#find
          (local.tee $4
           (i32.load
            (local.get $6)
           )
          )
          (local.get $5)
         )
        )
       )
      )
     )
    )
    (block $__inlined_func$~lib/as-chain/dbi64/DBI64<contract/Stat>#get (result i32)
     (local.set $4
      (i32.load
       (local.get $4)
      )
     )
     (drop
      (br_if $__inlined_func$~lib/as-chain/dbi64/DBI64<contract/Stat>#get
       (i32.const 0)
       (i32.eqz
        (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
         (local.get $8)
        )
       )
      )
     )
     (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#getEx
      (local.get $4)
      (i32.load offset=4
       (local.get $8)
      )
     )
    )
   )
   (block
    (local.set $5
     (call $contract/Stat#getPrimaryValue
      (local.get $3)
     )
    )
    (call $~lib/as-chain/system/check
     (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
      (local.tee $4
       (call $~lib/as-chain/mi/MultiIndex<contract/Stat>#find
        (i32.load
         (local.get $6)
        )
        (local.get $5)
       )
      )
     )
     (i32.const 1424)
    )
    (call $~lib/as-chain/mi/MultiIndex<contract/Stat>#update
     (i32.load
      (local.get $6)
     )
     (local.get $4)
     (local.get $3)
     (local.get $7)
    )
   )
   (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Stat>#store
    (local.get $6)
    (local.get $3)
    (local.get $7)
   )
  )
  (if
   (i32.eqz
    (local.tee $0
     (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#get
      (local.tee $4
       (call $contract/erc20like#getAccountsTable
        (local.get $0)
        (local.get $1)
       )
      )
      (call $~lib/as-chain/asset/Symbol#code
       (i32.load
        (local.get $3)
       )
      )
     )
    )
   )
   (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#store
    (local.get $4)
    (local.tee $0
     (call $contract/Account#constructor
      (call $~lib/as-chain/asset/Asset#constructor
       (i64.const 0)
       (i32.load
        (local.get $3)
       )
      )
     )
    )
    (i32.load offset=8
     (local.get $3)
    )
   )
  )
  (call $~lib/as-chain/system/check
   (i64.eq
    (i64.load
     (i32.load offset=8
      (local.tee $6
       (i32.load
        (local.get $0)
       )
      )
     )
    )
    (i64.load
     (i32.load offset=8
      (local.get $2)
     )
    )
   )
   (i32.const 3456)
  )
  (call $~lib/as-chain/system/check
   (i64.ge_s
    (local.tee $5
     (i64.add
      (i64.load
       (local.get $6)
      )
      (i64.load
       (local.get $2)
      )
     )
    )
    (i64.const -4611686018427387903)
   )
   (i32.const 3520)
  )
  (call $~lib/as-chain/system/check
   (i64.le_s
    (local.get $5)
    (i64.const 4611686018427387903)
   )
   (i32.const 3584)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $0)
   (call $~lib/as-chain/asset/Asset#constructor
    (local.get $5)
    (call $~lib/as-chain/asset/Symbol.fromU64
     (i64.load
      (i32.load offset=8
       (local.get $6)
      )
     )
    )
   )
  )
  (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#set
   (local.get $4)
   (local.get $0)
   (i32.load offset=8
    (local.get $3)
   )
  )
  (call $~lib/as-chain/action/requireRecipient
   (local.get $1)
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 3984)
   (i32.const 1)
   (call $~lib/as-chain/asset/Asset#toString
    (local.get $2)
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 3984)
   (i32.const 3)
   (call $~lib/as-chain/name/Name#toString
    (local.get $1)
   )
  )
  (call $~lib/as-chain/debug/print
   (call $~lib/staticarray/StaticArray<~lib/string/String>#join
    (i32.const 3984)
   )
  )
 )
 (func $contract/erc20like#transfer (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i64)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (call $~lib/as-chain/system/check
   (call $~lib/as-chain/action/isAccount
    (local.get $2)
   )
   (i32.const 3008)
  )
  (call $~lib/as-chain/system/check
   (i64.ne
    (i64.load
     (local.get $1)
    )
    (i64.load
     (local.get $2)
    )
   )
   (i32.const 4224)
  )
  (call $~lib/as-chain/system/check
   (call $~lib/as-chain/asset/Asset#isValid
    (local.get $3)
   )
   (i32.const 3088)
  )
  (call $~lib/as-chain/system/check
   (i64.gt_s
    (i64.load
     (local.get $3)
    )
    (i64.const 0)
   )
   (i32.const 4304)
  )
  (call $~lib/as-chain/action/requireAuth
   (local.get $1)
  )
  (call $contract/erc20like#sameSymbol
   (local.get $3)
   (i32.load offset=4
    (local.tee $8
     (call $contract/erc20like#readStatRequired
      (local.get $0)
     )
    )
   )
  )
  (local.set $10
   (call $contract/erc20like#getAccountsTable
    (local.get $0)
    (local.get $1)
   )
  )
  (local.set $9
   (call $contract/erc20like#getAccountsTable
    (local.get $0)
    (local.get $2)
   )
  )
  (call $~lib/as-chain/system/check
   (i32.ne
    (local.tee $0
     (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#get
      (local.get $10)
      (call $~lib/as-chain/asset/Symbol#code
       (i32.load
        (local.get $8)
       )
      )
     )
    )
    (i32.const 0)
   )
   (i32.const 4400)
  )
  (local.set $5
   (local.get $0)
  )
  (if
   (i32.eqz
    (local.get $0)
   )
   (unreachable)
  )
  (call $~lib/as-chain/system/check
   (i64.eq
    (i64.load
     (i32.load offset=8
      (local.tee $5
       (i32.load
        (local.get $5)
       )
      )
     )
    )
    (i64.load
     (i32.load offset=8
      (local.get $3)
     )
    )
   )
   (i32.const 3456)
  )
  (call $~lib/as-chain/system/check
   (i64.ge_s
    (i64.load
     (local.get $5)
    )
    (i64.load
     (local.get $3)
    )
   )
   (i32.const 4480)
  )
  (local.set $5
   (local.get $0)
  )
  (local.set $6
   (if (result i32)
    (local.get $0)
    (local.get $5)
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (local.get $0)
   )
   (unreachable)
  )
  (call $~lib/as-chain/system/check
   (i64.eq
    (i64.load
     (i32.load offset=8
      (local.tee $5
       (i32.load
        (local.get $5)
       )
      )
     )
    )
    (i64.load
     (i32.load offset=8
      (local.get $3)
     )
    )
   )
   (i32.const 3456)
  )
  (call $~lib/as-chain/system/check
   (i64.ge_s
    (local.tee $7
     (i64.sub
      (i64.load
       (local.get $5)
      )
      (i64.load
       (local.get $3)
      )
     )
    )
    (i64.const -4611686018427387903)
   )
   (i32.const 4544)
  )
  (call $~lib/as-chain/system/check
   (i64.le_s
    (local.get $7)
    (i64.const 4611686018427387903)
   )
   (i32.const 4608)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $6)
   (call $~lib/as-chain/asset/Asset#constructor
    (local.get $7)
    (call $~lib/as-chain/asset/Symbol.fromU64
     (i64.load
      (i32.load offset=8
       (local.get $5)
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (local.get $0)
   )
   (unreachable)
  )
  (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#set
   (local.get $10)
   (local.get $0)
   (local.get $1)
  )
  (if
   (i32.eqz
    (local.tee $0
     (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#get
      (local.get $9)
      (call $~lib/as-chain/asset/Symbol#code
       (i32.load
        (local.get $8)
       )
      )
     )
    )
   )
   (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#store
    (local.get $9)
    (local.tee $0
     (call $contract/Account#constructor
      (call $~lib/as-chain/asset/Asset#constructor
       (i64.const 0)
       (i32.load
        (local.get $8)
       )
      )
     )
    )
    (local.get $1)
   )
  )
  (call $~lib/as-chain/system/check
   (i64.eq
    (i64.load
     (i32.load offset=8
      (local.tee $5
       (i32.load
        (local.get $0)
       )
      )
     )
    )
    (i64.load
     (i32.load offset=8
      (local.get $3)
     )
    )
   )
   (i32.const 3456)
  )
  (call $~lib/as-chain/system/check
   (i64.ge_s
    (local.tee $7
     (i64.add
      (i64.load
       (local.get $5)
      )
      (i64.load
       (local.get $3)
      )
     )
    )
    (i64.const -4611686018427387903)
   )
   (i32.const 3520)
  )
  (call $~lib/as-chain/system/check
   (i64.le_s
    (local.get $7)
    (i64.const 4611686018427387903)
   )
   (i32.const 3584)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $0)
   (call $~lib/as-chain/asset/Asset#constructor
    (local.get $7)
    (call $~lib/as-chain/asset/Symbol.fromU64
     (i64.load
      (i32.load offset=8
       (local.get $5)
      )
     )
    )
   )
  )
  (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#set
   (local.get $9)
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/as-chain/action/requireRecipient
   (local.get $1)
  )
  (call $~lib/as-chain/action/requireRecipient
   (local.get $2)
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 4832)
   (i32.const 1)
   (call $~lib/as-chain/name/Name#toString
    (local.get $1)
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 4832)
   (i32.const 3)
   (call $~lib/as-chain/name/Name#toString
    (local.get $2)
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 4832)
   (i32.const 5)
   (call $~lib/as-chain/asset/Asset#toString
    (local.get $3)
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 4832)
   (i32.const 7)
   (local.get $4)
  )
  (call $~lib/as-chain/debug/print
   (call $~lib/staticarray/StaticArray<~lib/string/String>#join
    (i32.const 4832)
   )
  )
 )
 (func $~lib/as-chain/dbi64/PrimaryIterator<contract/Allowance>#constructor (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32) (result i32)
  (local $4 i32)
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.tee $4
    (call $~lib/rt/stub/__new
     (i32.const 24)
     (i32.const 40)
    )
   )
   (i32.const 0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $4)
   (i32.const 0)
  )
  (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#set:validPrimary
   (local.get $4)
   (i32.const 0)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:table
   (local.get $4)
   (i64.const 0)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $4)
   (local.get $0)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $4)
   (local.get $1)
  )
  (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:table
   (local.get $4)
   (local.get $2)
  )
  (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#set:validPrimary
   (local.get $4)
   (local.get $3)
  )
  (local.get $4)
 )
 (func $~lib/as-chain/mi/MultiIndex<contract/Allowance>#find (param $0 i32) (param $1 i64) (result i32)
  (local $2 i32)
  (block $__inlined_func$~lib/as-chain/dbi64/DBI64<contract/Allowance>#find (result i32)
   (if
    (i32.ge_s
     (local.tee $2
      (call $~lib/as-chain/env/db_find_i64
       (i64.load
        (local.tee $0
         (i32.load
          (local.get $0)
         )
        )
       )
       (i64.load offset=8
        (local.get $0)
       )
       (i64.load offset=16
        (local.get $0)
       )
       (local.get $1)
      )
     )
     (i32.const 0)
    )
    (br $__inlined_func$~lib/as-chain/dbi64/DBI64<contract/Allowance>#find
     (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Allowance>#constructor
      (local.get $0)
      (local.get $2)
      (local.get $1)
      (i32.const 1)
     )
    )
   )
   (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Allowance>#constructor
    (local.get $0)
    (local.get $2)
    (i64.const 0)
    (i32.const 0)
   )
  )
 )
 (func $contract/Allowance#unpack (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local.set $1
   (call $~lib/as-chain/serializer/Decoder#constructor
    (local.get $1)
   )
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $2)
   (i64.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.get $2)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $0)
   (local.get $2)
  )
  (global.set $~argumentsLength
   (i32.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.tee $2
    (call $~lib/as-chain/asset/Asset#constructor@varargs)
   )
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (local.get $2)
  )
  (i32.load offset=4
   (local.get $1)
  )
 )
 (func $~lib/as-chain/dbi64/DBI64<contract/Allowance>#getEx (param $0 i32) (param $1 i32) (result i32)
  (if
   (i32.eqz
    (local.tee $0
     (call $~lib/as-chain/env/db_get_i64
      (local.get $1)
      (i32.const 0)
      (i32.const 0)
     )
    )
   )
   (return
    (i32.const 0)
   )
  )
  (drop
   (call $~lib/as-chain/env/db_get_i64
    (local.get $1)
    (i32.load offset=4
     (local.tee $1
      (call $~lib/array/Array<u8>#constructor
       (local.get $0)
      )
     )
    )
    (local.get $0)
   )
  )
  (global.set $~argumentsLength
   (i32.const 0)
  )
  (drop
   (call $contract/Allowance#unpack
    (local.tee $0
     (call $contract/Allowance#constructor@varargs)
    )
    (local.get $1)
   )
  )
  (local.get $0)
 )
 (func $~lib/proton-tsc/modules/store/store/TableStore<contract/Allowance>#get (param $0 i32) (param $1 i64) (result i32)
  (local $2 i32)
  (local $3 i32)
  (block $__inlined_func$~lib/as-chain/mi/MultiIndex<contract/Allowance>#getByKey (result i32)
   (drop
    (br_if $__inlined_func$~lib/as-chain/mi/MultiIndex<contract/Allowance>#getByKey
     (i32.const 0)
     (i32.eqz
      (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
       (local.tee $2
        (call $~lib/as-chain/mi/MultiIndex<contract/Allowance>#find
         (local.tee $0
          (i32.load
           (local.get $0)
          )
         )
         (local.get $1)
        )
       )
      )
     )
    )
   )
   (block $__inlined_func$~lib/as-chain/dbi64/DBI64<contract/Allowance>#get (result i32)
    (local.set $3
     (i32.load
      (local.get $0)
     )
    )
    (drop
     (br_if $__inlined_func$~lib/as-chain/dbi64/DBI64<contract/Allowance>#get
      (i32.const 0)
      (i32.eqz
       (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
        (local.tee $0
         (local.get $2)
        )
       )
      )
     )
    )
    (call $~lib/as-chain/dbi64/DBI64<contract/Allowance>#getEx
     (local.get $3)
     (i32.load offset=4
      (local.get $0)
     )
    )
   )
  )
 )
 (func $contract/Allowance#getPrimaryValue (param $0 i32) (result i64)
  (i64.load
   (i32.load
    (local.get $0)
   )
  )
 )
 (func $contract/Allowance#pack (param $0 i32) (result i32)
  (local $1 i32)
  (call $~lib/as-chain/serializer/Encoder#pack
   (local.tee $1
    (call $~lib/as-chain/serializer/Encoder#constructor
     (block (result i32)
      (drop
       (i32.load
        (local.get $0)
       )
      )
      (drop
       (i32.load offset=4
        (local.get $0)
       )
      )
      (i32.const 24)
     )
    )
   )
   (i32.load
    (local.get $0)
   )
  )
  (call $~lib/as-chain/serializer/Encoder#pack
   (local.get $1)
   (i32.load offset=4
    (local.get $0)
   )
  )
  (call $~lib/as-chain/serializer/Encoder#getBytes
   (local.get $1)
  )
 )
 (func $~lib/proton-tsc/modules/store/store/TableStore<contract/Allowance>#store (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i64)
  (local $4 i64)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i64)
  (local $9 i32)
  (local $10 i32)
  (local.set $4
   (call $contract/Allowance#getPrimaryValue
    (local.get $1)
   )
  )
  (call $~lib/as-chain/system/check
   (i32.eqz
    (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
     (call $~lib/as-chain/mi/MultiIndex<contract/Allowance>#find
      (i32.load
       (local.get $0)
      )
      (local.get $4)
     )
    )
   )
   (i32.const 1200)
  )
  (local.set $7
   (i32.load
    (local.tee $6
     (i32.load
      (local.get $0)
     )
    )
   )
  )
  (local.set $3
   (call $contract/Allowance#getPrimaryValue
    (local.get $1)
   )
  )
  (local.set $8
   (i64.load
    (local.get $2)
   )
  )
  (local.set $10
   (i32.load offset=12
    (local.tee $9
     (call $contract/Allowance#pack
      (local.get $1)
     )
    )
   )
  )
  (drop
   (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Allowance>#constructor
    (local.get $7)
    (call $~lib/as-chain/env/db_store_i64
     (i64.load offset=8
      (local.get $7)
     )
     (i64.load offset=16
      (local.get $7)
     )
     (local.get $8)
     (local.get $3)
     (i32.load offset=4
      (local.get $9)
     )
     (local.get $10)
    )
    (local.get $3)
    (i32.const 1)
   )
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $5)
     (i32.load offset=12
      (i32.load offset=4
       (local.get $6)
      )
     )
    )
    (block
     (call $~lib/as-chain/idxdb/IDXDB#storeEx@virtual
      (call $~lib/array/Array<~lib/as-chain/idxdb/IDXDB>#__get
       (i32.load offset=4
        (local.get $6)
       )
       (local.get $5)
      )
      (call $contract/Allowance#getPrimaryValue
       (local.get $1)
      )
      (call $contract/Stat#getSecondaryValue)
      (i64.load
       (local.get $2)
      )
     )
     (local.set $5
      (i32.add
       (local.get $5)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (if
   (i64.ge_u
    (local.tee $3
     (call $contract/Allowance#getPrimaryValue
      (local.get $1)
     )
    )
    (i64.load offset=8
     (local.get $6)
    )
   )
   (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
    (local.get $6)
    (select
     (i64.const -2)
     (i64.add
      (local.get $3)
      (i64.const 1)
     )
     (i64.ge_u
      (local.get $3)
      (i64.const -2)
     )
    )
   )
  )
  (if
   (i64.ge_u
    (local.get $4)
    (i64.load offset=8
     (local.get $0)
    )
   )
   (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
    (local.get $0)
    (select
     (i64.const -2)
     (i64.add
      (local.get $4)
      (i64.const 1)
     )
     (i64.ge_u
      (local.get $4)
      (i64.const -2)
     )
    )
   )
  )
 )
 (func $~lib/as-chain/mi/MultiIndex<contract/Allowance>#update (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i32)
  (local $8 i64)
  (call $~lib/as-chain/system/check
   (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
    (local.get $1)
   )
   (i32.const 3648)
  )
  (call $~lib/as-chain/system/check
   (i64.eq
    (local.tee $6
     (call $contract/Allowance#getPrimaryValue
      (local.get $2)
     )
    )
    (block $__inlined_func$~lib/as-chain/dbi64/PrimaryIterator<contract/Allowance>#get:primary (result i64)
     (call $~lib/as-chain/system/check
      (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
       (local.tee $4
        (local.get $1)
       )
      )
      (i32.const 3712)
     )
     (if
      (i32.load8_u offset=8
       (local.get $4)
      )
      (br $__inlined_func$~lib/as-chain/dbi64/PrimaryIterator<contract/Allowance>#get:primary
       (i64.load offset=16
        (local.get $4)
       )
      )
     )
     (if
      (i32.eqz
       (local.tee $7
        (block $__inlined_func$~lib/as-chain/dbi64/PrimaryIterator<contract/Allowance>#getValue (result i32)
         (drop
          (br_if $__inlined_func$~lib/as-chain/dbi64/PrimaryIterator<contract/Allowance>#getValue
           (i32.const 0)
           (i32.eqz
            (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
             (local.get $4)
            )
           )
          )
         )
         (call $~lib/as-chain/dbi64/DBI64<contract/Allowance>#getEx
          (i32.load
           (local.get $4)
          )
          (i32.load offset=4
           (local.get $4)
          )
         )
        )
       )
      )
      (unreachable)
     )
     (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:table
      (local.get $4)
      (call $contract/Allowance#getPrimaryValue
       (local.get $7)
      )
     )
     (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#set:validPrimary
      (local.get $4)
      (i32.const 1)
     )
     (i64.load offset=16
      (local.get $4)
     )
    )
   )
   (i32.const 3792)
  )
  (drop
   (i32.load
    (local.get $0)
   )
  )
  (local.set $8
   (i64.load
    (local.get $3)
   )
  )
  (local.set $4
   (i32.load offset=12
    (local.tee $2
     (call $contract/Allowance#pack
      (local.get $2)
     )
    )
   )
  )
  (call $~lib/as-chain/env/db_update_i64
   (i32.load offset=4
    (local.get $1)
   )
   (local.get $8)
   (i32.load offset=4
    (local.get $2)
   )
   (local.get $4)
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $5)
     (i32.load offset=12
      (i32.load offset=4
       (local.get $0)
      )
     )
    )
    (block
     (local.set $1
      (call $~lib/as-chain/idxdb/IDXDB#findPrimaryEx@virtual
       (call $~lib/array/Array<~lib/as-chain/idxdb/IDXDB>#__get
        (i32.load offset=4
         (local.get $0)
        )
        (local.get $5)
       )
      )
     )
     (local.set $2
      (call $contract/Stat#getSecondaryValue)
     )
     (if
      (i32.eqz
       (if (result i32)
        (i32.eq
         (i32.load
          (i32.load offset=4
           (local.get $1)
          )
         )
         (i32.load
          (local.get $2)
         )
        )
        (i32.eq
         (i32.load offset=4
          (i32.load offset=4
           (local.get $1)
          )
         )
         (i32.load offset=4
          (local.get $2)
         )
        )
        (i32.const 0)
       )
      )
      (call $~lib/as-chain/idxdb/IDXDB#updateEx@virtual
       (call $~lib/array/Array<~lib/as-chain/idxdb/IDXDB>#__get
        (i32.load offset=4
         (local.get $0)
        )
        (local.get $5)
       )
       (i32.load
        (local.get $1)
       )
       (call $contract/Stat#getSecondaryValue)
       (i64.load
        (local.get $3)
       )
      )
     )
     (local.set $5
      (i32.add
       (local.get $5)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (if
   (i64.ge_u
    (local.get $6)
    (i64.load offset=8
     (local.get $0)
    )
   )
   (call $~lib/as-chain/dbi64/DBI64<contract/Stat>#set:scope
    (local.get $0)
    (select
     (i64.const -2)
     (i64.add
      (local.get $6)
      (i64.const 1)
     )
     (i64.ge_u
      (local.get $6)
      (i64.const -2)
     )
    )
   )
  )
 )
 (func $~lib/proton-tsc/modules/store/store/TableStore<contract/Allowance>#set (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i64)
  (local $4 i32)
  (if
   (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Allowance>#get
    (local.get $0)
    (call $contract/Allowance#getPrimaryValue
     (local.get $1)
    )
   )
   (block
    (local.set $3
     (call $contract/Allowance#getPrimaryValue
      (local.get $1)
     )
    )
    (call $~lib/as-chain/system/check
     (call $~lib/as-chain/dbi64/PrimaryIterator<contract/Stat>#isOk
      (local.tee $4
       (call $~lib/as-chain/mi/MultiIndex<contract/Allowance>#find
        (i32.load
         (local.get $0)
        )
        (local.get $3)
       )
      )
     )
     (i32.const 1424)
    )
    (call $~lib/as-chain/mi/MultiIndex<contract/Allowance>#update
     (i32.load
      (local.get $0)
     )
     (local.get $4)
     (local.get $1)
     (local.get $2)
    )
   )
   (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Allowance>#store
    (local.get $0)
    (local.get $1)
    (local.get $2)
   )
  )
 )
 (func $contract/erc20like#approve (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (call $~lib/as-chain/system/check
   (call $~lib/as-chain/action/isAccount
    (local.get $2)
   )
   (i32.const 4896)
  )
  (call $~lib/as-chain/system/check
   (i64.ne
    (i64.load
     (local.get $1)
    )
    (i64.load
     (local.get $2)
    )
   )
   (i32.const 4976)
  )
  (call $~lib/as-chain/system/check
   (call $~lib/as-chain/asset/Asset#isValid
    (local.get $3)
   )
   (i32.const 5040)
  )
  (call $~lib/as-chain/system/check
   (i64.ge_s
    (i64.load
     (local.get $3)
    )
    (i64.const 0)
   )
   (i32.const 5088)
  )
  (call $~lib/as-chain/action/requireAuth
   (local.get $1)
  )
  (call $contract/erc20like#sameSymbol
   (local.get $3)
   (i32.load offset=4
    (local.tee $5
     (call $contract/erc20like#readStatRequired
      (local.get $0)
     )
    )
   )
  )
  (if
   (i32.eqz
    (local.tee $0
     (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Allowance>#get
      (local.tee $4
       (call $contract/erc20like#getAllowancesTable
        (local.get $0)
        (local.get $1)
       )
      )
      (i64.load
       (local.get $2)
      )
     )
    )
   )
   (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Allowance>#store
    (local.get $4)
    (local.tee $0
     (call $contract/Allowance#constructor
      (local.get $2)
      (call $~lib/as-chain/asset/Asset#constructor
       (i64.const 0)
       (i32.load
        (local.get $5)
       )
      )
     )
    )
    (local.get $1)
   )
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (local.get $3)
  )
  (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Allowance>#set
   (local.get $4)
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/as-chain/action/requireRecipient
   (local.get $1)
  )
  (call $~lib/as-chain/action/requireRecipient
   (local.get $2)
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 5216)
   (i32.const 1)
   (call $~lib/as-chain/name/Name#toString
    (local.get $1)
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 5216)
   (i32.const 3)
   (call $~lib/as-chain/name/Name#toString
    (local.get $2)
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 5216)
   (i32.const 5)
   (call $~lib/as-chain/asset/Asset#toString
    (local.get $3)
   )
  )
  (call $~lib/as-chain/debug/print
   (call $~lib/staticarray/StaticArray<~lib/string/String>#join
    (i32.const 5216)
   )
  )
 )
 (func $contract/erc20like#transferFrom (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 i32) (param $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i64)
  (local $10 i32)
  (local $11 i32)
  (call $~lib/as-chain/system/check
   (call $~lib/as-chain/action/isAccount
    (local.get $3)
   )
   (i32.const 3008)
  )
  (call $~lib/as-chain/system/check
   (i64.ne
    (i64.load
     (local.get $2)
    )
    (i64.load
     (local.get $3)
    )
   )
   (i32.const 4224)
  )
  (call $~lib/as-chain/system/check
   (call $~lib/as-chain/asset/Asset#isValid
    (local.get $4)
   )
   (i32.const 5040)
  )
  (call $~lib/as-chain/system/check
   (i64.gt_s
    (i64.load
     (local.get $4)
    )
    (i64.const 0)
   )
   (i32.const 5264)
  )
  (call $~lib/as-chain/action/requireAuth
   (local.get $1)
  )
  (call $contract/erc20like#sameSymbol
   (local.get $4)
   (i32.load offset=4
    (local.tee $11
     (call $contract/erc20like#readStatRequired
      (local.get $0)
     )
    )
   )
  )
  (call $~lib/as-chain/system/check
   (i32.ne
    (local.tee $6
     (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Allowance>#get
      (local.tee $10
       (call $contract/erc20like#getAllowancesTable
        (local.get $0)
        (local.get $2)
       )
      )
      (i64.load
       (local.get $1)
      )
     )
    )
    (i32.const 0)
   )
   (i32.const 5344)
  )
  (local.set $7
   (local.get $6)
  )
  (if
   (i32.eqz
    (local.get $6)
   )
   (unreachable)
  )
  (call $~lib/as-chain/system/check
   (i64.eq
    (i64.load
     (i32.load offset=8
      (local.tee $7
       (i32.load offset=4
        (local.get $7)
       )
      )
     )
    )
    (i64.load
     (i32.load offset=8
      (local.get $4)
     )
    )
   )
   (i32.const 3456)
  )
  (call $~lib/as-chain/system/check
   (i64.ge_s
    (i64.load
     (local.get $7)
    )
    (i64.load
     (local.get $4)
    )
   )
   (i32.const 5424)
  )
  (local.set $7
   (local.get $6)
  )
  (local.set $8
   (if (result i32)
    (local.get $6)
    (local.get $7)
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (local.get $6)
   )
   (unreachable)
  )
  (call $~lib/as-chain/system/check
   (i64.eq
    (i64.load
     (i32.load offset=8
      (local.tee $7
       (i32.load offset=4
        (local.get $7)
       )
      )
     )
    )
    (i64.load
     (i32.load offset=8
      (local.get $4)
     )
    )
   )
   (i32.const 3456)
  )
  (call $~lib/as-chain/system/check
   (i64.ge_s
    (local.tee $9
     (i64.sub
      (i64.load
       (local.get $7)
      )
      (i64.load
       (local.get $4)
      )
     )
    )
    (i64.const -4611686018427387903)
   )
   (i32.const 4544)
  )
  (call $~lib/as-chain/system/check
   (i64.le_s
    (local.get $9)
    (i64.const 4611686018427387903)
   )
   (i32.const 4608)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $8)
   (call $~lib/as-chain/asset/Asset#constructor
    (local.get $9)
    (call $~lib/as-chain/asset/Symbol.fromU64
     (i64.load
      (i32.load offset=8
       (local.get $7)
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (local.get $6)
   )
   (unreachable)
  )
  (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Allowance>#set
   (local.get $10)
   (local.get $6)
   (local.get $2)
  )
  (local.set $10
   (call $contract/erc20like#getAccountsTable
    (local.get $0)
    (local.get $2)
   )
  )
  (local.set $7
   (call $contract/erc20like#getAccountsTable
    (local.get $0)
    (local.get $3)
   )
  )
  (call $~lib/as-chain/system/check
   (i32.ne
    (local.tee $0
     (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#get
      (local.get $10)
      (call $~lib/as-chain/asset/Symbol#code
       (i32.load
        (local.get $11)
       )
      )
     )
    )
    (i32.const 0)
   )
   (i32.const 4400)
  )
  (if
   (i32.eqz
    (local.tee $6
     (local.get $0)
    )
   )
   (unreachable)
  )
  (call $~lib/as-chain/system/check
   (i64.eq
    (i64.load
     (i32.load offset=8
      (local.tee $6
       (i32.load
        (local.get $6)
       )
      )
     )
    )
    (i64.load
     (i32.load offset=8
      (local.get $4)
     )
    )
   )
   (i32.const 3456)
  )
  (call $~lib/as-chain/system/check
   (i64.ge_s
    (i64.load
     (local.get $6)
    )
    (i64.load
     (local.get $4)
    )
   )
   (i32.const 4480)
  )
  (local.set $8
   (if (result i32)
    (local.tee $6
     (local.get $0)
    )
    (local.get $6)
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (local.get $0)
   )
   (unreachable)
  )
  (call $~lib/as-chain/system/check
   (i64.eq
    (i64.load
     (i32.load offset=8
      (local.tee $6
       (i32.load
        (local.get $6)
       )
      )
     )
    )
    (i64.load
     (i32.load offset=8
      (local.get $4)
     )
    )
   )
   (i32.const 3456)
  )
  (call $~lib/as-chain/system/check
   (i64.ge_s
    (local.tee $9
     (i64.sub
      (i64.load
       (local.get $6)
      )
      (i64.load
       (local.get $4)
      )
     )
    )
    (i64.const -4611686018427387903)
   )
   (i32.const 4544)
  )
  (call $~lib/as-chain/system/check
   (i64.le_s
    (local.get $9)
    (i64.const 4611686018427387903)
   )
   (i32.const 4608)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $8)
   (call $~lib/as-chain/asset/Asset#constructor
    (local.get $9)
    (call $~lib/as-chain/asset/Symbol.fromU64
     (i64.load
      (i32.load offset=8
       (local.get $6)
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (local.get $0)
   )
   (unreachable)
  )
  (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#set
   (local.get $10)
   (local.get $0)
   (local.get $2)
  )
  (if
   (i32.eqz
    (local.tee $0
     (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#get
      (local.get $7)
      (call $~lib/as-chain/asset/Symbol#code
       (i32.load
        (local.get $11)
       )
      )
     )
    )
   )
   (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#store
    (local.get $7)
    (local.tee $0
     (call $contract/Account#constructor
      (call $~lib/as-chain/asset/Asset#constructor
       (i64.const 0)
       (i32.load
        (local.get $11)
       )
      )
     )
    )
    (local.get $2)
   )
  )
  (call $~lib/as-chain/system/check
   (i64.eq
    (i64.load
     (i32.load offset=8
      (local.tee $6
       (i32.load
        (local.get $0)
       )
      )
     )
    )
    (i64.load
     (i32.load offset=8
      (local.get $4)
     )
    )
   )
   (i32.const 3456)
  )
  (call $~lib/as-chain/system/check
   (i64.ge_s
    (local.tee $9
     (i64.add
      (i64.load
       (local.get $6)
      )
      (i64.load
       (local.get $4)
      )
     )
    )
    (i64.const -4611686018427387903)
   )
   (i32.const 3520)
  )
  (call $~lib/as-chain/system/check
   (i64.le_s
    (local.get $9)
    (i64.const 4611686018427387903)
   )
   (i32.const 3584)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $0)
   (call $~lib/as-chain/asset/Asset#constructor
    (local.get $9)
    (call $~lib/as-chain/asset/Symbol.fromU64
     (i64.load
      (i32.load offset=8
       (local.get $6)
      )
     )
    )
   )
  )
  (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#set
   (local.get $7)
   (local.get $0)
   (local.get $2)
  )
  (call $~lib/as-chain/action/requireRecipient
   (local.get $2)
  )
  (call $~lib/as-chain/action/requireRecipient
   (local.get $3)
  )
  (call $~lib/as-chain/action/requireRecipient
   (local.get $1)
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 5552)
   (i32.const 1)
   (call $~lib/as-chain/name/Name#toString
    (local.get $1)
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 5552)
   (i32.const 3)
   (call $~lib/as-chain/name/Name#toString
    (local.get $2)
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 5552)
   (i32.const 5)
   (call $~lib/as-chain/name/Name#toString
    (local.get $3)
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 5552)
   (i32.const 7)
   (call $~lib/as-chain/asset/Asset#toString
    (local.get $4)
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 5552)
   (i32.const 9)
   (local.get $5)
  )
  (call $~lib/as-chain/debug/print
   (call $~lib/staticarray/StaticArray<~lib/string/String>#join
    (i32.const 5552)
   )
  )
 )
 (func $contract/erc20like#balanceOf (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local.set $2
   (call $contract/erc20like#readStatRequired
    (local.get $0)
   )
  )
  (local.set $0
   (if (result i32)
    (local.tee $0
     (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Account>#get
      (call $contract/erc20like#getAccountsTable
       (local.get $0)
       (local.get $1)
      )
      (call $~lib/as-chain/asset/Symbol#code
       (i32.load
        (local.get $2)
       )
      )
     )
    )
    (i32.load
     (local.get $0)
    )
    (call $~lib/as-chain/asset/Asset#constructor
     (i64.const 0)
     (i32.load
      (local.get $2)
     )
    )
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 5696)
   (i32.const 1)
   (call $~lib/as-chain/name/Name#toString
    (local.get $1)
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 5696)
   (i32.const 3)
   (call $~lib/as-chain/asset/Asset#toString
    (local.get $0)
   )
  )
  (call $~lib/as-chain/debug/print
   (call $~lib/staticarray/StaticArray<~lib/string/String>#join
    (i32.const 5696)
   )
  )
 )
 (func $contract/erc20like#allowance (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local.set $3
   (call $contract/erc20like#readStatRequired
    (local.get $0)
   )
  )
  (local.set $0
   (if (result i32)
    (local.tee $0
     (call $~lib/proton-tsc/modules/store/store/TableStore<contract/Allowance>#get
      (call $contract/erc20like#getAllowancesTable
       (local.get $0)
       (local.get $1)
      )
      (i64.load
       (local.get $2)
      )
     )
    )
    (i32.load offset=4
     (local.get $0)
    )
    (call $~lib/as-chain/asset/Asset#constructor
     (i64.const 0)
     (i32.load
      (local.get $3)
     )
    )
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 5904)
   (i32.const 1)
   (call $~lib/as-chain/name/Name#toString
    (local.get $1)
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 5904)
   (i32.const 3)
   (call $~lib/as-chain/name/Name#toString
    (local.get $2)
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   (i32.const 5904)
   (i32.const 5)
   (call $~lib/as-chain/asset/Asset#toString
    (local.get $0)
   )
  )
  (call $~lib/as-chain/debug/print
   (call $~lib/staticarray/StaticArray<~lib/string/String>#join
    (i32.const 5904)
   )
  )
 )
 (func $~lib/string/String.__eq (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (if
   (i32.eq
    (local.get $0)
    (local.get $1)
   )
   (return
    (i32.const 1)
   )
  )
  (if
   (select
    (i32.eqz
     (local.get $1)
    )
    (i32.const 1)
    (local.get $0)
   )
   (return
    (i32.const 0)
   )
  )
  (if
   (i32.ne
    (local.tee $2
     (call $~lib/string/String#get:length
      (local.get $0)
     )
    )
    (call $~lib/string/String#get:length
     (local.get $1)
    )
   )
   (return
    (i32.const 0)
   )
  )
  (i32.eqz
   (block $__inlined_func$~lib/util/string/compareImpl (result i32)
    (local.set $3
     (local.get $0)
    )
    (local.set $0
     (local.get $2)
    )
    (loop $while-continue|0
     (local.set $0
      (i32.sub
       (local.tee $2
        (local.get $0)
       )
       (i32.const 1)
      )
     )
     (if
      (local.get $2)
      (block
       (if
        (i32.ne
         (local.tee $2
          (i32.load16_u
           (local.get $3)
          )
         )
         (local.tee $4
          (i32.load16_u
           (local.get $1)
          )
         )
        )
        (br $__inlined_func$~lib/util/string/compareImpl
         (i32.sub
          (local.get $2)
          (local.get $4)
         )
        )
       )
       (local.set $3
        (i32.add
         (local.get $3)
         (i32.const 2)
        )
       )
       (local.set $1
        (i32.add
         (local.get $1)
         (i32.const 2)
        )
       )
       (br $while-continue|0)
      )
     )
    )
    (i32.const 0)
   )
  )
 )
 (func $~lib/as-chain/action/readActionData (result i32)
  (local $0 i32)
  (local $1 i32)
  (drop
   (call $~lib/as-chain/env/read_action_data
    (i32.load offset=4
     (local.tee $1
      (call $~lib/array/Array<u8>#constructor
       (local.tee $0
        (call $~lib/as-chain/env/action_data_size)
       )
      )
     )
    )
    (local.get $0)
   )
  )
  (local.get $1)
 )
 (func $~lib/as-chain/serializer/Decoder#unpackString (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (loop $while-continue|0
   (local.set $4
    (i32.load8_u
     (i32.add
      (i32.load offset=4
       (i32.load
        (local.get $0)
       )
      )
      (i32.load offset=4
       (local.get $0)
      )
     )
    )
   )
   (call $~lib/as-chain/serializer/Decoder#incPos
    (local.get $0)
    (i32.const 1)
   )
   (local.set $2
    (i32.or
     (local.get $2)
     (i32.shl
      (i32.and
       (local.get $4)
       (i32.const 127)
      )
      (local.get $1)
     )
    )
   )
   (local.set $1
    (i32.add
     (local.get $1)
     (i32.const 7)
    )
   )
   (local.set $3
    (i32.add
     (local.get $3)
     (i32.const 1)
    )
   )
   (br_if $while-continue|0
    (i32.and
     (local.get $4)
     (i32.const 128)
    )
   )
  )
  (local.set $1
   (call $~lib/array/Array<u8>#slice
    (i32.load
     (local.get $0)
    )
    (i32.load offset=4
     (local.get $0)
    )
    (i32.add
     (local.get $2)
     (i32.load offset=4
      (local.get $0)
     )
    )
   )
  )
  (call $~lib/as-chain/serializer/Decoder#incPos
   (local.get $0)
   (local.get $2)
  )
  (call $~lib/string/String.UTF8.decode
   (i32.load
    (local.get $1)
   )
  )
 )
 (func $contract/TransferData#unpack (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local.set $1
   (call $~lib/as-chain/serializer/Decoder#constructor
    (local.get $1)
   )
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $2)
   (i64.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.get $2)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $0)
   (local.get $2)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $2)
   (i64.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.get $2)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (local.get $2)
  )
  (global.set $~argumentsLength
   (i32.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.tee $2
    (call $~lib/as-chain/asset/Asset#constructor@varargs)
   )
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $0)
   (local.get $2)
  )
  (call $~lib/rt/common/OBJECT#set:rtId
   (local.get $0)
   (call $~lib/as-chain/serializer/Decoder#unpackString
    (local.get $1)
   )
  )
  (i32.load offset=4
   (local.get $1)
  )
 )
 (func $contract/ApproveData#unpack (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local.set $1
   (call $~lib/as-chain/serializer/Decoder#constructor
    (local.get $1)
   )
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $2)
   (i64.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.get $2)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $0)
   (local.get $2)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $2)
   (i64.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.get $2)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (local.get $2)
  )
  (global.set $~argumentsLength
   (i32.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.tee $2
    (call $~lib/as-chain/asset/Asset#constructor@varargs)
   )
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $0)
   (local.get $2)
  )
  (i32.load offset=4
   (local.get $1)
  )
 )
 (func $contract/TransferFromData#unpack (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local.set $1
   (call $~lib/as-chain/serializer/Decoder#constructor
    (local.get $1)
   )
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $2)
   (i64.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.get $2)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $0)
   (local.get $2)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $2)
   (i64.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.get $2)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (local.get $2)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $2)
   (i64.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.get $2)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo2
   (local.get $0)
   (local.get $2)
  )
  (global.set $~argumentsLength
   (i32.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.tee $2
    (call $~lib/as-chain/asset/Asset#constructor@varargs)
   )
  )
  (call $~lib/rt/common/OBJECT#set:rtId
   (local.get $0)
   (local.get $2)
  )
  (call $~lib/rt/common/OBJECT#set:rtSize
   (local.get $0)
   (call $~lib/as-chain/serializer/Decoder#unpackString
    (local.get $1)
   )
  )
  (i32.load offset=4
   (local.get $1)
  )
 )
 (func $contract/BalanceOfData#unpack (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local.set $2
   (call $~lib/as-chain/serializer/Decoder#constructor
    (local.get $1)
   )
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $1
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $1)
   (i64.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $2)
   (local.get $1)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $0)
   (local.get $1)
  )
  (i32.load offset=4
   (local.get $2)
  )
 )
 (func $contract/AllowanceData#unpack (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local.set $1
   (call $~lib/as-chain/serializer/Decoder#constructor
    (local.get $1)
   )
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $2)
   (i64.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.get $2)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $0)
   (local.get $2)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $2
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $2)
   (i64.const 0)
  )
  (call $~lib/as-chain/serializer/Decoder#unpack
   (local.get $1)
   (local.get $2)
  )
  (call $~lib/rt/common/OBJECT#set:gcInfo
   (local.get $0)
   (local.get $2)
  )
  (i32.load offset=4
   (local.get $1)
  )
 )
 (func $contract/apply (param $0 i64) (param $1 i64) (param $2 i64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local.set $7
   (call $contract/erc20like#constructor
    (i32.const 0)
    (local.get $0)
    (local.get $1)
    (local.get $2)
   )
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $3
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $3)
   (local.get $2)
  )
  (if
   (call $~lib/string/String.__eq
    (local.tee $3
     (call $~lib/as-chain/name/Name#toString
      (local.get $3)
     )
    )
    (i32.const 5952)
   )
   (block
    (local.set $6
     (call $~lib/as-chain/action/readActionData)
    )
    (global.set $~argumentsLength
     (i32.const 0)
    )
    (call $~lib/as-chain/name/Name#set:N
     (local.tee $4
      (call $~lib/rt/stub/__new
       (i32.const 8)
       (i32.const 5)
      )
     )
     (i64.const 0)
    )
    (call $~lib/as-chain/name/Name#set:N
     (local.get $4)
     (i64.const 0)
    )
    (global.set $~argumentsLength
     (i32.const 0)
    )
    (local.set $5
     (call $~lib/as-chain/asset/Asset#constructor@varargs)
    )
    (call $~lib/rt/common/BLOCK#set:mmInfo
     (local.tee $3
      (call $~lib/rt/stub/__new
       (i32.const 8)
       (i32.const 41)
      )
     )
     (local.get $4)
    )
    (call $~lib/rt/common/OBJECT#set:gcInfo
     (local.get $3)
     (local.get $5)
    )
    (drop
     (call $contract/Allowance#unpack
      (local.get $3)
      (local.get $6)
     )
    )
    (call $contract/erc20like#mint
     (local.get $7)
     (i32.load
      (local.get $3)
     )
     (i32.load offset=4
      (local.get $3)
     )
    )
   )
   (if
    (call $~lib/string/String.__eq
     (local.get $3)
     (i32.const 5984)
    )
    (block
     (local.set $8
      (call $~lib/as-chain/action/readActionData)
     )
     (global.set $~argumentsLength
      (i32.const 0)
     )
     (call $~lib/as-chain/name/Name#set:N
      (local.tee $5
       (call $~lib/rt/stub/__new
        (i32.const 8)
        (i32.const 5)
       )
      )
      (i64.const 0)
     )
     (call $~lib/as-chain/name/Name#set:N
      (local.get $5)
      (i64.const 0)
     )
     (call $~lib/as-chain/name/Name#set:N
      (local.tee $4
       (call $~lib/rt/stub/__new
        (i32.const 8)
        (i32.const 5)
       )
      )
      (i64.const 0)
     )
     (call $~lib/as-chain/name/Name#set:N
      (local.get $4)
      (i64.const 0)
     )
     (global.set $~argumentsLength
      (i32.const 0)
     )
     (local.set $6
      (call $~lib/as-chain/asset/Asset#constructor@varargs)
     )
     (call $~lib/rt/common/BLOCK#set:mmInfo
      (local.tee $3
       (call $~lib/rt/stub/__new
        (i32.const 16)
        (i32.const 42)
       )
      )
      (local.get $5)
     )
     (call $~lib/rt/common/OBJECT#set:gcInfo
      (local.get $3)
      (local.get $4)
     )
     (call $~lib/rt/common/OBJECT#set:gcInfo2
      (local.get $3)
      (local.get $6)
     )
     (call $~lib/rt/common/OBJECT#set:rtId
      (local.get $3)
      (i32.const 2448)
     )
     (drop
      (call $contract/TransferData#unpack
       (local.get $3)
       (local.get $8)
      )
     )
     (call $contract/erc20like#transfer
      (local.get $7)
      (i32.load
       (local.get $3)
      )
      (i32.load offset=4
       (local.get $3)
      )
      (i32.load offset=8
       (local.get $3)
      )
      (i32.load offset=12
       (local.get $3)
      )
     )
    )
    (if
     (call $~lib/string/String.__eq
      (local.get $3)
      (i32.const 6032)
     )
     (block
      (local.set $8
       (call $~lib/as-chain/action/readActionData)
      )
      (global.set $~argumentsLength
       (i32.const 0)
      )
      (call $~lib/as-chain/name/Name#set:N
       (local.tee $5
        (call $~lib/rt/stub/__new
         (i32.const 8)
         (i32.const 5)
        )
       )
       (i64.const 0)
      )
      (call $~lib/as-chain/name/Name#set:N
       (local.get $5)
       (i64.const 0)
      )
      (call $~lib/as-chain/name/Name#set:N
       (local.tee $4
        (call $~lib/rt/stub/__new
         (i32.const 8)
         (i32.const 5)
        )
       )
       (i64.const 0)
      )
      (call $~lib/as-chain/name/Name#set:N
       (local.get $4)
       (i64.const 0)
      )
      (global.set $~argumentsLength
       (i32.const 0)
      )
      (local.set $6
       (call $~lib/as-chain/asset/Asset#constructor@varargs)
      )
      (call $~lib/rt/common/BLOCK#set:mmInfo
       (local.tee $3
        (call $~lib/rt/stub/__new
         (i32.const 12)
         (i32.const 43)
        )
       )
       (local.get $5)
      )
      (call $~lib/rt/common/OBJECT#set:gcInfo
       (local.get $3)
       (local.get $4)
      )
      (call $~lib/rt/common/OBJECT#set:gcInfo2
       (local.get $3)
       (local.get $6)
      )
      (drop
       (call $contract/ApproveData#unpack
        (local.get $3)
        (local.get $8)
       )
      )
      (call $contract/erc20like#approve
       (local.get $7)
       (i32.load
        (local.get $3)
       )
       (i32.load offset=4
        (local.get $3)
       )
       (i32.load offset=8
        (local.get $3)
       )
      )
     )
     (if
      (call $~lib/string/String.__eq
       (local.get $3)
       (i32.const 6080)
      )
      (block
       (local.set $9
        (call $~lib/as-chain/action/readActionData)
       )
       (global.set $~argumentsLength
        (i32.const 0)
       )
       (call $~lib/as-chain/name/Name#set:N
        (local.tee $6
         (call $~lib/rt/stub/__new
          (i32.const 8)
          (i32.const 5)
         )
        )
        (i64.const 0)
       )
       (call $~lib/as-chain/name/Name#set:N
        (local.get $6)
        (i64.const 0)
       )
       (call $~lib/as-chain/name/Name#set:N
        (local.tee $5
         (call $~lib/rt/stub/__new
          (i32.const 8)
          (i32.const 5)
         )
        )
        (i64.const 0)
       )
       (call $~lib/as-chain/name/Name#set:N
        (local.get $5)
        (i64.const 0)
       )
       (call $~lib/as-chain/name/Name#set:N
        (local.tee $4
         (call $~lib/rt/stub/__new
          (i32.const 8)
          (i32.const 5)
         )
        )
        (i64.const 0)
       )
       (call $~lib/as-chain/name/Name#set:N
        (local.get $4)
        (i64.const 0)
       )
       (global.set $~argumentsLength
        (i32.const 0)
       )
       (local.set $8
        (call $~lib/as-chain/asset/Asset#constructor@varargs)
       )
       (call $~lib/rt/common/BLOCK#set:mmInfo
        (local.tee $3
         (call $~lib/rt/stub/__new
          (i32.const 20)
          (i32.const 44)
         )
        )
        (local.get $6)
       )
       (call $~lib/rt/common/OBJECT#set:gcInfo
        (local.get $3)
        (local.get $5)
       )
       (call $~lib/rt/common/OBJECT#set:gcInfo2
        (local.get $3)
        (local.get $4)
       )
       (call $~lib/rt/common/OBJECT#set:rtId
        (local.get $3)
        (local.get $8)
       )
       (call $~lib/rt/common/OBJECT#set:rtSize
        (local.get $3)
        (i32.const 2448)
       )
       (drop
        (call $contract/TransferFromData#unpack
         (local.get $3)
         (local.get $9)
        )
       )
       (call $contract/erc20like#transferFrom
        (local.get $7)
        (i32.load
         (local.get $3)
        )
        (i32.load offset=4
         (local.get $3)
        )
        (i32.load offset=8
         (local.get $3)
        )
        (i32.load offset=12
         (local.get $3)
        )
        (i32.load offset=16
         (local.get $3)
        )
       )
      )
      (if
       (call $~lib/string/String.__eq
        (local.get $3)
        (i32.const 6128)
       )
       (block
        (local.set $5
         (call $~lib/as-chain/action/readActionData)
        )
        (global.set $~argumentsLength
         (i32.const 0)
        )
        (call $~lib/as-chain/name/Name#set:N
         (local.tee $3
          (call $~lib/rt/stub/__new
           (i32.const 8)
           (i32.const 5)
          )
         )
         (i64.const 0)
        )
        (call $~lib/as-chain/name/Name#set:N
         (local.get $3)
         (i64.const 0)
        )
        (call $~lib/rt/common/BLOCK#set:mmInfo
         (local.tee $4
          (call $~lib/rt/stub/__new
           (i32.const 4)
           (i32.const 45)
          )
         )
         (local.get $3)
        )
        (drop
         (call $contract/BalanceOfData#unpack
          (local.get $4)
          (local.get $5)
         )
        )
        (call $contract/erc20like#balanceOf
         (local.get $7)
         (i32.load
          (local.get $4)
         )
        )
       )
       (if
        (call $~lib/string/String.__eq
         (local.get $3)
         (i32.const 6176)
        )
        (block
         (local.set $6
          (call $~lib/as-chain/action/readActionData)
         )
         (global.set $~argumentsLength
          (i32.const 0)
         )
         (call $~lib/as-chain/name/Name#set:N
          (local.tee $5
           (call $~lib/rt/stub/__new
            (i32.const 8)
            (i32.const 5)
           )
          )
          (i64.const 0)
         )
         (call $~lib/as-chain/name/Name#set:N
          (local.get $5)
          (i64.const 0)
         )
         (call $~lib/as-chain/name/Name#set:N
          (local.tee $4
           (call $~lib/rt/stub/__new
            (i32.const 8)
            (i32.const 5)
           )
          )
          (i64.const 0)
         )
         (call $~lib/as-chain/name/Name#set:N
          (local.get $4)
          (i64.const 0)
         )
         (call $~lib/rt/common/BLOCK#set:mmInfo
          (local.tee $3
           (call $~lib/rt/stub/__new
            (i32.const 8)
            (i32.const 46)
           )
          )
          (local.get $5)
         )
         (call $~lib/rt/common/OBJECT#set:gcInfo
          (local.get $3)
          (local.get $4)
         )
         (drop
          (call $contract/AllowanceData#unpack
           (local.get $3)
           (local.get $6)
          )
         )
         (call $contract/erc20like#allowance
          (local.get $7)
          (i32.load
           (local.get $3)
          )
          (i32.load offset=4
           (local.get $3)
          )
         )
        )
       )
      )
     )
    )
   )
  )
 )
 (func $contract/erc20like#transfer@varargs (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 i32)
  (block $1of1
   (block $0of1
    (block $outOfRange
     (br_table $0of1 $1of1 $outOfRange
      (i32.sub
       (global.get $~argumentsLength)
       (i32.const 3)
      )
     )
    )
    (unreachable)
   )
   (local.set $4
    (i32.const 2448)
   )
  )
  (call $contract/erc20like#transfer
   (local.get $0)
   (local.get $1)
   (local.get $2)
   (local.get $3)
   (local.get $4)
  )
 )
 (func $contract/erc20like#transferFrom@varargs (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 i32) (param $5 i32)
  (block $1of1
   (block $0of1
    (block $outOfRange
     (br_table $0of1 $1of1 $outOfRange
      (i32.sub
       (global.get $~argumentsLength)
       (i32.const 4)
      )
     )
    )
    (unreachable)
   )
   (local.set $5
    (i32.const 2448)
   )
  )
  (call $contract/erc20like#transferFrom
   (local.get $0)
   (local.get $1)
   (local.get $2)
   (local.get $3)
   (local.get $4)
   (local.get $5)
  )
 )
 (func $~lib/as-chain/serializer/Decoder#unpackNumber<u64> (param $0 i32) (result i64)
  (local $1 i64)
  (local.set $1
   (i64.load
    (i32.add
     (i32.load offset=4
      (i32.load
       (local.get $0)
      )
     )
     (i32.load offset=4
      (local.get $0)
     )
    )
   )
  )
  (call $~lib/as-chain/serializer/Decoder#incPos
   (local.get $0)
   (i32.const 8)
  )
  (local.get $1)
 )
 (func $~lib/as-chain/serializer/Packer#unpack@virtual (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i64)
  (block $folding-inner0
   (block $default
    (block $case11
     (block $case10
      (block $case9
       (block $case8
        (block $case7
         (block $case6
          (block $case5
           (block $case4
            (block $case1
             (if
              (i32.ne
               (local.tee $2
                (i32.load
                 (i32.sub
                  (local.get $0)
                  (i32.const 8)
                 )
                )
               )
               (i32.const 9)
              )
              (block
               (br_if $case1
                (i32.eq
                 (local.get $2)
                 (i32.const 23)
                )
               )
               (br_if $folding-inner0
                (i32.or
                 (i32.eq
                  (local.get $2)
                  (i32.const 27)
                 )
                 (i32.eq
                  (local.get $2)
                  (i32.const 41)
                 )
                )
               )
               (br_if $case4
                (i32.eq
                 (local.get $2)
                 (i32.const 42)
                )
               )
               (br_if $case5
                (i32.eq
                 (local.get $2)
                 (i32.const 43)
                )
               )
               (br_if $case6
                (i32.eq
                 (local.get $2)
                 (i32.const 44)
                )
               )
               (br_if $case7
                (i32.eq
                 (local.get $2)
                 (i32.const 45)
                )
               )
               (br_if $case8
                (i32.eq
                 (local.get $2)
                 (i32.const 46)
                )
               )
               (br_if $case9
                (i32.eq
                 (local.get $2)
                 (i32.const 5)
                )
               )
               (br_if $case10
                (i32.eq
                 (local.get $2)
                 (i32.const 12)
                )
               )
               (br_if $case11
                (i32.eq
                 (local.get $2)
                 (i32.const 13)
                )
               )
               (br $default)
              )
             )
             (return
              (call $contract/Stat#unpack
               (local.get $0)
               (local.get $1)
              )
             )
            )
            (return
             (call $contract/Account#unpack
              (local.get $0)
              (local.get $1)
             )
            )
           )
           (return
            (call $contract/TransferData#unpack
             (local.get $0)
             (local.get $1)
            )
           )
          )
          (return
           (call $contract/ApproveData#unpack
            (local.get $0)
            (local.get $1)
           )
          )
         )
         (return
          (call $contract/TransferFromData#unpack
           (local.get $0)
           (local.get $1)
          )
         )
        )
        (return
         (call $contract/BalanceOfData#unpack
          (local.get $0)
          (local.get $1)
         )
        )
       )
       (return
        (call $contract/AllowanceData#unpack
         (local.get $0)
         (local.get $1)
        )
       )
      )
      (call $~lib/as-chain/name/Name#set:N
       (local.get $0)
       (call $~lib/as-chain/serializer/Decoder#unpackNumber<u64>
        (call $~lib/as-chain/serializer/Decoder#constructor
         (local.get $1)
        )
       )
      )
      (return
       (i32.const 8)
      )
     )
     (call $~lib/as-chain/name/Name#set:N
      (local.get $0)
      (call $~lib/as-chain/serializer/Decoder#unpackNumber<u64>
       (local.tee $1
        (call $~lib/as-chain/serializer/Decoder#constructor
         (local.get $1)
        )
       )
      )
     )
     (call $~lib/as-chain/system/check
      (call $~lib/as-chain/asset/Symbol#isValid
       (local.get $0)
      )
      (i32.const 6224)
     )
     (return
      (i32.load offset=4
       (local.get $1)
      )
     )
    )
    (local.set $3
     (i64.load
      (i32.add
       (i32.load offset=4
        (i32.load
         (local.tee $1
          (call $~lib/as-chain/serializer/Decoder#constructor
           (local.get $1)
          )
         )
        )
       )
       (i32.load offset=4
        (local.get $1)
       )
      )
     )
    )
    (call $~lib/as-chain/serializer/Decoder#incPos
     (local.get $1)
     (i32.const 8)
    )
    (call $~lib/as-chain/name/Name#set:N
     (local.get $0)
     (local.get $3)
    )
    (call $~lib/as-chain/serializer/Decoder#unpack
     (local.get $1)
     (i32.load offset=8
      (local.get $0)
     )
    )
    (call $~lib/as-chain/system/check
     (call $~lib/as-chain/asset/Asset#isValid
      (local.get $0)
     )
     (i32.const 5040)
    )
    (return
     (i32.load offset=4
      (local.get $1)
     )
    )
   )
   (unreachable)
  )
  (call $contract/Allowance#unpack
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/as-chain/utils/Utils.calcPackedStringLength (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local.set $1
   (call $~lib/arraybuffer/ArrayBuffer#get:byteLength
    (local.tee $2
     (call $~lib/string/String.UTF8.encode
      (local.get $0)
      (i32.const 0)
     )
    )
   )
  )
  (local.set $0
   (i32.const 0)
  )
  (loop $while-continue|0
   (local.set $0
    (i32.add
     (local.get $0)
     (i32.const 1)
    )
   )
   (br_if $while-continue|0
    (local.tee $1
     (i32.shr_u
      (local.get $1)
      (i32.const 7)
     )
    )
   )
  )
  (i32.add
   (call $~lib/arraybuffer/ArrayBuffer#get:byteLength
    (local.get $2)
   )
   (local.get $0)
  )
 )
 (func $~lib/as-chain/serializer/Encoder#packString (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local.set $2
   (call $~lib/arraybuffer/ArrayBuffer#get:byteLength
    (local.tee $1
     (call $~lib/string/String.UTF8.encode
      (local.get $1)
      (i32.const 0)
     )
    )
   )
  )
  (loop $while-continue|0
   (local.set $3
    (i32.load offset=4
     (local.get $0)
    )
   )
   (call $~lib/as-chain/serializer/Encoder#incPos
    (local.get $0)
    (i32.const 1)
   )
   (i32.store8
    (i32.add
     (local.get $3)
     (i32.load offset=4
      (i32.load
       (local.get $0)
      )
     )
    )
    (select
     (i32.or
      (local.tee $3
       (i32.and
        (local.get $2)
        (i32.const 127)
       )
      )
      (i32.const 128)
     )
     (local.get $3)
     (local.tee $2
      (i32.shr_u
       (local.get $2)
       (i32.const 7)
      )
     )
    )
   )
   (local.set $4
    (i32.add
     (local.get $4)
     (i32.const 1)
    )
   )
   (br_if $while-continue|0
    (local.get $2)
   )
  )
  (local.set $2
   (i32.add
    (i32.load offset=4
     (i32.load
      (local.get $0)
     )
    )
    (i32.load offset=4
     (local.get $0)
    )
   )
  )
  (call $~lib/as-chain/serializer/Encoder#incPos
   (local.get $0)
   (call $~lib/arraybuffer/ArrayBuffer#get:byteLength
    (local.get $1)
   )
  )
  (drop
   (call $~lib/as-chain/env/memcpy
    (local.get $2)
    (local.get $1)
    (call $~lib/arraybuffer/ArrayBuffer#get:byteLength
     (local.get $1)
    )
   )
  )
  (drop
   (call $~lib/arraybuffer/ArrayBuffer#get:byteLength
    (local.get $1)
   )
  )
 )
 (func $~lib/as-chain/serializer/Encoder#packNumber<u64> (param $0 i32) (param $1 i64)
  (local $2 i32)
  (local.set $2
   (i32.load offset=4
    (local.get $0)
   )
  )
  (call $~lib/as-chain/serializer/Encoder#incPos
   (local.get $0)
   (i32.const 8)
  )
  (i64.store
   (i32.add
    (local.get $2)
    (i32.load offset=4
     (i32.load
      (local.get $0)
     )
    )
   )
   (local.get $1)
  )
 )
 (func $~lib/as-chain/serializer/Packer#pack@virtual (param $0 i32) (result i32)
  (local $1 i32)
  (block $folding-inner1
   (block
    (block $folding-inner0
     (block
      (block $default
       (block $case11
        (block $case10
         (block $case9
          (block $case8
           (block $case7
            (block $case6
             (block $case5
              (block $case4
               (block $case3
                (block $case2
                 (block $case1
                  (if
                   (i32.ne
                    (local.tee $1
                     (i32.load
                      (i32.sub
                       (local.get $0)
                       (i32.const 8)
                      )
                     )
                    )
                    (i32.const 9)
                   )
                   (block
                    (br_if $case1
                     (i32.eq
                      (local.get $1)
                      (i32.const 23)
                     )
                    )
                    (br_if $case2
                     (i32.eq
                      (local.get $1)
                      (i32.const 27)
                     )
                    )
                    (br_if $case3
                     (i32.eq
                      (local.get $1)
                      (i32.const 41)
                     )
                    )
                    (br_if $case4
                     (i32.eq
                      (local.get $1)
                      (i32.const 42)
                     )
                    )
                    (br_if $case5
                     (i32.eq
                      (local.get $1)
                      (i32.const 43)
                     )
                    )
                    (br_if $case6
                     (i32.eq
                      (local.get $1)
                      (i32.const 44)
                     )
                    )
                    (br_if $case7
                     (i32.eq
                      (local.get $1)
                      (i32.const 45)
                     )
                    )
                    (br_if $case8
                     (i32.eq
                      (local.get $1)
                      (i32.const 46)
                     )
                    )
                    (br_if $case9
                     (i32.eq
                      (local.get $1)
                      (i32.const 5)
                     )
                    )
                    (br_if $case10
                     (i32.eq
                      (local.get $1)
                      (i32.const 12)
                     )
                    )
                    (br_if $case11
                     (i32.eq
                      (local.get $1)
                      (i32.const 13)
                     )
                    )
                    (br $default)
                   )
                  )
                  (return
                   (call $contract/Stat#pack
                    (local.get $0)
                   )
                  )
                 )
                 (return
                  (call $contract/Account#pack
                   (local.get $0)
                  )
                 )
                )
                (return
                 (call $contract/Allowance#pack
                  (local.get $0)
                 )
                )
               )
               (return
                (call $contract/Allowance#pack
                 (local.get $0)
                )
               )
              )
              (call $~lib/as-chain/serializer/Encoder#pack
               (local.tee $1
                (call $~lib/as-chain/serializer/Encoder#constructor
                 (block (result i32)
                  (drop
                   (i32.load
                    (local.get $0)
                   )
                  )
                  (drop
                   (i32.load offset=4
                    (local.get $0)
                   )
                  )
                  (drop
                   (i32.load offset=8
                    (local.get $0)
                   )
                  )
                  (i32.add
                   (call $~lib/as-chain/utils/Utils.calcPackedStringLength
                    (i32.load offset=12
                     (local.get $0)
                    )
                   )
                   (i32.const 32)
                  )
                 )
                )
               )
               (i32.load
                (local.get $0)
               )
              )
              (call $~lib/as-chain/serializer/Encoder#pack
               (local.get $1)
               (i32.load offset=4
                (local.get $0)
               )
              )
              (call $~lib/as-chain/serializer/Encoder#pack
               (local.get $1)
               (i32.load offset=8
                (local.get $0)
               )
              )
              (call $~lib/as-chain/serializer/Encoder#packString
               (local.get $1)
               (i32.load offset=12
                (local.get $0)
               )
              )
              (br $folding-inner1)
             )
             (call $~lib/as-chain/serializer/Encoder#pack
              (local.tee $1
               (call $~lib/as-chain/serializer/Encoder#constructor
                (block (result i32)
                 (drop
                  (i32.load
                   (local.get $0)
                  )
                 )
                 (drop
                  (i32.load offset=4
                   (local.get $0)
                  )
                 )
                 (drop
                  (i32.load offset=8
                   (local.get $0)
                  )
                 )
                 (i32.const 32)
                )
               )
              )
              (i32.load
               (local.get $0)
              )
             )
             (call $~lib/as-chain/serializer/Encoder#pack
              (local.get $1)
              (i32.load offset=4
               (local.get $0)
              )
             )
             (br $folding-inner0)
            )
            (call $~lib/as-chain/serializer/Encoder#pack
             (local.tee $1
              (call $~lib/as-chain/serializer/Encoder#constructor
               (block (result i32)
                (drop
                 (i32.load
                  (local.get $0)
                 )
                )
                (drop
                 (i32.load offset=4
                  (local.get $0)
                 )
                )
                (drop
                 (i32.load offset=8
                  (local.get $0)
                 )
                )
                (drop
                 (i32.load offset=12
                  (local.get $0)
                 )
                )
                (i32.add
                 (call $~lib/as-chain/utils/Utils.calcPackedStringLength
                  (i32.load offset=16
                   (local.get $0)
                  )
                 )
                 (i32.const 40)
                )
               )
              )
             )
             (i32.load
              (local.get $0)
             )
            )
            (call $~lib/as-chain/serializer/Encoder#pack
             (local.get $1)
             (i32.load offset=4
              (local.get $0)
             )
            )
            (call $~lib/as-chain/serializer/Encoder#pack
             (local.get $1)
             (i32.load offset=8
              (local.get $0)
             )
            )
            (call $~lib/as-chain/serializer/Encoder#pack
             (local.get $1)
             (i32.load offset=12
              (local.get $0)
             )
            )
            (call $~lib/as-chain/serializer/Encoder#packString
             (local.get $1)
             (i32.load offset=16
              (local.get $0)
             )
            )
            (br $folding-inner1)
           )
           (call $~lib/as-chain/serializer/Encoder#pack
            (local.tee $1
             (call $~lib/as-chain/serializer/Encoder#constructor
              (block (result i32)
               (drop
                (i32.load
                 (local.get $0)
                )
               )
               (i32.const 8)
              )
             )
            )
            (i32.load
             (local.get $0)
            )
           )
           (br $folding-inner1)
          )
          (call $~lib/as-chain/serializer/Encoder#pack
           (local.tee $1
            (call $~lib/as-chain/serializer/Encoder#constructor
             (block (result i32)
              (drop
               (i32.load
                (local.get $0)
               )
              )
              (drop
               (i32.load offset=4
                (local.get $0)
               )
              )
              (i32.const 16)
             )
            )
           )
           (i32.load
            (local.get $0)
           )
          )
          (call $~lib/as-chain/serializer/Encoder#pack
           (local.get $1)
           (i32.load offset=4
            (local.get $0)
           )
          )
          (br $folding-inner1)
         )
         (i64.store
          (i32.load offset=4
           (local.tee $1
            (call $~lib/array/Array<u8>#constructor
             (i32.const 8)
            )
           )
          )
          (i64.load
           (local.get $0)
          )
         )
         (return
          (local.get $1)
         )
        )
        (call $~lib/as-chain/serializer/Encoder#packNumber<u64>
         (local.tee $1
          (call $~lib/as-chain/serializer/Encoder#constructor
           (i32.const 8)
          )
         )
         (i64.load
          (local.get $0)
         )
        )
        (br $folding-inner1)
       )
       (call $~lib/as-chain/serializer/Encoder#packNumber<u64>
        (local.tee $1
         (call $~lib/as-chain/serializer/Encoder#constructor
          (i32.const 16)
         )
        )
        (i64.load
         (local.get $0)
        )
       )
       (br $folding-inner0)
      )
      (unreachable)
     )
    )
    (call $~lib/as-chain/serializer/Encoder#pack
     (local.get $1)
     (i32.load offset=8
      (local.get $0)
     )
    )
   )
  )
  (call $~lib/as-chain/serializer/Encoder#getBytes
   (local.get $1)
  )
 )
 (func $~lib/as-chain/idxdb/IDXDB#storeEx@virtual (param $0 i32) (param $1 i64) (param $2 i32) (param $3 i64)
  (drop
   (i32.load
    (i32.sub
     (local.get $0)
     (i32.const 8)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/as-chain/idxdb/IDXDB#findPrimaryEx@virtual (param $0 i32) (result i32)
  (drop
   (i32.load
    (i32.sub
     (local.get $0)
     (i32.const 8)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/as-chain/idxdb/IDXDB#updateEx@virtual (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i64)
  (drop
   (i32.load
    (i32.sub
     (local.get $0)
     (i32.const 8)
    )
   )
  )
  (unreachable)
 )
 (func $~setArgumentsLength (param $0 i32)
  (global.set $~argumentsLength
   (local.get $0)
  )
 )
 (func $~start
  (local $0 i32)
  (global.set $~lib/rt/stub/offset
   (i32.const 6252)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $0
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $0)
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.tee $0
    (call $~lib/rt/stub/__new
     (i32.const 8)
     (i32.const 5)
    )
   )
   (i64.const 0)
  )
  (call $~lib/as-chain/name/Name#set:N
   (local.get $0)
   (i64.const 0)
  )
 )
)
