-- generated by pyha 0.0.7
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.fixed_float_types.all;
    use ieee.fixed_pkg.all;
    use ieee.math_real.all;

library work;
    use work.complex_pkg.all;
    use work.PyhaUtil.all;
    use work.Typedefs.all;
    use work.all;
    use work.DataWithIndex_3.all;
    use work.DataWithIndex_0.all;
    use work.MovingAverage_0.all;
    use work.DCRemoval_0.all;
    use work.Packager_0.all;
    use work.Windower_1.all;
    use work.ShiftRegister_12.all;
    use work.StageR2SDF_12.all;
    use work.ShiftRegister_0.all;
    use work.StageR2SDF_0.all;
    use work.ShiftRegister_1.all;
    use work.StageR2SDF_1.all;
    use work.ShiftRegister_2.all;
    use work.StageR2SDF_2.all;
    use work.ShiftRegister_3.all;
    use work.StageR2SDF_3.all;
    use work.ShiftRegister_4.all;
    use work.StageR2SDF_4.all;
    use work.ShiftRegister_5.all;
    use work.StageR2SDF_5.all;
    use work.ShiftRegister_6.all;
    use work.StageR2SDF_6.all;
    use work.ShiftRegister_7.all;
    use work.StageR2SDF_7.all;
    use work.ShiftRegister_8.all;
    use work.StageR2SDF_8.all;
    use work.ShiftRegister_9.all;
    use work.StageR2SDF_9.all;
    use work.ShiftRegister_10.all;
    use work.StageR2SDF_10.all;
    use work.ShiftRegister_11.all;
    use work.StageR2SDF_11.all;
    use work.R2SDF_1.all;


package ConjMult_0 is
    type self_t is record
        \out\: DataWithIndex_3.self_t;
    end record;
    type ConjMult_0_self_t_list_t is array (natural range <>) of ConjMult_0.self_t;

    type self_t_const is record
        \out\: DataWithIndex_3.self_t_const;
        DELAY: integer;
    end record;
    type ConjMult_0_self_t_const_list_t_const is array (natural range <>) of ConjMult_0.self_t_const;

    procedure conjugate(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; x: complex_t(1 downto -34); ret_0:out complex_t(1 downto -34));
    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; inp: DataWithIndex_0.self_t; ret_0:out DataWithIndex_3.self_t);
    function ConjMult(\out\: DataWithIndex_3.self_t) return self_t;
end package;

package body ConjMult_0 is
    procedure conjugate(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; x: complex_t(1 downto -34); ret_0:out complex_t(1 downto -34)) is

        variable imag: sfixed(0 downto -17);
    begin
        imag := resize(resize(-get_imag(x), left_index(get_imag(x)), right_index(get_imag(x)), overflow_style=>fixed_wrap, round_style=>fixed_truncate), 0, -17, fixed_wrap, fixed_truncate);
        ret_0 := Complex(get_real(x), imag);
        return;
    end procedure;

    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; inp: DataWithIndex_0.self_t; ret_0:out DataWithIndex_3.self_t) is

        variable conj: complex_t(1 downto -34);
        variable pyha_ret_0: complex_t(1 downto -34);
    begin
        conjugate(self, self_next, self_const, inp.data, pyha_ret_0);
        conj := resize(pyha_ret_0, 0, -17, fixed_wrap, fixed_truncate);
        self_next.\out\.data := resize((get_real(conj) * get_real(inp.data)) - (get_imag(conj) * get_imag(inp.data)), 0, -35, fixed_wrap, fixed_truncate);
        self_next.\out\.index := inp.index;
        -- self.out = (self.conjugate(complex_in) * complex_in).real
        ret_0 := self.\out\;
        return;
    end procedure;

    function ConjMult(\out\: DataWithIndex_3.self_t) return self_t is
        -- limited constructor
        variable self: self_t;
    begin
        self.\out\ := \out\;
        return self;
    end function;
end package body;
