library ieee;
use ieee.std_logic_1164.all;

entity top_macclassic is
    port (
        CLK50   : in  std_logic;  -- 50-MHz oscillator on DE0-CV
        HSYNC_O : out std_logic;
        VSYNC_O : out std_logic;
        VIDEO_O : out std_logic
    );
end entity;

architecture rtl of top_macclassic is
    -- PLL generates the 15.667 MHz Macintosh pixel clock from 50 MHz
    signal pixclk : std_logic;
begin
    pll_inst : entity work.pll15m67
        port map (
            inclk0 => CLK50,
            c0     => pixclk
        );

    display_inst : entity work.display
        port map (
            HSYNC        => HSYNC_O,
            VSYNC        => VSYNC_O,
            VID          => VIDEO_O,
            display_clk  => pixclk
        );
end architecture;
