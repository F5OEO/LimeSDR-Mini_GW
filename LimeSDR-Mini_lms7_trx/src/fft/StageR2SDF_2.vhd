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


package StageR2SDF_2 is
    type self_t is record
        shr: ShiftRegister_2.self_t;
        control_delay: Typedefs.integer_list_t(0 to 2);
        twiddle: complex_t(1 downto -16);
        stage1_out: complex_t(1 downto -34);
        stage2_out: complex_t(1 downto -50);
        stage3_out: complex_t(1 downto -34);
    end record;
    type StageR2SDF_2_self_t_list_t is array (natural range <>) of StageR2SDF_2.self_t;

    type self_t_const is record
        FFT_SIZE: integer;
        FFT_HALF: integer;
        CONTROL_MASK: integer;
        shr: ShiftRegister_2.self_t_const;
        TWIDDLES: Typedefs.complex_t1downto_16_list_t(0 to 1023);
        DELAY: integer;
    end record;
    type StageR2SDF_2_self_t_const_list_t_const is array (natural range <>) of StageR2SDF_2.self_t_const;

    procedure butterfly(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; in_up: complex_t(1 downto -34); in_down: complex_t(1 downto -34); ret_0:out complex_t(1 downto -34); ret_1:out complex_t(1 downto -34));
    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; x: complex_t(1 downto -34); control: integer; ret_0:out complex_t(1 downto -34); ret_1:out integer);
    function StageR2SDF(shr: ShiftRegister_2.self_t; control_delay: Typedefs.integer_list_t(0 to 2); twiddle: complex_t(1 downto -16); stage1_out: complex_t(1 downto -34); stage2_out: complex_t(1 downto -50); stage3_out: complex_t(1 downto -34)) return self_t;
end package;

package body StageR2SDF_2 is
    procedure butterfly(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; in_up: complex_t(1 downto -34); in_down: complex_t(1 downto -34); ret_0:out complex_t(1 downto -34); ret_1:out complex_t(1 downto -34)) is

        variable down: complex_t(1 downto -34);
        variable up: complex_t(1 downto -34);
    begin
        up := resize(resize(in_up + in_down, 0, -17, overflow_style=>fixed_wrap, round_style=>fixed_truncate), 0, -17, fixed_wrap, fixed_truncate);
        down := resize(resize(in_up - in_down, 0, -17, overflow_style=>fixed_wrap, round_style=>fixed_truncate), 0, -17, fixed_wrap, fixed_truncate);
        ret_0 := up;
        ret_1 := down;
        return;
    end procedure;

    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; x: complex_t(1 downto -34); control: integer; ret_0:out complex_t(1 downto -34); ret_1:out integer) is

        variable down: complex_t(1 downto -34);
        variable up: complex_t(1 downto -34);
        variable pyha_ret_0: complex_t(1 downto -34);
        variable pyha_ret_1: complex_t(1 downto -34);
        variable pyha_ret_2: complex_t(1 downto -34);
        variable pyha_ret_3: complex_t(1 downto -34);
    begin
        self_next.control_delay := control & self.control_delay(0 to self.control_delay'high-1);

        -- Stage 1: handle the loopback memory, to calculate butterfly additions.
        -- Also fetch the twiddle factor.
        self_next.twiddle := resize(self_const.TWIDDLES(control and self_const.CONTROL_MASK), 0, -8, fixed_saturate, fixed_round);
        if not (control and self_const.FFT_HALF) then
            ShiftRegister_2.push_next(self.shr, self_next.shr, self_const.shr, x);
            ShiftRegister_2.peek(self.shr, self_next.shr, self_const.shr, pyha_ret_0);
            self_next.stage1_out := resize(pyha_ret_0, 0, -17, fixed_wrap, fixed_truncate);
        else
            ShiftRegister_2.peek(self.shr, self_next.shr, self_const.shr, pyha_ret_1);
            butterfly(self, self_next, self_const, pyha_ret_1, x, pyha_ret_2, pyha_ret_3);
            up := resize(pyha_ret_2, 0, -17, fixed_wrap, fixed_truncate);
            down := resize(pyha_ret_3, 0, -17, fixed_wrap, fixed_truncate);
            ShiftRegister_2.push_next(self.shr, self_next.shr, self_const.shr, down);
            self_next.stage1_out := resize(up, 0, -17, fixed_wrap, fixed_truncate);

            -- Stage 2: complex multiply, only the botton line
        end if;
        if not (self.control_delay(0) and self_const.FFT_HALF) and self_const.FFT_HALF /= 1 then
            self_next.stage2_out := resize(self.stage1_out * self.twiddle, 0, -25, fixed_wrap, fixed_truncate);
        else
            self_next.stage2_out := resize(self.stage1_out, 0, -25, fixed_wrap, fixed_truncate);

            -- Stage 3: gain control and rounding
        end if;
        if self_const.FFT_HALF > 4 then
            self_next.stage3_out := resize(scalb(self.stage2_out, -1), 0, -17, fixed_wrap, fixed_round);
        else
            self_next.stage3_out := resize(self.stage2_out, 0, -17, fixed_wrap, fixed_round);

        end if;
        ret_0 := self.stage3_out;
        ret_1 := self.control_delay(self.control_delay'length-1);
        return;
    end procedure;

    function StageR2SDF(shr: ShiftRegister_2.self_t; control_delay: Typedefs.integer_list_t(0 to 2); twiddle: complex_t(1 downto -16); stage1_out: complex_t(1 downto -34); stage2_out: complex_t(1 downto -50); stage3_out: complex_t(1 downto -34)) return self_t is
        -- limited constructor
        variable self: self_t;
    begin
        self.shr := shr;
        self.control_delay := control_delay;
        self.twiddle := twiddle;
        self.stage1_out := stage1_out;
        self.stage2_out := stage2_out;
        self.stage3_out := stage3_out;
        return self;
    end function;
end package body;
