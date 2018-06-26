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


package Windower_1 is
    type self_t is record
        window_pure: Typedefs.sfixed0downto_17_list_t(0 to 8191);
        \out\: DataWithIndex_0.self_t;
    end record;
    type Windower_1_self_t_list_t is array (natural range <>) of Windower_1.self_t;

    type self_t_const is record
        M: integer;
        WINDOW: Typedefs.sfixed0downto_7_list_t(0 to 8191);
        \out\: DataWithIndex_0.self_t_const;
        DELAY: integer;
    end record;
    type Windower_1_self_t_const_list_t_const is array (natural range <>) of Windower_1.self_t_const;

    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; inp: DataWithIndex_0.self_t; ret_0:out DataWithIndex_0.self_t);
    function Windower(window_pure: Typedefs.sfixed0downto_17_list_t(0 to 8191); \out\: DataWithIndex_0.self_t) return self_t;
end package;

package body Windower_1 is
    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; inp: DataWithIndex_0.self_t; ret_0:out DataWithIndex_0.self_t) is


    begin
        -- calculate output
        self_next.\out\ := inp;
        self_next.\out\.data := resize(inp.data * self_const.WINDOW(inp.index), 0, -17, fixed_wrap, fixed_truncate);
        ret_0 := self.\out\;
        return;
    end procedure;

    function Windower(window_pure: Typedefs.sfixed0downto_17_list_t(0 to 8191); \out\: DataWithIndex_0.self_t) return self_t is
        -- limited constructor
        variable self: self_t;
    begin
        self.window_pure := window_pure;
        self.\out\ := \out\;
        return self;
    end function;
end package body;
