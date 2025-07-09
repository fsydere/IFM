# Note: This file is produced automatically, and will be overwritten the next
# time you press "Generate" in the Vitis Model Composer Hub block. 
#


namespace eval ::xilinx::dsp::planaheaddriver {
	set VHDL2008Support 1
	set BoardFileVersion {3.4}
	set BoardName {zcu102}
	set BoardRevision {1.1}
	set BoardVendor {xilinx.com}
	set Compilation {IP Catalog}
	set CompilationFlow {IP}
	set CreateInterfaceDocument {off}
	set DSPDevice {xczu9eg}
	set DSPFamily {zynquplus}
	set DSPPackage {ffvb1156}
	set DSPSpeed {-2-e}
	set FPGAClockPeriod 3.33333
	set GenerateTestBench 0
	set HDLLanguage {verilog}
	set IPOOCCacheRootPath {C:/Users/fsydere/AppData/Local/Xilinx/Sysgen/SysgenVivado/win64.o/ip}
	set IP_Auto_Infer {1}
	set IP_Categories_Text {Vitis Model Composer}
	set IP_Common_Repos {0}
	set IP_Description {}
	set IP_Dir {}
	set IP_Library_Text {VMC}
	set IP_LifeCycle_Menu {1}
	set IP_Logo {sysgen_icon_100.png}
	set IP_Name {IFM}
	set IP_Revision {382984683}
	set IP_Socket_IP {0}
	set IP_Socket_IP_Proj_Path {}
	set IP_Vendor_Text {User Company}
	set IP_Version_Text {1.0}
	set ImplStrategyName {Vivado Implementation Defaults}
	set PostProjectCreationProc {dsp_package_for_vivado_ip_integrator}
	set Project {ifm}
	set ProjectFiles {
		{{conv_pkg.v}}
		{{synth_reg.v}}
		{{synth_reg_w_init.v}}
		{{convert_type.v}}
		{{xlclockdriver_rd.v}}
		{{vivado_ip.tcl}}
		{{ifm_entity_declarations.v}}
		{{ifm.v}}
		{{ifm_clock.xdc}}
		{{ifm.xdc}}
	}
	set SimPeriod 3.33333e-09
	set SimTime 0.0002
	set SimulationTime {200203.33333333 ns}
	set SynthStrategyName {Vivado Synthesis Defaults}
	set SynthesisTool {Vivado}
	set TargetDir {C:/Users/fsydere/Workspace/IFM/Model_Composer/netlist/ip/IFM/src}
	set TopLevelModule {ifm}
	set TopLevelSimulinkHandle 330
	set TopLevelPortInterface {}
	dict set TopLevelPortInterface realpart Name {realpart}
	dict set TopLevelPortInterface realpart Type Fix_16_15
	dict set TopLevelPortInterface realpart ArithmeticType xlSigned
	dict set TopLevelPortInterface realpart BinaryPoint 15
	dict set TopLevelPortInterface realpart Width 16
	dict set TopLevelPortInterface realpart DatFile {ifm_modelcomposer_ifm_realpart.dat}
	dict set TopLevelPortInterface realpart IconText {RealPart}
	dict set TopLevelPortInterface realpart Direction in
	dict set TopLevelPortInterface realpart Period 1
	dict set TopLevelPortInterface realpart Interface 0
	dict set TopLevelPortInterface realpart InterfaceName {}
	dict set TopLevelPortInterface realpart InterfaceString {DATA}
	dict set TopLevelPortInterface realpart ClockDomain {ifm}
	dict set TopLevelPortInterface realpart Locs {}
	dict set TopLevelPortInterface realpart IOStandard {}
	dict set TopLevelPortInterface imagpart Name {imagpart}
	dict set TopLevelPortInterface imagpart Type Fix_16_15
	dict set TopLevelPortInterface imagpart ArithmeticType xlSigned
	dict set TopLevelPortInterface imagpart BinaryPoint 15
	dict set TopLevelPortInterface imagpart Width 16
	dict set TopLevelPortInterface imagpart DatFile {ifm_modelcomposer_ifm_imagpart.dat}
	dict set TopLevelPortInterface imagpart IconText {ImagPart}
	dict set TopLevelPortInterface imagpart Direction in
	dict set TopLevelPortInterface imagpart Period 1
	dict set TopLevelPortInterface imagpart Interface 0
	dict set TopLevelPortInterface imagpart InterfaceName {}
	dict set TopLevelPortInterface imagpart InterfaceString {DATA}
	dict set TopLevelPortInterface imagpart ClockDomain {ifm}
	dict set TopLevelPortInterface imagpart Locs {}
	dict set TopLevelPortInterface imagpart IOStandard {}
	dict set TopLevelPortInterface datavalid Name {datavalid}
	dict set TopLevelPortInterface datavalid Type Bool
	dict set TopLevelPortInterface datavalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface datavalid BinaryPoint 0
	dict set TopLevelPortInterface datavalid Width 1
	dict set TopLevelPortInterface datavalid DatFile {ifm_modelcomposer_ifm_datavalid.dat}
	dict set TopLevelPortInterface datavalid IconText {DataValid}
	dict set TopLevelPortInterface datavalid Direction in
	dict set TopLevelPortInterface datavalid Period 1
	dict set TopLevelPortInterface datavalid Interface 0
	dict set TopLevelPortInterface datavalid InterfaceName {}
	dict set TopLevelPortInterface datavalid InterfaceString {DATA}
	dict set TopLevelPortInterface datavalid ClockDomain {ifm}
	dict set TopLevelPortInterface datavalid Locs {}
	dict set TopLevelPortInterface datavalid IOStandard {}
	dict set TopLevelPortInterface gateway_out Name {gateway_out}
	dict set TopLevelPortInterface gateway_out Type Fix_82_18
	dict set TopLevelPortInterface gateway_out ArithmeticType xlSigned
	dict set TopLevelPortInterface gateway_out BinaryPoint 18
	dict set TopLevelPortInterface gateway_out Width 82
	dict set TopLevelPortInterface gateway_out DatFile {ifm_modelcomposer_ifm_gateway_out.dat}
	dict set TopLevelPortInterface gateway_out IconText {Gateway Out}
	dict set TopLevelPortInterface gateway_out Direction out
	dict set TopLevelPortInterface gateway_out Period 1
	dict set TopLevelPortInterface gateway_out Interface 0
	dict set TopLevelPortInterface gateway_out InterfaceName {}
	dict set TopLevelPortInterface gateway_out InterfaceString {DATA}
	dict set TopLevelPortInterface gateway_out ClockDomain {ifm}
	dict set TopLevelPortInterface gateway_out Locs {}
	dict set TopLevelPortInterface gateway_out IOStandard {}
	dict set TopLevelPortInterface gateway_out1 Name {gateway_out1}
	dict set TopLevelPortInterface gateway_out1 Type Fix_82_18
	dict set TopLevelPortInterface gateway_out1 ArithmeticType xlSigned
	dict set TopLevelPortInterface gateway_out1 BinaryPoint 18
	dict set TopLevelPortInterface gateway_out1 Width 82
	dict set TopLevelPortInterface gateway_out1 DatFile {ifm_modelcomposer_ifm_gateway_out1.dat}
	dict set TopLevelPortInterface gateway_out1 IconText {Gateway Out1}
	dict set TopLevelPortInterface gateway_out1 Direction out
	dict set TopLevelPortInterface gateway_out1 Period 1
	dict set TopLevelPortInterface gateway_out1 Interface 0
	dict set TopLevelPortInterface gateway_out1 InterfaceName {}
	dict set TopLevelPortInterface gateway_out1 InterfaceString {DATA}
	dict set TopLevelPortInterface gateway_out1 ClockDomain {ifm}
	dict set TopLevelPortInterface gateway_out1 Locs {}
	dict set TopLevelPortInterface gateway_out1 IOStandard {}
	dict set TopLevelPortInterface clk Name {clk}
	dict set TopLevelPortInterface clk Type -
	dict set TopLevelPortInterface clk ArithmeticType xlUnsigned
	dict set TopLevelPortInterface clk BinaryPoint 0
	dict set TopLevelPortInterface clk Width 1
	dict set TopLevelPortInterface clk DatFile {}
	dict set TopLevelPortInterface clk Direction in
	dict set TopLevelPortInterface clk Period 1
	dict set TopLevelPortInterface clk Interface 6
	dict set TopLevelPortInterface clk InterfaceName {}
	dict set TopLevelPortInterface clk InterfaceString {CLOCK}
	dict set TopLevelPortInterface clk ClockDomain {ifm}
	dict set TopLevelPortInterface clk Locs {}
	dict set TopLevelPortInterface clk IOStandard {}
	dict set TopLevelPortInterface clk AssociatedInterfaces {}
	dict set TopLevelPortInterface clk AssociatedResets {}
	set MemoryMappedPort {}
}

source SgPaProject.tcl
::xilinx::dsp::planaheadworker::dsp_create_project