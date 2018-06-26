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


package ShiftRegister_11 is
    type self_t is record
        data: Typedefs.complex_t1downto_34_list_t(0 to 1);
        to_push: complex_t(1 downto -34);
    end record;
    type ShiftRegister_11_self_t_list_t is array (natural range <>) of ShiftRegister_11.self_t;

    type self_t_const is record
        DUMMY: integer;
    end record;
    type ShiftRegister_11_self_t_const_list_t_const is array (natural range <>) of ShiftRegister_11.self_t_const;

    procedure peek(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; ret_0:out complex_t(1 downto -34));
    procedure push_next(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; item: complex_t(1 downto -34));
    function ShiftRegister(data: Typedefs.complex_t1downto_34_list_t(0 to 1); to_push: complex_t(1 downto -34)) return self_t;
end package;

package body ShiftRegister_11 is
    procedure peek(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; ret_0:out complex_t(1 downto -34)) is


    begin
        ret_0 := self.data(0);
        return;
    end procedure;

    procedure push_next(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; item: complex_t(1 downto -34)) is


    begin
        -- CONVERSION PREPROCESSOR replace next line with:
        -- self.data = self.data[1:] + [item]
        self_next.data := self.data(1 to self.data'high) & item;
    end procedure;

    function ShiftRegister(data: Typedefs.complex_t1downto_34_list_t(0 to 1); to_push: complex_t(1 downto -34)) return self_t is
        -- limited constructor
        variable self: self_t;
    begin
        self.data := data;
        self.to_push := to_push;
        return self;
    end function;
end package body;
