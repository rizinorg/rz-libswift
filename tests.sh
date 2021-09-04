#!/bin/bash

## https://github.com/mattgallagher/CwlDemangle/blob/master/CwlDemangle/manglings.txt

RUN_ALL=false
if [ "$1" == "--all" ]; then
	RUN_ALL=true
fi

test() {
	local RET=$(./swift-demangle "$1")
	if [ "$RET" != "$2" ]; then
		if $RUN_ALL; then
			echo -e "[\e[31mXX\e[0m] $1"
		else
			echo "Mismatch: ./swift-demangle \"$1\""
			echo "Input: $1"
			echo "Got: $RET"
			echo "Exp: $2"
			exit 1
		fi
	elif $RUN_ALL; then
		echo -e "[\e[32mOK\e[0m] $1"
	fi
}

test _TtBf32_ Builtin.FPIEEE32
test _TtBf64_ Builtin.FPIEEE64
test _TtBf80_ Builtin.FPIEEE80
test _TtBi32_ Builtin.Int32
test \$sBf32_ Builtin.FPIEEE32
test \$sBf64_ Builtin.FPIEEE64
test \$sBf80_ Builtin.FPIEEE80
test \$sBi32_ Builtin.Int32
test _TtBw Builtin.Word
test _TtBO Builtin.UnknownObject
test _TtBo Builtin.NativeObject
test _TtBp Builtin.RawPointer
test _TtBt Builtin.SILToken
test _TtBv4Bi8_ Builtin.Vec4xInt8
test _TtBv4Bf16_ Builtin.Vec4xFPIEEE16
test _TtBv4Bp Builtin.Vec4xRawPointer
test _TtSa Swift.Array
test _TtSb Swift.Bool
test _TtSc Swift.UnicodeScalar
test _TtSd Swift.Double
test _TtSf Swift.Float
test _TtSi Swift.Int
test _TtSq Swift.Optional
test _TtSS Swift.String
test _TtSu Swift.UInt
test _TtGSPSi_ Swift.UnsafePointer\<Swift.Int\>
test _TtGSpSi_ Swift.UnsafeMutablePointer\<Swift.Int\>
test _TtSV Swift.UnsafeRawPointer
test _TtSv Swift.UnsafeMutableRawPointer
test _TtGSaSS_ Swift.Array\<Swift.String\>
test _TtGSqSS_ Swift.Optional\<Swift.String\>
test _TtGVs10DictionarySSSi_ Swift.Dictionary\<Swift.String\,\ Swift.Int\>
test _TtVs7CString Swift.CString
test _TtCSo8NSObject __C.NSObject
test _TtO6Monads6Either Monads.Either
test _TtbSiSu @convention\(block\)\ \(Swift.Int\)\ -\>\ Swift.UInt
test _TtcSiSu @convention\(c\)\ \(Swift.Int\)\ -\>\ Swift.UInt
test _TtbTSiSc_Su @convention\(block\)\ \(Swift.Int\,\ Swift.UnicodeScalar\)\ -\>\ Swift.UInt
test _TtcTSiSc_Su @convention\(c\)\ \(Swift.Int\,\ Swift.UnicodeScalar\)\ -\>\ Swift.UInt
test _TtFSiSu \(Swift.Int\)\ -\>\ Swift.UInt
test _TtKSiSu @autoclosure\ \(Swift.Int\)\ -\>\ Swift.UInt
test _TtFSiFScSu \(Swift.Int\)\ -\>\ \(Swift.UnicodeScalar\)\ -\>\ Swift.UInt
test _TtMSi Swift.Int.Type
test _TtP_ Any
test _TtP3foo3bar_ foo.bar
test _TtP3foo3barS_3bas_ foo.bar\ \&\ foo.bas
test _TtTP3foo3barS_3bas_PS1__PS1_S_3zimS0___ \(foo.bar\ \&\ foo.bas\,\ foo.bas\,\ foo.bas\ \&\ foo.zim\ \&\ foo.bar\)
test _TtRSi inout\ Swift.Int
test _TtTSiSu_ \(Swift.Int\,\ Swift.UInt\)
test _TttSiSu_ \(Swift.Int\,\ Swift.UInt...\)
test _TtT3fooSi3barSu_ \(foo:\ Swift.Int\,\ bar:\ Swift.UInt\)
test _TturFxx \<A\>\(A\)\ -\>\ A
test _TtuzrFT_T_ \<\>\(\)\ -\>\ \(\)
test _Ttu__rFxqd__ \<A\>\<A1\>\(A\)\ -\>\ A1
test _Ttu_z_rFxqd0__ \<A\>\<\>\<A2\>\(A\)\ -\>\ A2
test _Ttu0_rFxq_ \<A\,\ B\>\(A\)\ -\>\ B
test _TtuRxs8RunciblerFxwx5Mince \<A\ where\ A:\ Swift.Runcible\>\(A\)\ -\>\ A.Mince
test _TtuRxle64xs8RunciblerFxwx5Mince \<A\ where\ A:\ _Trivial\(64\)\,\ A:\ Swift.Runcible\>\(A\)\ -\>\ A.Mince
test _TtuRxlE64_16rFxwx5Mince \<A\ where\ A:\ _Trivial\(64\,\ 16\)\>\(A\)\ -\>\ A.Mince
test _TtuRxlE64_32xs8RunciblerFxwx5Mince \<A\ where\ A:\ _Trivial\(64\,\ 32\)\,\ A:\ Swift.Runcible\>\(A\)\ -\>\ A.Mince
test _TtuRxlM64_16rFxwx5Mince \<A\ where\ A:\ _TrivialAtMost\(64\,\ 16\)\>\(A\)\ -\>\ A.Mince
test _TtuRxle64rFxwx5Mince \<A\ where\ A:\ _Trivial\(64\)\>\(A\)\ -\>\ A.Mince
test _TtuRxlm64rFxwx5Mince \<A\ where\ A:\ _TrivialAtMost\(64\)\>\(A\)\ -\>\ A.Mince
test _TtuRxlNrFxwx5Mince \<A\ where\ A:\ _NativeRefCountedObject\>\(A\)\ -\>\ A.Mince
test _TtuRxlRrFxwx5Mince \<A\ where\ A:\ _RefCountedObject\>\(A\)\ -\>\ A.Mince
test _TtuRxlUrFxwx5Mince \<A\ where\ A:\ _UnknownLayout\>\(A\)\ -\>\ A.Mince
test _TtuRxs8RunciblerFxWx5Mince6Quince_ \<A\ where\ A:\ Swift.Runcible\>\(A\)\ -\>\ A.Mince.Quince
test _TtuRxs8Runciblexs8FungiblerFxwxPS_5Mince \<A\ where\ A:\ Swift.Runcible\,\ A:\ Swift.Fungible\>\(A\)\ -\>\ A.Swift.Runcible.Mince
test _TtuRxCs22AbstractRuncingFactoryrFxx \<A\ where\ A:\ Swift.AbstractRuncingFactory\>\(A\)\ -\>\ A
test _TtuRxs8Runciblewx5MincezxrFxx \<A\ where\ A:\ Swift.Runcible\,\ A.Mince\ ==\ A\>\(A\)\ -\>\ A
test _TtuRxs8RuncibleWx5Mince6Quince_zxrFxx \<A\ where\ A:\ Swift.Runcible\,\ A.Mince.Quince\ ==\ A\>\(A\)\ -\>\ A
test _Ttu0_Rxs8Runcible_S_wx5Minces8Fungiblew_S0_S1_rFxq_ \<A\,\ B\ where\ A:\ Swift.Runcible\,\ B:\ Swift.Runcible\,\ A.Mince:\ Swift.Fungible\,\ B.Mince:\ Swift.Fungible\>\(A\)\ -\>\ B
test _Ttu0_Rx3Foo3BarxCS_3Bas_S0__S1_rT_ \<A\,\ B\ where\ A:\ Foo.Bar\,\ A:\ Foo.Bas\,\ B:\ Foo.Bar\,\ B:\ Foo.Bas\>\ \(\)
test _Tv3foo3barSi foo.bar\ :\ Swift.Int
test _TF3fooau3barSi foo.bar.unsafeMutableAddressor\ :\ Swift.Int
test _TF3foolu3barSi foo.bar.unsafeAddressor\ :\ Swift.Int
test _TF3fooaO3barSi foo.bar.owningMutableAddressor\ :\ Swift.Int
test _TF3foolO3barSi foo.bar.owningAddressor\ :\ Swift.Int
test _TF3fooao3barSi foo.bar.nativeOwningMutableAddressor\ :\ Swift.Int
test _TF3foolo3barSi foo.bar.nativeOwningAddressor\ :\ Swift.Int
test _TF3fooap3barSi foo.bar.nativePinningMutableAddressor\ :\ Swift.Int
test _TF3foolp3barSi foo.bar.nativePinningAddressor\ :\ Swift.Int
test _TF3foog3barSi foo.bar.getter\ :\ Swift.Int
test _TF3foos3barSi foo.bar.setter\ :\ Swift.Int
test _TFC3foo3bar3basfT3zimCS_3zim_T_ foo.bar.bas\(zim:\ foo.zim\)\ -\>\ \(\)
test _TToFC3foo3bar3basfT3zimCS_3zim_T_ @objc\ foo.bar.bas\(zim:\ foo.zim\)\ -\>\ \(\)
test _TTOFSC3fooFTSdSd_Sd @nonobjc\ __C_Synthesized.foo\(Swift.Double\,\ Swift.Double\)\ -\>\ Swift.Double
test _T03foo3barC3basyAA3zimCAE_tFTo @objc\ foo.bar.bas\(zim:\ foo.zim\)\ -\>\ \(\)
test _T0SC3fooS2d_SdtFTO @nonobjc\ __C_Synthesized.foo\(Swift.Double\,\ Swift.Double\)\ -\>\ Swift.Double
test _\$s3foo3barC3bas3zimyAaEC_tFTo @objc\ foo.bar.bas\(zim:\ foo.zim\)\ -\>\ \(\)
test _\$sSC3fooyS2d_SdtFTO @nonobjc\ __C_Synthesized.foo\(Swift.Double\,\ Swift.Double\)\ -\>\ Swift.Double
test _\$S3foo3barC3bas3zimyAaEC_tFTo @objc\ foo.bar.bas\(zim:\ foo.zim\)\ -\>\ \(\)
test _\$SSC3fooyS2d_SdtFTO @nonobjc\ __C_Synthesized.foo\(Swift.Double\,\ Swift.Double\)\ -\>\ Swift.Double
test _\$S3foo3barC3bas3zimyAaEC_tFTo @objc\ foo.bar.bas\(zim:\ foo.zim\)\ -\>\ \(\)
test _\$SSC3fooyS2d_SdtFTO @nonobjc\ __C_Synthesized.foo\(Swift.Double\,\ Swift.Double\)\ -\>\ Swift.Double
test _\$sTA.123 partial\ apply\ forwarder\ with\ unmangled\ suffix\ \".123\"
test _TTDFC3foo3bar3basfT3zimCS_3zim_T_ dynamic\ foo.bar.bas\(zim:\ foo.zim\)\ -\>\ \(\)
test _TFC3foo3bar3basfT3zimCS_3zim_T_ foo.bar.bas\(zim:\ foo.zim\)\ -\>\ \(\)
test _TF3foooi1pFTCS_3barVS_3bas_OS_3zim foo.+\ infix\(foo.bar\,\ foo.bas\)\ -\>\ foo.zim
test _TF3foooP1xFTCS_3barVS_3bas_OS_3zim foo.\^\ postfix\(foo.bar\,\ foo.bas\)\ -\>\ foo.zim
test _TFC3foo3barCfT_S0_ foo.bar.__allocating_init\(\)\ -\>\ foo.bar
test _TFC3foo3barcfT_S0_ foo.bar.init\(\)\ -\>\ foo.bar
test _TFC3foo3barD foo.bar.__deallocating_deinit
test _TFC3foo3bard foo.bar.deinit
test _TMPC3foo3bar generic\ type\ metadata\ pattern\ for\ foo.bar
test _TMnC3foo3bar nominal\ type\ descriptor\ for\ foo.bar
test _TMmC3foo3bar metaclass\ for\ foo.bar
test _TMC3foo3bar type\ metadata\ for\ foo.bar
test _TMfC3foo3bar full\ type\ metadata\ for\ foo.bar
test _TwalC3foo3bar allocateBuffer\ value\ witness\ for\ foo.bar
test _TwcaC3foo3bar assignWithCopy\ value\ witness\ for\ foo.bar
test _TwtaC3foo3bar assignWithTake\ value\ witness\ for\ foo.bar
test _TwdeC3foo3bar deallocateBuffer\ value\ witness\ for\ foo.bar
test _TwxxC3foo3bar destroy\ value\ witness\ for\ foo.bar
test _TwXXC3foo3bar destroyBuffer\ value\ witness\ for\ foo.bar
test _TwCPC3foo3bar initializeBufferWithCopyOfBuffer\ value\ witness\ for\ foo.bar
test _TwCpC3foo3bar initializeBufferWithCopy\ value\ witness\ for\ foo.bar
test _TwcpC3foo3bar initializeWithCopy\ value\ witness\ for\ foo.bar
test _TwTKC3foo3bar initializeBufferWithTakeOfBuffer\ value\ witness\ for\ foo.bar
test _TwTkC3foo3bar initializeBufferWithTake\ value\ witness\ for\ foo.bar
test _TwtkC3foo3bar initializeWithTake\ value\ witness\ for\ foo.bar
test _TwprC3foo3bar projectBuffer\ value\ witness\ for\ foo.bar
test _TWVC3foo3bar value\ witness\ table\ for\ foo.bar
test _TWvdvC3foo3bar3basSi direct\ field\ offset\ for\ foo.bar.bas\ :\ Swift.Int
test _TWvivC3foo3bar3basSi indirect\ field\ offset\ for\ foo.bar.bas\ :\ Swift.Int
test _TWPC3foo3barS_8barrables protocol\ witness\ table\ for\ foo.bar\ :\ foo.barrable\ in\ Swift
test _TWaC3foo3barS_8barrableS_ protocol\ witness\ table\ accessor\ for\ foo.bar\ :\ foo.barrable\ in\ foo
test _TWlC3foo3barS0_S_8barrableS_ lazy\ protocol\ witness\ table\ accessor\ for\ type\ foo.bar\ and\ conformance\ foo.bar\ :\ foo.barrable\ in\ foo
test _TWLC3foo3barS0_S_8barrableS_ lazy\ protocol\ witness\ table\ cache\ variable\ for\ type\ foo.bar\ and\ conformance\ foo.bar\ :\ foo.barrable\ in\ foo
test _TWGC3foo3barS_8barrableS_ generic\ protocol\ witness\ table\ for\ foo.bar\ :\ foo.barrable\ in\ foo
test _TWIC3foo3barS_8barrableS_ instantiation\ function\ for\ generic\ protocol\ witness\ table\ for\ foo.bar\ :\ foo.barrable\ in\ foo
test _TWtC3foo3barS_8barrableS_4fred associated\ type\ metadata\ accessor\ for\ fred\ in\ foo.bar\ :\ foo.barrable\ in\ foo
test _TWTC3foo3barS_8barrableS_4fredS_6thomas associated\ type\ witness\ table\ accessor\ for\ fred\ :\ foo.thomas\ in\ foo.bar\ :\ foo.barrable\ in\ foo
test _TFSCg5greenVSC5Color __C_Synthesized.green.getter\ :\ __C_Synthesized.Color
test _TIF1t1fFT1iSi1sSS_T_A_ default\ argument\ 0\ of\ t.f\(i:\ Swift.Int\,\ s:\ Swift.String\)\ -\>\ \(\)
test _TIF1t1fFT1iSi1sSS_T_A0_ default\ argument\ 1\ of\ t.f\(i:\ Swift.Int\,\ s:\ Swift.String\)\ -\>\ \(\)
test _TFSqcfT_GSqx_ Swift.Optional.init\(\)\ -\>\ Swift.Optional\<A\>
test _TF21class_bound_protocols32class_bound_protocol_compositionFT1xPS_10ClassBoundS_13NotClassBound__PS0_S1__ class_bound_protocols.class_bound_protocol_composition\(x:\ class_bound_protocols.ClassBound\ \&\ class_bound_protocols.NotClassBound\)\ -\>\ class_bound_protocols.ClassBound\ \&\ class_bound_protocols.NotClassBound
test _TtZZ _TtZZ
test _TtB _TtB
test _TtBSi _TtBSi
test _TtBx _TtBx
test _TtC _TtC
test _TtT _TtT
test _TtTSi _TtTSi
test _TtQd_ _TtQd_
test _TtU__FQo_Si _TtU__FQo_Si
test _TtU__FQD__Si _TtU__FQD__Si
test _TtU___FQ_U____FQd0__T_ _TtU___FQ_U____FQd0__T_
test _TtU___FQ_U____FQd_1_T_ _TtU___FQ_U____FQd_1_T_
test _TtU___FQ_U____FQ2_T_ _TtU___FQ_U____FQ2_T_
test _Tw _Tw
test _TWa _TWa
test _Twal _Twal
test _T _T
test _TTo _TTo
test _TC _TC
test _TM _TM
test _TM _TM
test _TW _TW
test _TWV _TWV
test _TWo _TWo
test _TWv _TWv
test _TWvd _TWvd
test _TWvi _TWvi
test _TWvx _TWvx
test _TtVCC4main3Foo4Ding3Str main.Foo.Ding.Str
test _TFVCC6nested6AClass12AnotherClass7AStruct9aFunctionfT1aSi_S2_ nested.AClass.AnotherClass.AStruct.aFunction\(a:\ Swift.Int\)\ -\>\ nested.AClass.AnotherClass.AStruct
test _TtXwC10attributes10SwiftClass weak\ attributes.SwiftClass
test _TtXoC10attributes10SwiftClass unowned\ attributes.SwiftClass
test _TtERR \<ERROR\ TYPE\>
test _TtGSqGSaC5sugar7MyClass__ Swift.Optional\<Swift.Array\<sugar.MyClass\>\>
test _TtGSaGSqC5sugar7MyClass__ Swift.Array\<Swift.Optional\<sugar.MyClass\>\>
test _TtaC9typealias5DWARF9DIEOffset typealias.DWARF.DIEOffset
test _Tta1t5Alias t.Alias
test _Ttas3Int Swift.Int
test _TTRXFo_dSc_dSb_XFo_iSc_iSb_ reabstraction\ thunk\ helper\ from\ @callee_owned\ \(@in\ Swift.UnicodeScalar\)\ -\>\ \(@out\ Swift.Bool\)\ to\ @callee_owned\ \(@unowned\ Swift.UnicodeScalar\)\ -\>\ \(@unowned\ Swift.Bool\)
test _TTRXFo_dSi_dGSqSi__XFo_iSi_iGSqSi__ reabstraction\ thunk\ helper\ from\ @callee_owned\ \(@in\ Swift.Int\)\ -\>\ \(@out\ Swift.Optional\<Swift.Int\>\)\ to\ @callee_owned\ \(@unowned\ Swift.Int\)\ -\>\ \(@unowned\ Swift.Optional\<Swift.Int\>\)
test _TTRGrXFo_iV18switch_abstraction1A_ix_XFo_dS0__ix_ reabstraction\ thunk\ helper\ \<A\>\ from\ @callee_owned\ \(@unowned\ switch_abstraction.A\)\ -\>\ \(@out\ A\)\ to\ @callee_owned\ \(@in\ switch_abstraction.A\)\ -\>\ \(@out\ A\)
test _TFCF5types1gFT1bSb_T_L0_10Collection3zimfT_T_ zim\(\)\ -\>\ \(\)\ in\ Collection\ #2\ in\ types.g\(b:\ Swift.Bool\)\ -\>\ \(\)
test _TFF17capture_promotion22test_capture_promotionFT_FT_SiU_FT_Si_promote0 closure\ #1\ \(\)\ -\>\ Swift.Int\ in\ capture_promotion.test_capture_promotion\(\)\ -\>\ \(\)\ -\>\ Swift.Int\ with\ unmangled\ suffix\ \"_promote0\"
test _TFIVs8_Processi10_argumentsGSaSS_U_FT_GSaSS_ _arguments\ :\ Swift.Array\<Swift.String\>\ in\ variable\ initialization\ expression\ of\ Swift._Process\ with\ unmangled\ suffix\ \"U_FT_GSaSS_\"
test _TFIvVs8_Process10_argumentsGSaSS_iU_FT_GSaSS_ closure\ #1\ \(\)\ -\>\ Swift.Array\<Swift.String\>\ in\ variable\ initialization\ expression\ of\ Swift._Process._arguments\ :\ Swift.Array\<Swift.String\>
test _TFCSo1AE __C.A.__ivar_destroyer
test _TFCSo1Ae __C.A.__ivar_initializer
test _TTWC13call_protocol1CS_1PS_FS1_3foofT_Si protocol\ witness\ for\ call_protocol.P.foo\(\)\ -\>\ Swift.Int\ in\ conformance\ call_protocol.C\ :\ call_protocol.P\ in\ call_protocol
test _T013call_protocol1CCAA1PA2aDP3fooSiyFTW protocol\ witness\ for\ call_protocol.P.foo\(\)\ -\>\ Swift.Int\ in\ conformance\ call_protocol.C\ :\ call_protocol.P\ in\ call_protocol
test _TFC12dynamic_self1X1ffT_DS0_ dynamic_self.X.f\(\)\ -\>\ Self
test _TTSg5Si___TFSqcfT_GSqx_ generic\ specialization\ \<Swift.Int\>\ of\ Swift.Optional.init\(\)\ -\>\ Swift.Optional\<A\>
test _TTSgq5Si___TFSqcfT_GSqx_ generic\ specialization\ \<serialized\,\ Swift.Int\>\ of\ Swift.Optional.init\(\)\ -\>\ Swift.Optional\<A\>
test _TTSg5SiSis3Foos_Sf___TFSqcfT_GSqx_ generic\ specialization\ \<Swift.Int\ with\ Swift.Int\ :\ Swift.Foo\ in\ Swift\,\ Swift.Float\>\ of\ Swift.Optional.init\(\)\ -\>\ Swift.Optional\<A\>
test _TTSg5Si_Sf___TFSqcfT_GSqx_ generic\ specialization\ \<Swift.Int\,\ Swift.Float\>\ of\ Swift.Optional.init\(\)\ -\>\ Swift.Optional\<A\>
test _TTSg5Si_Sf___TFSqcfT_GSqx_ generic\ specialization\ \<Swift.Int\,\ Swift.Float\>\ of\ Swift.Optional.init\(\)\ -\>\ Swift.Optional\<A\>
test _TTSgS _TTSgS
test _TTSg5S _TTSg5S
test _TTSgSi _TTSgSi
test _TTSg5Si _TTSg5Si
test _TTSgSi_ _TTSgSi_
test _TTSgSi__ _TTSgSi__
test _TTSgSiS_ _TTSgSiS_
test _TTSgSi__xyz _TTSgSi__xyz
test _TTSr5Si___TF4test7genericurFxx generic\ not\ re-abstracted\ specialization\ \<Swift.Int\>\ of\ test.generic\<A\>\(A\)\ -\>\ A
test _TTSrq5Si___TF4test7genericurFxx generic\ not\ re-abstracted\ specialization\ \<serialized\,\ Swift.Int\>\ of\ test.generic\<A\>\(A\)\ -\>\ A
test _TPA__TTRXFo_oSSoSS_dSb_XFo_iSSiSS_dSb_ partial\ apply\ forwarder\ for\ reabstraction\ thunk\ helper\ from\ @callee_owned\ \(@in\ Swift.String\,\ @in\ Swift.String\)\ -\>\ \(@unowned\ Swift.Bool\)\ to\ @callee_owned\ \(@owned\ Swift.String\,\ @owned\ Swift.String\)\ -\>\ \(@unowned\ Swift.Bool\)
test to\ @callee_owned\ \(@in\ Swift.String\,\ @in\ Swift.String\)\ -\>\ \(@unowned\ Swift.Bool\) to\ @callee_owned\ \(@in\ Swift.String\,\ @in\ Swift.String\)\ -\>\ \(@unowned\ Swift.Bool\)
test _TPAo__TTRGrXFo_dGSPx__dGSPx_zoPs5Error__XFo_iGSPx__iGSPx_zoPS___ partial\ apply\ ObjC\ forwarder\ for\ reabstraction\ thunk\ helper\ \<A\>\ from\ @callee_owned\ \(@in\ Swift.UnsafePointer\<A\>\)\ -\>\ \(@out\ Swift.UnsafePointer\<A\>\,\ @error\ @owned\ Swift.Error\)\ to\ @callee_owned\ \(@unowned\ Swift.UnsafePointer\<A\>\)\ -\>\ \(@unowned\ Swift.UnsafePointer\<A\>\,\ @error\ @owned\ Swift.Error\)
test _T0S2SSbIxxxd_S2SSbIxiid_TRTA partial\ apply\ forwarder\ for\ reabstraction\ thunk\ helper\ from\ @callee_owned\ \(@owned\ Swift.String\,\ @owned\ Swift.String\)\ -\>\ \(@unowned\ Swift.Bool\)\ to\ @callee_owned\ \(@in\ Swift.String\,\ @in\ Swift.String\)\ -\>\ \(@unowned\ Swift.Bool\)
test _T0SPyxGAAs5Error_pIxydzo_A2AsAB_pIxirzo_lTRTa partial\ apply\ ObjC\ forwarder\ for\ reabstraction\ thunk\ helper\ \<A\>\ from\ @callee_owned\ \(@unowned\ Swift.UnsafePointer\<A\>\)\ -\>\ \(@unowned\ Swift.UnsafePointer\<A\>\,\ @error\ @owned\ Swift.Error\)\ to\ @callee_owned\ \(@in\ Swift.UnsafePointer\<A\>\)\ -\>\ \(@out\ Swift.UnsafePointer\<A\>\,\ @error\ @owned\ Swift.Error\)
test _TiC4Meow5MyCls9subscriptFT1iSi_Sf Meow.MyCls.subscript\(i:\ Swift.Int\)\ -\>\ Swift.Float
test _TF8manglingX22egbpdajGbuEbxfgehfvwxnFT_T_ mangling.ليهمابتكلموشعربي؟\(\)\ -\>\ \(\)
test _TF8manglingX24ihqwcrbEcvIaIdqgAFGpqjyeFT_T_ mangling.他们为什么不说中文\(\)\ -\>\ \(\)
test _TF8manglingX27ihqwctvzcJBfGFJdrssDxIboAybFT_T_ mangling.他們爲什麽不說中文\(\)\ -\>\ \(\)
test _TF8manglingX30Proprostnemluvesky_uybCEdmaEBaFT_T_ mangling.Pročprostěnemluvíčesky\(\)\ -\>\ \(\)
test _TF8manglingXoi7p_qcaDcFTSiSi_Si mangling.«+»\ infix\(Swift.Int\,\ Swift.Int\)\ -\>\ Swift.Int
test _TF8manglingoi2qqFTSiSi_T_ mangling.\?\?\ infix\(Swift.Int\,\ Swift.Int\)\ -\>\ \(\)
test _TFE11ext_structAV11def_structA1A4testfT_T_ \(extension\ in\ ext_structA\):def_structA.A.test\(\)\ -\>\ \(\)
test _TF13devirt_accessP5_DISC15getPrivateClassFT_CS_P5_DISC12PrivateClass devirt_access.\(getPrivateClass\ in\ _DISC\)\(\)\ -\>\ devirt_access.\(PrivateClass\ in\ _DISC\)
test _TF4mainP5_mainX3wxaFT_T_ main.\(λ\ in\ _main\)\(\)\ -\>\ \(\)
test _TF4mainP5_main3abcFT_aS_P5_DISC3xyz main.\(abc\ in\ _main\)\(\)\ -\>\ main.\(xyz\ in\ _DISC\)
test _TtPMP_ Any.Type
test _TFCs13_NSSwiftArray29canStoreElementsOfDynamicTypefPMP_Sb Swift._NSSwiftArray.canStoreElementsOfDynamicType\(Any.Type\)\ -\>\ Swift.Bool
test _TFCs13_NSSwiftArrayg17staticElementTypePMP_ Swift._NSSwiftArray.staticElementType.getter\ :\ Any.Type
test _TFCs17_DictionaryMirrorg9valueTypePMP_ Swift._DictionaryMirror.valueType.getter\ :\ Any.Type
test _TTSf1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_ function\ signature\ specialization\ \<Arg\[0\]\ =\ \[Closure\ Propagated\ :\ closure\ #1\ \(Swift.Int\,\ Swift.Int\)\ -\>\ \(\)\ in\ specgen.caller\(Swift.Int\)\ -\>\ \(\)\,\ Argument\ Types\ :\ \[Swift.Int\]\>\ of\ specgen.take_closure\(\(Swift.Int\,\ Swift.Int\)\ -\>\ \(\)\)\ -\>\ \(\)
test _TTSfq1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_ function\ signature\ specialization\ \<serialized\,\ Arg\[0\]\ =\ \[Closure\ Propagated\ :\ closure\ #1\ \(Swift.Int\,\ Swift.Int\)\ -\>\ \(\)\ in\ specgen.caller\(Swift.Int\)\ -\>\ \(\)\,\ Argument\ Types\ :\ \[Swift.Int\]\>\ of\ specgen.take_closure\(\(Swift.Int\,\ Swift.Int\)\ -\>\ \(\)\)\ -\>\ \(\)
test _TTSf1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TTSg5Si___TF7specgen12take_closureFFTSiSi_T_T_ function\ signature\ specialization\ \<Arg\[0\]\ =\ \[Closure\ Propagated\ :\ closure\ #1\ \(Swift.Int\,\ Swift.Int\)\ -\>\ \(\)\ in\ specgen.caller\(Swift.Int\)\ -\>\ \(\)\,\ Argument\ Types\ :\ \[Swift.Int\]\>\ of\ generic\ specialization\ \<Swift.Int\>\ of\ specgen.take_closure\(\(Swift.Int\,\ Swift.Int\)\ -\>\ \(\)\)\ -\>\ \(\)
test _TTSg5Si___TTSf1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_ generic\ specialization\ \<Swift.Int\>\ of\ function\ signature\ specialization\ \<Arg\[0\]\ =\ \[Closure\ Propagated\ :\ closure\ #1\ \(Swift.Int\,\ Swift.Int\)\ -\>\ \(\)\ in\ specgen.caller\(Swift.Int\)\ -\>\ \(\)\,\ Argument\ Types\ :\ \[Swift.Int\]\>\ of\ specgen.take_closure\(\(Swift.Int\,\ Swift.Int\)\ -\>\ \(\)\)\ -\>\ \(\)
test _TTSf1cpfr24_TF8capturep6helperFSiT__n___TTRXFo_dSi_dT__XFo_iSi_dT__ function\ signature\ specialization\ \<Arg\[0\]\ =\ \[Constant\ Propagated\ Function\ :\ capturep.helper\(Swift.Int\)\ -\>\ \(\)\]\>\ of\ reabstraction\ thunk\ helper\ from\ @callee_owned\ \(@in\ Swift.Int\)\ -\>\ \(@unowned\ \(\)\)\ to\ @callee_owned\ \(@unowned\ Swift.Int\)\ -\>\ \(@unowned\ \(\)\)
test _TTSf1cpfr24_TF8capturep6helperFSiT__n___TTRXFo_dSi_DT__XFo_iSi_DT__ function\ signature\ specialization\ \<Arg\[0\]\ =\ \[Constant\ Propagated\ Function\ :\ capturep.helper\(Swift.Int\)\ -\>\ \(\)\]\>\ of\ reabstraction\ thunk\ helper\ from\ @callee_owned\ \(@in\ Swift.Int\)\ -\>\ \(@unowned_inner_pointer\ \(\)\)\ to\ @callee_owned\ \(@unowned\ Swift.Int\)\ -\>\ \(@unowned_inner_pointer\ \(\)\)
test _TTSf1cpi0_cpfl0_cpse0v4u123_cpg53globalinit_33_06E7F1D906492AE070936A9B58CBAE1C_token8_cpfr36_TFtest_capture_propagation2_closure___TF7specgen12take_closureFFTSiSi_T_T_ function\ signature\ specialization\ \<Arg\[0\]\ =\ \[Constant\ Propagated\ Integer\ :\ 0\]\,\ Arg\[1\]\ =\ \[Constant\ Propagated\ Float\ :\ 0\]\,\ Arg\[2\]\ =\ \[Constant\ Propagated\ String\ :\ u8\'u123\'\]\,\ Arg\[3\]\ =\ \[Constant\ Propagated\ Global\ :\ globalinit_33_06E7F1D906492AE070936A9B58CBAE1C_token8\]\,\ Arg\[4\]\ =\ \[Constant\ Propagated\ Function\ :\ _TFtest_capture_propagation2_closure\]\>\ of\ specgen.take_closure\(\(Swift.Int\,\ Swift.Int\)\ -\>\ \(\)\)\ -\>\ \(\)
test _TTSf0gs___TFVs17_LegacyStringCore15_invariantCheckfT_T_ function\ signature\ specialization\ \<Arg\[0\]\ =\ Owned\ To\ Guaranteed\ and\ Exploded\>\ of\ Swift._LegacyStringCore._invariantCheck\(\)\ -\>\ \(\)
test _TTSf2g___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_ function\ signature\ specialization\ \<Arg\[0\]\ =\ Owned\ To\ Guaranteed\>\ of\ function\ signature\ specialization\ \<Arg\[0\]\ =\ Exploded\,\ Arg\[1\]\ =\ Dead\>\ of\ Swift._LegacyStringCore.init\(Swift._StringBuffer\)\ -\>\ Swift._LegacyStringCore
test _TTSf2dg___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_ function\ signature\ specialization\ \<Arg\[0\]\ =\ Dead\ and\ Owned\ To\ Guaranteed\>\ of\ function\ signature\ specialization\ \<Arg\[0\]\ =\ Exploded\,\ Arg\[1\]\ =\ Dead\>\ of\ Swift._LegacyStringCore.init\(Swift._StringBuffer\)\ -\>\ Swift._LegacyStringCore
test _TTSf2dgs___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_ function\ signature\ specialization\ \<Arg\[0\]\ =\ Dead\ and\ Owned\ To\ Guaranteed\ and\ Exploded\>\ of\ function\ signature\ specialization\ \<Arg\[0\]\ =\ Exploded\,\ Arg\[1\]\ =\ Dead\>\ of\ Swift._LegacyStringCore.init\(Swift._StringBuffer\)\ -\>\ Swift._LegacyStringCore
test _TTSf3d_i_d_i_d_i___TFVs17_LegacyStringCoreCfVs13_StringBufferS_ function\ signature\ specialization\ \<Arg\[0\]\ =\ Dead\,\ Arg\[1\]\ =\ Value\ Promoted\ from\ Box\,\ Arg\[2\]\ =\ Dead\,\ Arg\[3\]\ =\ Value\ Promoted\ from\ Box\,\ Arg\[4\]\ =\ Dead\,\ Arg\[5\]\ =\ Value\ Promoted\ from\ Box\>\ of\ Swift._LegacyStringCore.init\(Swift._StringBuffer\)\ -\>\ Swift._LegacyStringCore
test _TTSf3d_i_n_i_d_i___TFVs17_LegacyStringCoreCfVs13_StringBufferS_ function\ signature\ specialization\ \<Arg\[0\]\ =\ Dead\,\ Arg\[1\]\ =\ Value\ Promoted\ from\ Box\,\ Arg\[3\]\ =\ Value\ Promoted\ from\ Box\,\ Arg\[4\]\ =\ Dead\,\ Arg\[5\]\ =\ Value\ Promoted\ from\ Box\>\ of\ Swift._LegacyStringCore.init\(Swift._StringBuffer\)\ -\>\ Swift._LegacyStringCore
test _TFIZvV8mangling10HasVarInit5stateSbiu_KT_Sb implicit\ closure\ #1\ :\ @autoclosure\ \(\)\ -\>\ Swift.Bool\ in\ variable\ initialization\ expression\ of\ static\ mangling.HasVarInit.state\ :\ Swift.Bool
test _TFFV23interface_type_mangling18GenericTypeContext23closureInGenericContexturFqd__T_L_3fooFTqd__x_T_ foo\ #1\ \(A1\,\ A\)\ -\>\ \(\)\ in\ interface_type_mangling.GenericTypeContext.closureInGenericContext\<A\>\(A1\)\ -\>\ \(\)
test _TFFV23interface_type_mangling18GenericTypeContextg31closureInGenericPropertyContextxL_3fooFT_x foo\ #1\ \(\)\ -\>\ A\ in\ interface_type_mangling.GenericTypeContext.closureInGenericPropertyContext.getter\ :\ A
test _TTWurGV23interface_type_mangling18GenericTypeContextx_S_18GenericWitnessTestS_FS1_23closureInGenericContextuRxS1_rfqd__T_ protocol\ witness\ for\ interface_type_mangling.GenericWitnessTest.closureInGenericContext\<A\ where\ A:\ interface_type_mangling.GenericWitnessTest\>\(A1\)\ -\>\ \(\)\ in\ conformance\ \<A\>\ interface_type_mangling.GenericTypeContext\<A\>\ :\ interface_type_mangling.GenericWitnessTest\ in\ interface_type_mangling
test _TTWurGV23interface_type_mangling18GenericTypeContextx_S_18GenericWitnessTestS_FS1_g31closureInGenericPropertyContextwx3Tee protocol\ witness\ for\ interface_type_mangling.GenericWitnessTest.closureInGenericPropertyContext.getter\ :\ A.Tee\ in\ conformance\ \<A\>\ interface_type_mangling.GenericTypeContext\<A\>\ :\ interface_type_mangling.GenericWitnessTest\ in\ interface_type_mangling
test _TTWurGV23interface_type_mangling18GenericTypeContextx_S_18GenericWitnessTestS_FS1_16twoParamsAtDepthu0_RxS1_rfTqd__1yqd_0__T_ protocol\ witness\ for\ interface_type_mangling.GenericWitnessTest.twoParamsAtDepth\<A\,\ B\ where\ A:\ interface_type_mangling.GenericWitnessTest\>\(A1\,\ y:\ B1\)\ -\>\ \(\)\ in\ conformance\ \<A\>\ interface_type_mangling.GenericTypeContext\<A\>\ :\ interface_type_mangling.GenericWitnessTest\ in\ interface_type_mangling
test _TFC3red11BaseClassEHcfzT1aSi_S0_ red.BaseClassEH.init\(a:\ Swift.Int\)\ throws\ -\>\ red.BaseClassEH
test _TFe27mangling_generic_extensionsRxS_8RunciblerVS_3Foog1aSi \(extension\ in\ mangling_generic_extensions\):mangling_generic_extensions.Foo\<A\ where\ A:\ mangling_generic_extensions.Runcible\>.a.getter\ :\ Swift.Int
test _TFe27mangling_generic_extensionsRxS_8RunciblerVS_3Foog1bx \(extension\ in\ mangling_generic_extensions\):mangling_generic_extensions.Foo\<A\ where\ A:\ mangling_generic_extensions.Runcible\>.b.getter\ :\ A
test _TTRXFo_iT__iT_zoPs5Error__XFo__dT_zoPS___ reabstraction\ thunk\ helper\ from\ @callee_owned\ \(\)\ -\>\ \(@unowned\ \(\)\,\ @error\ @owned\ Swift.Error\)\ to\ @callee_owned\ \(@in\ \(\)\)\ -\>\ \(@out\ \(\)\,\ @error\ @owned\ Swift.Error\)
test _TFE1a _TFE1a
test _TF21\$__lldb_module_for_E0au3\$E0Ps5Error_ \$__lldb_module_for_E0.\$E0.unsafeMutableAddressor\ :\ Swift.Error
test _TMps10Comparable protocol\ descriptor\ for\ Swift.Comparable
test _TFC4testP33_83378C430F65473055F1BD53F3ADCDB71C5doFoofT_T_ test.\(C\ in\ _83378C430F65473055F1BD53F3ADCDB7\).doFoo\(\)\ -\>\ \(\)
test _TFVV15nested_generics5Lunch6DinnerCfT11firstCoursex12secondCourseGSqqd___9leftoversx14transformationFxqd___GS1_x_qd___ nested_generics.Lunch.Dinner.init\(firstCourse:\ A\,\ secondCourse:\ Swift.Optional\<A1\>\,\ leftovers:\ A\,\ transformation:\ \(A\)\ -\>\ A1\)\ -\>\ nested_generics.Lunch\<A\>.Dinner\<A1\>
test _TFVFC15nested_generics7HotDogs11applyRelishFT_T_L_6RelishCfT8materialx_GS1_x_ init\(material:\ A\)\ -\>\ Relish\ #1\ in\ nested_generics.HotDogs.applyRelish\(\)\ -\>\ \(\)\<A\>\ in\ Relish\ #1\ in\ nested_generics.HotDogs.applyRelish\(\)\ -\>\ \(\)
test _TFVFE15nested_genericsSS3fooFT_T_L_6CheeseCfT8materialx_GS0_x_ init\(material:\ A\)\ -\>\ Cheese\ #1\ in\ \(extension\ in\ nested_generics\):Swift.String.foo\(\)\ -\>\ \(\)\<A\>\ in\ Cheese\ #1\ in\ \(extension\ in\ nested_generics\):Swift.String.foo\(\)\ -\>\ \(\)
test _TTWOE5imojiCSo5Imoji14ImojiMatchRankS_9RankValueS_FS2_g9rankValueqq_Ss16RawRepresentable8RawValue _TTWOE5imojiCSo5Imoji14ImojiMatchRankS_9RankValueS_FS2_g9rankValueqq_Ss16RawRepresentable8RawValue
test _T0s17MutableCollectionP1asAARzs012RandomAccessB0RzsAA11SubSequences013BidirectionalB0PRpzsAdHRQlE06rotatecD05Indexs01_A9IndexablePQzAM15shiftingToStart_tFAJs01_J4BasePQzAQcfU_ closure\ #1\ \(A.Swift._IndexableBase.Index\)\ -\>\ A.Swift._IndexableBase.Index\ in\ \(extension\ in\ a\):Swift.MutableCollection\<A\ where\ A:\ Swift.MutableCollection\,\ A:\ Swift.RandomAccessCollection\,\ A.Swift.BidirectionalCollection.SubSequence:\ Swift.MutableCollection\,\ A.Swift.BidirectionalCollection.SubSequence:\ Swift.RandomAccessCollection\>.rotateRandomAccess\(shiftingToStart:\ A.Swift._MutableIndexable.Index\)\ -\>\ A.Swift._MutableIndexable.Index
test _\$Ss17MutableCollectionP1asAARzs012RandomAccessB0RzsAA11SubSequences013BidirectionalB0PRpzsAdHRQlE06rotatecD015shiftingToStart5Indexs01_A9IndexablePQzAN_tFAKs01_M4BasePQzAQcfU_ closure\ #1\ \(A.Swift._IndexableBase.Index\)\ -\>\ A.Swift._IndexableBase.Index\ in\ \(extension\ in\ a\):Swift.MutableCollection\<A\ where\ A:\ Swift.MutableCollection\,\ A:\ Swift.RandomAccessCollection\,\ A.Swift.BidirectionalCollection.SubSequence:\ Swift.MutableCollection\,\ A.Swift.BidirectionalCollection.SubSequence:\ Swift.RandomAccessCollection\>.rotateRandomAccess\(shiftingToStart:\ A.Swift._MutableIndexable.Index\)\ -\>\ A.Swift._MutableIndexable.Index
test _T03foo4_123ABTf3psbpsb_n function\ signature\ specialization\ \<Arg\[0\]\ =\ \[Constant\ Propagated\ String\ :\ u8\'123\'\]\,\ Arg\[1\]\ =\ \[Constant\ Propagated\ String\ :\ u8\'123\'\]\>\ of\ foo
test _T04main5innerys5Int32Vz_yADctF25closure_with_box_argumentxz_Bi32__lXXTf1nc_n function\ signature\ specialization\ \<Arg\[1\]\ =\ \[Closure\ Propagated\ :\ closure_with_box_argument\,\ Argument\ Types\ :\ \[\<A\>\ \{\ var\ A\ \}\ \<Builtin.Int32\>\]\>\ of\ main.inner\(inout\ Swift.Int32\,\ \(Swift.Int32\)\ -\>\ \(\)\)\ -\>\ \(\)
test _\$S4main5inneryys5Int32Vz_yADctF25closure_with_box_argumentxz_Bi32__lXXTf1nc_n function\ signature\ specialization\ \<Arg\[1\]\ =\ \[Closure\ Propagated\ :\ closure_with_box_argument\,\ Argument\ Types\ :\ \[\<A\>\ \{\ var\ A\ \}\ \<Builtin.Int32\>\]\>\ of\ main.inner\(inout\ Swift.Int32\,\ \(Swift.Int32\)\ -\>\ \(\)\)\ -\>\ \(\)
test _T03foo6testityyyc_yyctF1a1bTf3pfpf_n function\ signature\ specialization\ \<Arg\[0\]\ =\ \[Constant\ Propagated\ Function\ :\ a\]\,\ Arg\[1\]\ =\ \[Constant\ Propagated\ Function\ :\ b\]\>\ of\ foo.testit\(\(\)\ -\>\ \(\)\,\ \(\)\ -\>\ \(\)\)\ -\>\ \(\)
test _\$S3foo6testityyyyc_yyctF1a1bTf3pfpf_n function\ signature\ specialization\ \<Arg\[0\]\ =\ \[Constant\ Propagated\ Function\ :\ a\]\,\ Arg\[1\]\ =\ \[Constant\ Propagated\ Function\ :\ b\]\>\ of\ foo.testit\(\(\)\ -\>\ \(\)\,\ \(\)\ -\>\ \(\)\)\ -\>\ \(\)
test _SocketJoinOrLeaveMulticast _SocketJoinOrLeaveMulticast
test _T0s10DictionaryV3t17E6Index2V1loiSbAEyxq__G_AGtFZ static\ \(extension\ in\ t17\):Swift.Dictionary.Index2.\<\ infix\(\(extension\ in\ t17\):Swift.Dictionary\<A\,\ B\>.Index2\,\ \(extension\ in\ t17\):Swift.Dictionary\<A\,\ B\>.Index2\)\ -\>\ Swift.Bool
test _T08mangling14varargsVsArrayySi3arrd_SS1ntF mangling.varargsVsArray\(arr:\ Swift.Int...\,\ n:\ Swift.String\)\ -\>\ \(\)
test _T08mangling14varargsVsArrayySaySiG3arr_SS1ntF mangling.varargsVsArray\(arr:\ Swift.Array\<Swift.Int\>\,\ n:\ Swift.String\)\ -\>\ \(\)
test _T08mangling14varargsVsArrayySaySiG3arrd_SS1ntF mangling.varargsVsArray\(arr:\ Swift.Array\<Swift.Int\>...\,\ n:\ Swift.String\)\ -\>\ \(\)
test _T08mangling14varargsVsArrayySi3arrd_tF mangling.varargsVsArray\(arr:\ Swift.Int...\)\ -\>\ \(\)
test _T08mangling14varargsVsArrayySaySiG3arrd_tF mangling.varargsVsArray\(arr:\ Swift.Array\<Swift.Int\>...\)\ -\>\ \(\)
test _\$Ss10DictionaryV3t17E6Index2V1loiySbAEyxq__G_AGtFZ static\ \(extension\ in\ t17\):Swift.Dictionary.Index2.\<\ infix\(\(extension\ in\ t17\):Swift.Dictionary\<A\,\ B\>.Index2\,\ \(extension\ in\ t17\):Swift.Dictionary\<A\,\ B\>.Index2\)\ -\>\ Swift.Bool
test _\$S8mangling14varargsVsArray3arr1nySid_SStF mangling.varargsVsArray\(arr:\ Swift.Int...\,\ n:\ Swift.String\)\ -\>\ \(\)
test _\$S8mangling14varargsVsArray3arr1nySaySiG_SStF mangling.varargsVsArray\(arr:\ Swift.Array\<Swift.Int\>\,\ n:\ Swift.String\)\ -\>\ \(\)
test _\$S8mangling14varargsVsArray3arr1nySaySiGd_SStF mangling.varargsVsArray\(arr:\ Swift.Array\<Swift.Int\>...\,\ n:\ Swift.String\)\ -\>\ \(\)
test _\$S8mangling14varargsVsArray3arrySid_tF mangling.varargsVsArray\(arr:\ Swift.Int...\)\ -\>\ \(\)
test _\$S8mangling14varargsVsArray3arrySaySiGd_tF mangling.varargsVsArray\(arr:\ Swift.Array\<Swift.Int\>...\)\ -\>\ \(\)
test _T0s13_UnicodeViewsVss22RandomAccessCollectionRzs0A8EncodingR_11SubSequence_5IndexQZAFRtzsAcERpzAE_AEQZAIRSs15UnsignedInteger8Iterator_7ElementRPzAE_AlMQZANRS13EncodedScalar_AlMQY_AORSr0_lE13CharacterViewVyxq__G \(extension\ in\ Swift\):Swift._UnicodeViews\<A\,\ B\>\<A\,\ B\ where\ A:\ Swift.RandomAccessCollection\,\ B:\ Swift.UnicodeVEncoding\,\ A.Index\ ==\ A.SubSequence.Index\,\ A.SubSequence:\ Swift.RandomAccessCollection\,\ A.SubSequence\ ==\ A.SubSequence.SubSequence\,\ A.Iterator.Element:\ Swift.UnsignedInteger\,\ A.Iterator.Element\ ==\ A.SubSequence.Iterator.Element\,\ A.SubSequence.Iterator.Element\ ==\ B.EncodedScalar.Iterator.Element\>.CharacterView
test _T010Foundation11MeasurementV12SimulatorKitSo9UnitAngleCRszlE11OrientationO2eeoiSbAcDEAGOyAF_G_AKtFZ static\ \(extension\ in\ SimulatorKit\):Foundation.Measurement\<A\ where\ A\ ==\ __C.UnitAngle\>.Orientation.==\ infix\(\(extension\ in\ SimulatorKit\):Foundation.Measurement\<__C.UnitAngle\>.Orientation\,\ \(extension\ in\ SimulatorKit\):Foundation.Measurement\<__C.UnitAngle\>.Orientation\)\ -\>\ Swift.Bool
test _\$S10Foundation11MeasurementV12SimulatorKitSo9UnitAngleCRszlE11OrientationO2eeoiySbAcDEAGOyAF_G_AKtFZ static\ \(extension\ in\ SimulatorKit\):Foundation.Measurement\<A\ where\ A\ ==\ __C.UnitAngle\>.Orientation.==\ infix\(\(extension\ in\ SimulatorKit\):Foundation.Measurement\<__C.UnitAngle\>.Orientation\,\ \(extension\ in\ SimulatorKit\):Foundation.Measurement\<__C.UnitAngle\>.Orientation\)\ -\>\ Swift.Bool
test _T04main1_yyF main._\(\)\ -\>\ \(\)
test _T04test6testitSiyt_tF test.testit\(\(\)\)\ -\>\ Swift.Int
test _\$S4test6testitySiyt_tF test.testit\(\(\)\)\ -\>\ Swift.Int
test _T08_ElementQzSbs5Error_pIxxdzo_ABSbsAC_pIxidzo_s26RangeReplaceableCollectionRzABRLClTR reabstraction\ thunk\ helper\ \<A\ where\ A:\ Swift.RangeReplaceableCollection\,\ A._Element:\ AnyObject\>\ from\ @callee_owned\ \(@owned\ A._Element\)\ -\>\ \(@unowned\ Swift.Bool\,\ @error\ @owned\ Swift.Error\)\ to\ @callee_owned\ \(@in\ A._Element\)\ -\>\ \(@unowned\ Swift.Bool\,\ @error\ @owned\ Swift.Error\)
test _T0Ix_IyB_Tr reabstraction\ thunk\ from\ @callee_owned\ \(\)\ -\>\ \(\)\ to\ @callee_unowned\ @convention\(block\)\ \(\)\ -\>\ \(\)
test _T0Rml _T0Rml
test _T0Tk _T0Tk
test _T0A8 _T0A8
test _T0s30ReversedRandomAccessCollectionVyxGTfq3nnpf_nTfq1cn_nTfq4x_n _T0s30ReversedRandomAccessCollectionVyxGTfq3nnpf_nTfq1cn_nTfq4x_n
test _T03abc6testitySiFTm merged\ abc.testit\(Swift.Int\)\ -\>\ \(\)
test _T04main4TestCACSi1x_tc6_PRIV_Llfc main.Test.\(in\ _PRIV_\).init\(x:\ Swift.Int\)\ -\>\ main.Test
test _\$S3abc6testityySiFTm merged\ abc.testit\(Swift.Int\)\ -\>\ \(\)
test _\$S4main4TestC1xACSi_tc6_PRIV_Llfc main.Test.\(in\ _PRIV_\).init\(x:\ Swift.Int\)\ -\>\ main.Test
test _T0SqWOy.17 outlined\ copy\ of\ Swift.Optional\ with\ unmangled\ suffix\ \".17\"
test _T03nix6testitSaySiGyFTv_ outlined\ variable\ #0\ of\ nix.testit\(\)\ -\>\ Swift.Array\<Swift.Int\>
test _T03nix6testitSaySiGyFTv0_ outlined\ variable\ #1\ of\ nix.testit\(\)\ -\>\ Swift.Array\<Swift.Int\>
test _T0So11UITextFieldC4textSSSgvgToTepb_ outlined\ bridged\ method\ \(pb\)\ of\ @objc\ __C.UITextField.text.getter\ :\ Swift.Optional\<Swift.String\>
test _T0So11UITextFieldC4textSSSgvgToTeab_ outlined\ bridged\ method\ \(ab\)\ of\ @objc\ __C.UITextField.text.getter\ :\ Swift.Optional\<Swift.String\>
test \$sSo5GizmoC11doSomethingyypSgSaySSGSgFToTembgnn_ outlined\ bridged\ method\ \(mbgnn\)\ of\ @objc\ __C.Gizmo.doSomething\(Swift.Optional\<Swift.Array\<Swift.String\>\>\)\ -\>\ Swift.Optional\<Any\>
test _T04test1SVyxGAA1RA2A1ZRzAA1Y2ZZRpzl1A_AhaGPWT associated\ type\ witness\ table\ accessor\ for\ A.ZZ\ :\ test.Y\ in\ \<A\ where\ A:\ test.Z\,\ A.ZZ:\ test.Y\>\ test.S\<A\>\ :\ test.R\ in\ test
test _T0s24_UnicodeScalarExceptions33_0E4228093681F6920F0AB2E48B4F1C69LLVACycfC Swift.\(_UnicodeScalarExceptions\ in\ _0E4228093681F6920F0AB2E48B4F1C69\).init\(\)\ -\>\ Swift.\(_UnicodeScalarExceptions\ in\ _0E4228093681F6920F0AB2E48B4F1C69\)
test _T0D _T0D
test _T0s18EnumeratedIteratorVyxGs8Sequencess0B8ProtocolRzlsADP5splitSay03SubC0QzGSi9maxSplits_Sb25omittingEmptySubsequencesSb7ElementQzKc14whereSeparatortKFTW protocol\ witness\ for\ Swift.Sequence.split\(maxSplits:\ Swift.Int\,\ omittingEmptySubsequences:\ Swift.Bool\,\ whereSeparator:\ \(A.Element\)\ throws\ -\>\ Swift.Bool\)\ throws\ -\>\ Swift.Array\<A.SubSequence\>\ in\ conformance\ \<A\ where\ A:\ Swift.IteratorProtocol\>\ Swift.EnumeratedIterator\<A\>\ :\ Swift.Sequence\ in\ Swift
test _T0s3SetVyxGs10CollectiotySivm _T0s3SetVyxGs10CollectiotySivm
test _S\$s3SetVyxGs10CollectiotySivm _S\$s3SetVyxGs10CollectiotySivm
test _T0s18ReversedCollectionVyxGs04LazyB8ProtocolfC _T0s18ReversedCollectionVyxGs04LazyB8ProtocolfC
test _S\$s18ReversedCollectionVyxGs04LazyB8ProtocolfC _S\$s18ReversedCollectionVyxGs04LazyB8ProtocolfC
test _T0iW _T0iW
test _S\$iW _S\$iW
test _T0s5print_9separator10terminatoryypfC _T0s5print_9separator10terminatoryypfC
test _S\$s5print_9separator10terminatoryypfC _S\$s5print_9separator10terminatoryypfC
test _T0So13GenericOptionas8HashableSCsACP9hashValueSivgTW protocol\ witness\ for\ Swift.Hashable.hashValue.getter\ :\ Swift.Int\ in\ conformance\ __C.GenericOption\ :\ Swift.Hashable\ in\ __C_Synthesized
test _T0So11CrappyColorVs16RawRepresentableSCMA reflection\ metadata\ associated\ type\ descriptor\ __C.CrappyColor\ :\ Swift.RawRepresentable\ in\ __C_Synthesized
test \$S28protocol_conformance_records15NativeValueTypeVAA8RuncibleAAMc protocol\ conformance\ descriptor\ for\ protocol_conformance_records.NativeValueType\ :\ protocol_conformance_records.Runcible\ in\ protocol_conformance_records
test \$SSC9SomeErrorLeVD __C_Synthesized.related\ decl\ \'e\'\ for\ SomeError
test \$s20mangling_retroactive5test0yyAA1ZVy12RetroactiveB1XVSiAE1YVAG0D1A1PAAyHCg_AiJ1QAAyHCg1_GF mangling_retroactive.test0\(mangling_retroactive.Z\<RetroactiveB.X\,\ Swift.Int\,\ RetroactiveB.Y\>\)\ -\>\ \(\)
test \$s20mangling_retroactive5test0yyAA1ZVy12RetroactiveB1XVSiAE1YVAG0D1A1PHPyHCg_AiJ1QHPyHCg1_GF mangling_retroactive.test0\(mangling_retroactive.Z\<RetroactiveB.X\,\ Swift.Int\,\ RetroactiveB.Y\>\)\ -\>\ \(\)
test \$s20mangling_retroactive5test0yyAA1ZVy12RetroactiveB1XVSiAE1YVAG0D1A1PHpyHCg_AiJ1QHpyHCg1_GF mangling_retroactive.test0\(mangling_retroactive.Z\<RetroactiveB.X\,\ Swift.Int\,\ RetroactiveB.Y\>\)\ -\>\ \(\)
test _T0LiteralAByxGxd_tcfC _T0LiteralAByxGxd_tcfC
test _T0XZ _T0XZ
test _TTSf0os___TFVs17_LegacyStringCore15_invariantCheckfT_T_ function\ signature\ specialization\ \<Arg\[0\]\ =\ Guaranteed\ To\ Owned\ and\ Exploded\>\ of\ Swift._LegacyStringCore._invariantCheck\(\)\ -\>\ \(\)
test _TTSf2o___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_ function\ signature\ specialization\ \<Arg\[0\]\ =\ Guaranteed\ To\ Owned\>\ of\ function\ signature\ specialization\ \<Arg\[0\]\ =\ Exploded\,\ Arg\[1\]\ =\ Dead\>\ of\ Swift._LegacyStringCore.init\(Swift._StringBuffer\)\ -\>\ Swift._LegacyStringCore
test _TTSf2do___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_ function\ signature\ specialization\ \<Arg\[0\]\ =\ Dead\ and\ Guaranteed\ To\ Owned\>\ of\ function\ signature\ specialization\ \<Arg\[0\]\ =\ Exploded\,\ Arg\[1\]\ =\ Dead\>\ of\ Swift._LegacyStringCore.init\(Swift._StringBuffer\)\ -\>\ Swift._LegacyStringCore
test _TTSf2dos___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_ function\ signature\ specialization\ \<Arg\[0\]\ =\ Dead\ and\ Guaranteed\ To\ Owned\ and\ Exploded\>\ of\ function\ signature\ specialization\ \<Arg\[0\]\ =\ Exploded\,\ Arg\[1\]\ =\ Dead\>\ of\ Swift._LegacyStringCore.init\(Swift._StringBuffer\)\ -\>\ Swift._LegacyStringCore
test _TTSf _TTSf
test _TtW0_j _TtW0_j
test _TtW_4m3a3v _TtW_4m3a3v
test _TVGVGSS_2v0 _TVGVGSS_2v0
test \$SSD1BySSSBsg_G \$SSD1BySSSBsg_G
test _Ttu4222222222222222222222222_rW_2T_2TJ_ \<A\,\ B\,\ C\,\ D\,\ E\,\ F\,\ G\,\ H\,\ I\,\ J\,\ K\,\ L\,\ M\,\ N\,\ O\,\ P\,\ Q\,\ R\,\ S\,\ T\,\ U\,\ V\,\ W\,\ X\,\ Y\,\ Z\,\ AB\,\ BB\,\ CB\,\ DB\,\ EB\,\ FB\,\ GB\,\ HB\,\ IB\,\ JB\,\ KB\,\ LB\,\ MB\,\ NB\,\ OB\,\ PB\,\ QB\,\ RB\,\ SB\,\ TB\,\ UB\,\ VB\,\ WB\,\ XB\,\ YB\,\ ZB\,\ AC\,\ BC\,\ CC\,\ DC\,\ EC\,\ FC\,\ GC\,\ HC\,\ IC\,\ JC\,\ KC\,\ LC\,\ MC\,\ NC\,\ OC\,\ PC\,\ QC\,\ RC\,\ SC\,\ TC\,\ UC\,\ VC\,\ WC\,\ XC\,\ YC\,\ ZC\,\ AD\,\ BD\,\ CD\,\ DD\,\ ED\,\ FD\,\ GD\,\ HD\,\ ID\,\ JD\,\ KD\,\ LD\,\ MD\,\ ND\,\ OD\,\ PD\,\ QD\,\ RD\,\ SD\,\ TD\,\ UD\,\ VD\,\ WD\,\ XD\,\ YD\,\ ZD\,\ AE\,\ BE\,\ CE\,\ DE\,\ EE\,\ FE\,\ GE\,\ HE\,\ IE\,\ JE\,\ KE\,\ LE\,\ ME\,\ NE\,\ OE\,\ PE\,\ QE\,\ RE\,\ SE\,\ TE\,\ UE\,\ VE\,\ WE\,\ XE\,\ ...\>\ B.T_.TJ
test _\$S3BBBBf0602365061_ _\$S3BBBBf0602365061_
test _\$S3BBBBi0602365061_ _\$S3BBBBi0602365061_
test _\$S3BBBBv0602365061_ _\$S3BBBBv0602365061_
test _T0lxxxmmmTk _T0lxxxmmmTk
test _TtCF4test11doNotCrash1FT_QuL_8MyClass1 MyClass1\ #1\ in\ test.doNotCrash1\(\)\ -\>\ some
test \$s3Bar3FooVAA5DrinkVyxGs5Error_pSeRzSERzlyShy4AbcdAHO6MemberVGALSeHPAKSeAAyHC_HCg_ALSEHPAKSEAAyHC_HCg0_Iseggozo_SgWOe outlined\ consume\ of\ Swift.Optional\<@escaping\ @callee_guaranteed\ @substituted\ \<A\ where\ A:\ Swift.Decodable\,\ A:\ Swift.Encodable\>\ \(@guaranteed\ Bar.Foo\)\ -\>\ \(@owned\ Bar.Drink\<A\>\,\ @error\ @owned\ Swift.Error\)\ for\ \<Swift.Set\<Abcd.Abcd.Member\>\>\>
test \$s4Test5ProtoP8IteratorV10collectionAEy_qd__Gqd___tcfc Test.Proto.Iterator.init\(collection:\ A1\)\ -\>\ Test.Proto.Iterator\<A1\>
test \$s4test3fooV4blahyAA1SV1fQryFQOy_Qo_AHF test.foo.blah\(\<\<opaque\ return\ type\ of\ test.S.f\(\)\ -\>\ some\>\>.0\)\ -\>\ \<\<opaque\ return\ type\ of\ test.S.f\(\)\ -\>\ some\>\>.0
test \$S3nix8MystructV1xACyxGx_tcfc7MyaliasL_ayx__GD Myalias\ #1\ in\ nix.Mystruct\<A\>.init\(x:\ A\)\ -\>\ nix.Mystruct\<A\>
test \$S3nix7MyclassCfd7MyaliasL_ayx__GD Myalias\ #1\ in\ nix.Myclass\<A\>.deinit
test \$S3nix8MystructVyS2icig7MyaliasL_ayx__GD Myalias\ #1\ in\ nix.Mystruct\<A\>.subscript.getter\ :\ \(Swift.Int\)\ -\>\ Swift.Int
test \$S3nix8MystructV1x1uACyxGx_qd__tclufc7MyaliasL_ayx_qd___GD Myalias\ #1\ in\ nix.Mystruct\<A\>.\<A1\>\(x:\ A\,\ u:\ A1\)\ -\>\ nix.Mystruct\<A\>
test \$S3nix8MystructV6testit1xyx_tF7MyaliasL_ayx__GD Myalias\ #1\ in\ nix.Mystruct\<A\>.testit\(x:\ A\)\ -\>\ \(\)
test \$S3nix8MystructV6testit1x1u1vyx_qd__qd_0_tr0_lF7MyaliasL_ayx_qd__qd_0__GD Myalias\ #1\ in\ nix.Mystruct\<A\>.testit\<A1\,\ B1\>\(x:\ A\,\ u:\ A1\,\ v:\ B1\)\ -\>\ \(\)
test \$S4blah8PatatinoaySiGD blah.Patatino\<Swift.Int\>
test \$SSiSHsWP protocol\ witness\ table\ for\ Swift.Int\ :\ Swift.Hashable\ in\ Swift
test \$S7TestMod5OuterV3Fooayx_SiGD TestMod.Outer\<A\>.Foo\<Swift.Int\>
test \$Ss17_VariantSetBufferO05CocoaC0ayx_GD Swift._VariantSetBuffer\<A\>.CocoaBuffer
test \$S2t21QP22ProtocolTypeAliasThingayAA4BlahV5SomeQa_GSgD Swift.Optional\<t2.Q\<t2.Blah.SomeQ\>.ProtocolTypeAliasThing\>
test \$s1A1gyyxlFx_qd__t_Ti5 inlined\ generic\ function\ \<\(A\,\ A1\)\>\ of\ A.g\<A\>\(A\)\ -\>\ \(\)
test \$S1T19protocol_resilience17ResilientProtocolPTl associated\ type\ descriptor\ for\ protocol_resilience.ResilientProtocol.T
test \$S18resilient_protocol21ResilientBaseProtocolTL protocol\ requirements\ base\ descriptor\ for\ resilient_protocol.ResilientBaseProtocol
test \$S1t1PP10AssocType2_AA1QTn associated\ conformance\ descriptor\ for\ t.P.AssocType2:\ t.Q
test \$S1t1PP10AssocType2_AA1QTN default\ associated\ conformance\ accessor\ for\ t.P.AssocType2:\ t.Q
test \$sSD5IndexVy__GD \$sSD5IndexVy__GD
test \$s4test3StrCACycfC test.Str.__allocating_init\(\)\ -\>\ test.Str
test \$s18keypaths_inlinable13KeypathStructV8computedSSvpACTKq\  \$s18keypaths_inlinable13KeypathStructV8computedSSvpACTKq\ 
test \$s18resilient_protocol24ResilientDerivedProtocolPxAA0c4BaseE0Tn\ --\>\ associated\ conformance\ descriptor\ for\ resilient_protocol.ResilientDerivedProtocol.A:\ resilient_protocol.ResilientBaseProtocol \$s18resilient_protocol24ResilientDerivedProtocolPxAA0c4BaseE0Tn\ --\>\ associated\ conformance\ descriptor\ for\ resilient_protocol.ResilientDerivedProtocol.A:\ resilient_protocol.ResilientBaseProtocol
test \$s3red4testyAA3ResOyxSayq_GAEs5ErrorAAq_sAFHD1__HCg_GADyxq_GsAFR_r0_lF red.test\<A\,\ B\ where\ B:\ Swift.Error\>\(red.Res\<A\,\ B\>\)\ -\>\ red.Res\<A\,\ Swift.Array\<B\>\>
test \$s3red4testyAA7OurTypeOy4them05TheirD0Vy5AssocQzGAjE0F8ProtocolAAxAA0c7DerivedH0HD1_AA0c4BaseH0HI1_AieKHA2__HCg_GxmAaLRzlF red.test\<A\ where\ A:\ red.OurDerivedProtocol\>\(A.Type\)\ -\>\ red.OurType\<them.TheirType\<A.Assoc\>\>
test \$s17property_wrappers10WithTuplesV9fractionsSd_S2dtvpfP property\ wrapper\ backing\ initializer\ of\ property_wrappers.WithTuples.fractions\ :\ \(Swift.Double\,\ Swift.Double\,\ Swift.Double\)
test \$sSo17OS_dispatch_queueC4sync7executeyyyXE_tFTOTA partial\ apply\ forwarder\ for\ @nonobjc\ __C.OS_dispatch_queue.sync\(execute:\ \(\)\ -\>\ \(\)\)\ -\>\ \(\)
test \$s4main1gyySiXCvp main.g\ :\ @convention\(c\)\ \(Swift.Int\)\ -\>\ \(\)
test \$s4main1gyySiXBvp main.g\ :\ @convention\(block\)\ \(Swift.Int\)\ -\>\ \(\)
test \$sxq_Idgnr_D @differentiable\ @callee_guaranteed\ \(@in_guaranteed\ A\)\ -\>\ \(@out\ B\)
test \$sxq_Ilgnr_D @differentiable\(_linear\)\ @callee_guaranteed\ \(@in_guaranteed\ A\)\ -\>\ \(@out\ B\)
test \$sS3fIedgyywd_D @escaping\ @differentiable\ @callee_guaranteed\ \(@unowned\ Swift.Float\,\ @unowned\ @noDerivative\ Swift.Float\)\ -\>\ \(@unowned\ Swift.Float\)
test \$sS5fIedtyyywddw_D @escaping\ @differentiable\ @convention\(thin\)\ \(@unowned\ Swift.Float\,\ @unowned\ Swift.Float\,\ @unowned\ @noDerivative\ Swift.Float\)\ -\>\ \(@unowned\ Swift.Float\,\ @unowned\ @noDerivative\ Swift.Float\)
test \$syQo \$syQo
test \$s0059xxxxxxxxxxxxxxx_ttttttttBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBee \$s0059xxxxxxxxxxxxxxx_ttttttttBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBee
test \$sx1td_t \(t:\ A...\)
test \$s7example1fyyYF\ -\>\ example.f\(\)\ async\ -\>\ \(\) \$s7example1fyyYF\ -\>\ example.f\(\)\ async\ -\>\ \(\)
test \$s7example1fyyYKF\ -\>\ example.f\(\)\ async\ throws\ -\>\ \(\) \$s7example1fyyYKF\ -\>\ example.f\(\)\ async\ throws\ -\>\ \(\)
test \$s4main20receiveInstantiationyySo34__CxxTemplateInst12MagicWrapperIiEVzF main.receiveInstantiation\(inout\ __C.__CxxTemplateInst12MagicWrapperIiE\)\ -\>\ \(\)
test \$s4main19returnInstantiationSo34__CxxTemplateInst12MagicWrapperIiEVyF main.returnInstantiation\(\)\ -\>\ __C.__CxxTemplateInst12MagicWrapperIiE