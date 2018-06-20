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
    use work.Packager_0.all;
    use work.Windower_1.all;
    use work.ShiftRegister_0.all;
    use work.StageR2SDF_0.all;
    use work.ShiftRegister_1.all;
    use work.StageR2SDF_1.all;
    use work.ShiftRegister_2.all;
    use work.StageR2SDF_2.all;
    use work.ShiftRegister_3.all;
    use work.StageR2SDF_3.all;
    use work.ShiftRegister_4.all;


package StageR2SDF_4 is
    type self_t is record
        shr: ShiftRegister_4.self_t;
        \out\: complex_t(1 downto -34);
    end record;
    type StageR2SDF_4_self_t_list_t is array (natural range <>) of StageR2SDF_4.self_t;

    type self_t_const is record
        FFT_SIZE: integer;
        FFT_HALF: integer;
        CONTROL_MASK: integer;
        shr: ShiftRegister_4.self_t_const;
        TWIDDLES: Typedefs.complex_t1downto_16_list_t(0 to 255);
    end record;
    type StageR2SDF_4_self_t_const_list_t_const is array (natural range <>) of StageR2SDF_4.self_t_const;

    procedure butterfly(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; in_up: complex_t(1 downto -34); in_down: complex_t(1 downto -34); twiddle: complex_t(1 downto -16); ret_0:out complex_t(1 downto -34); ret_1:out complex_t(1 downto -34));
    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; x: complex_t(1 downto -34); control: integer; ret_0:out complex_t(1 downto -34));
    function StageR2SDF(shr: ShiftRegister_4.self_t; \out\: complex_t(1 downto -34)) return self_t;
end package;

package body StageR2SDF_4 is
    procedure butterfly(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; in_up: complex_t(1 downto -34); in_down: complex_t(1 downto -34); twiddle: complex_t(1 downto -16); ret_0:out complex_t(1 downto -34); ret_1:out complex_t(1 downto -34)) is

        variable down: complex_t(1 downto -34);
        variable down_part: complex_t(1 downto -34);
        variable up: complex_t(1 downto -34);
    begin
        if self_const.FFT_HALF > 4 then
            up := resize(resize(scalb(in_up + in_down, -1), 0, -17, round_style=>fixed_round, overflow_style=>fixed_wrap), 0, -17, fixed_wrap, fixed_round);
            down_part := resize(resize(in_up - in_down, 0, -17, overflow_style=>fixed_wrap, round_style=>fixed_truncate), 0, -17, fixed_wrap, fixed_truncate);
            down := resize(resize(scalb(down_part * twiddle, -1), 0, -17, round_style=>fixed_round, overflow_style=>fixed_wrap), 0, -17, fixed_wrap, fixed_round);
        else
            up := resize(resize(in_up + in_down, 0, -17, overflow_style=>fixed_wrap, round_style=>fixed_truncate), 0, -17, fixed_wrap, fixed_round);
            down_part := resize(resize(in_up - in_down, 0, -17, overflow_style=>fixed_wrap, round_style=>fixed_truncate), 0, -17, fixed_wrap, fixed_truncate);
            down := resize(resize(down_part * twiddle, 0, -17, round_style=>fixed_round, overflow_style=>fixed_wrap), 0, -17, fixed_wrap, fixed_round);
        end if;
        ret_0 := up;
        ret_1 := down;
        return;

        -- TODO: Bug..negative integer index?
        -- up = in_up + in_down
        -- down_part = resize(in_up - in_down, 0, -17)
        -- down = down_part * twiddle
        --
        -- if self.FFT_HALF > 4:
        --     up = scalb(up, -1)
        --     down = scalb(down, -1)
        --
        -- up = resize(up, 0, -17, round_style='round')
        -- down = resize(down, 0, -17, round_style='round')
        -- return up, down
    end procedure;

    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; x: complex_t(1 downto -34); control: integer; ret_0:out complex_t(1 downto -34)) is

        variable down: complex_t(1 downto -34);
        variable up: complex_t(1 downto -34);
        variable twid: complex_t(1 downto -16);
        variable pyha_ret_0: complex_t(1 downto -34);
        variable pyha_ret_1: complex_t(1 downto -34);
        variable pyha_ret_2: complex_t(1 downto -34);
        variable pyha_ret_3: complex_t(1 downto -34);
    begin

        -- logger.info(f'{self.FFT_SIZE} - {control}')
        if not (control and self_const.FFT_HALF) then
            ShiftRegister_4.push_next(self.shr, self_next.shr, self_const.shr, x);
            ShiftRegister_4.peek(self.shr, self_next.shr, self_const.shr, pyha_ret_0);
            self_next.\out\ := resize(pyha_ret_0, 0, -17, fixed_wrap, fixed_truncate);
        else
            twid := resize(self_const.TWIDDLES(control and self_const.CONTROL_MASK), 0, -8, fixed_saturate, fixed_round);
            ShiftRegister_4.peek(self.shr, self_next.shr, self_const.shr, pyha_ret_1);
            butterfly(self, self_next, self_const, pyha_ret_1, x, twid, pyha_ret_2, pyha_ret_3);
            up := resize(pyha_ret_2, 0, -17, fixed_wrap, fixed_round);
            down := resize(pyha_ret_3, 0, -17, fixed_wrap, fixed_round);
            ShiftRegister_4.push_next(self.shr, self_next.shr, self_const.shr, down);
            self_next.\out\ := resize(up, 0, -17, fixed_wrap, fixed_truncate);

        end if;
        ret_0 := self.\out\;
        return;
    end procedure;

    function StageR2SDF(shr: ShiftRegister_4.self_t; \out\: complex_t(1 downto -34)) return self_t is
        -- limited constructor
        variable self: self_t;
    begin
        self.shr := shr;
        self.\out\ := \out\;
        return self;
    end function;
end package body;
