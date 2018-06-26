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

-- Moving average algorithm.
-- This can be used for signal smoothing (low pass filter) or matched filter/detector for rectangular signals.
-- :param window_len: Size of the moving average window, must be power of 2
package MovingAverage_0 is
    type self_t is record
        mem: Typedefs.complex_t1downto_34_list_t(0 to 255);
        sum: complex_t(17 downto -34);
    end record;
    type MovingAverage_0_self_t_list_t is array (natural range <>) of MovingAverage_0.self_t;

    type self_t_const is record
        WINDOW_LEN: integer;
        WINDOW_POW: integer;
        DELAY: integer;
    end record;
    type MovingAverage_0_self_t_const_list_t_const is array (natural range <>) of MovingAverage_0.self_t_const;

    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; x: complex_t(1 downto -34); ret_0:out complex_t(1 downto -34));
    function MovingAverage(mem: Typedefs.complex_t1downto_34_list_t(0 to 255); sum: complex_t(17 downto -34)) return self_t;
end package;

package body MovingAverage_0 is
    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; x: complex_t(1 downto -34); ret_0:out complex_t(1 downto -34)) is
    -- This works by keeping a history of 'window_len' elements and the sum of them.
    -- Every clock last element will be subtracted and new added to the sum.
    -- More good infos: https://www.dsprelated.com/showarticle/58.php
    -- :param x: input to average
    -- :return: averaged output

    begin
        -- add new element to shift register
        self_next.mem := x & self.mem(0 to self.mem'high-1);

        -- calculate new sum
        self_next.sum := resize(self.sum + x - self.mem(self.mem'length-1), 8, -17, fixed_wrap, fixed_truncate);
        ret_0 := resize(self.sum sra self_const.WINDOW_POW, 0, -17, overflow_style=>fixed_wrap, round_style=>fixed_truncate);
        return;
    end procedure;

    function MovingAverage(mem: Typedefs.complex_t1downto_34_list_t(0 to 255); sum: complex_t(17 downto -34)) return self_t is
        -- limited constructor
        variable self: self_t;
    begin
        self.mem := mem;
        self.sum := sum;
        return self;
    end function;
end package body;
