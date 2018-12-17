unset multiplot
reset

set term aqua dashed font "Times-Roman,30" enhanced

PAUSE = -1


set bmargin 2
set lmargin 6
# set lmargin 8
set xtics offset 0,0.3
set ytics offset 0.5,0
set xl "time [yr]" offset 0,1

# set log

# set format "10^{%L}"
unset key
set bar 0.3

###################################


set format "10^{%L}"

set format x "%g"
# set xr [1:20]

set log


LW = 2



set xl "<e^2>^{1/2}" offset 0,1
set yl "m^{*} [g]" offset 2,0


set xr [0.01:0.2]
set yr [1E16:1E26]
set xtics add (0.02, 0.05, 0.2)

# set key left top box width -1 spacing 1.0 font "Times-Roman,20"
p "ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u 1:($4*2E33) w l lw LW

pause -1



set xl "<e^2>^{1/2}" offset 0,1
set yl "m^{*} [g]" offset 2,0


set xr [0.01:0.2]
set yr [1E16:1E26]
set xtics add (0.02, 0.05, 0.2)

# set key left top box width -1 spacing 1.0 font "Times-Roman,20"
p "ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u 1:($4*2E33) w l lw LW t "M_{Earth}",\
"ecc_Mp3E-7_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u 1:($4*2E33) w l lw LW t "0.1M_{Earth}"

pause -1



set xl "<e^2>^{1/2}" offset 0,1
set yl "R^{*} [km]" offset 2,0

set auto
set xr [0.01:0.2]
set xtics add (0.02, 0.05, 0.2)


# set key left top box width -1 spacing 1.0 font "Times-Roman,20"
p "ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u 1:($5/1E5) w l lw LW

pause -1



set xl "<e^2>^{1/2}" offset 0,1
set yl "R^{*} [km]" offset 2,0

set auto
set xr [0.01:0.2]
set xtics add (0.02, 0.05, 0.2)


# set key left top box width -1 spacing 1.0 font "Times-Roman,20"
p "ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u 1:($5/1E5) w l lw LW t "M_{Earth}",\
"ecc_Mp3E-7_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u 1:($5/1E5) w l lw LW t "0.1M_{Earth}"

pause -1



set xl "<e^2>^{1/2}" offset 0,1
set yl "{/Symbol t}_{df} [yr]" offset 2,0

set auto
set xr [0.01:0.2]
set yr [:1E7]
set xtics add (0.02, 0.05, 0.2)

# set key left top box width -8.5 spacing 1.4 font "Times-Roman,16"
p "ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u 1:2 w l lw LW lt 1 t "{/Symbol S} = 1/2{/Symbol p} (2M_{Earth}/3M_{Sun})^{-1/3} [M_{Earth}/AU^2]",\
"ecc_Mp3E-6_Mtot3E-6_Mmax5E-15_ignoreVS.dat" u 1:2 w l lw LW lt 2 t "{/Symbol S} = 0.1/2{/Symbol p} (2M_{Earth}/3M_{Sun})^{-1/3} [M_{Earth}/AU^2]",\
"ecc_Mp3E-6_Mtot3E-7_Mmax5E-15_ignoreVS.dat" u 1:2 w l lw LW lt 3 t "{/Symbol S} = 0.01/2{/Symbol p} (2M_{Earth}/3M_{Sun})^{-1/3} [M_{Earth}/AU^2]"

pause -1



set xl "<e^2>^{1/2}" offset 0,1
set yl "{/Symbol t}_{df} [yr]" offset 2,0

set auto
set xr [0.01:0.2]
set yr [:1E7]
set xtics add (0.02, 0.05, 0.2)

# set key left top box width -11.5 spacing 1.4 font "Times-Roman,16"
p "ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u 1:2 w l lw LW lt 1 t "M_{Earth}, {/Symbol S} = 1/2{/Symbol p} (2M_{Earth}/3M_{Sun})^{-1/3} [M_{Earth}/AU^2]",\
"ecc_Mp3E-6_Mtot3E-6_Mmax5E-15_ignoreVS.dat" u 1:2 w l lw LW lt 2 t "M_{Earth}, {/Symbol S} = 0.1/2{/Symbol p} (2M_{Earth}/3M_{Sun})^{-1/3} [M_{Earth}/AU^2]",\
"ecc_Mp3E-6_Mtot3E-7_Mmax5E-15_ignoreVS.dat" u 1:2 w l lw LW lt 3 t "M_{Earth}, {/Symbol S} = 0.01/2{/Symbol p} (2M_{Earth}/3M_{Sun})^{-1/3} [M_{Earth}/AU^2]",\
"ecc_Mp3E-7_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u 1:2 w l lw LW lt 1 dt 2 t "0.1M_{Earth}, {/Symbol S} = 1/2{/Symbol p} (2M_{Earth}/3M_{Sun})^{-1/3} [M_{Earth}/AU^2]",\
"ecc_Mp3E-7_Mtot3E-6_Mmax5E-15_ignoreVS.dat" u 1:2 w l lw LW lt 2 dt 2 t "0.1M_{Earth}, {/Symbol S} = 0.1/2{/Symbol p} (2M_{Earth}/3M_{Sun})^{-1/3} [M_{Earth}/AU^2]",\
"ecc_Mp3E-7_Mtot3E-7_Mmax5E-15_ignoreVS.dat" u 1:2 w l lw LW lt 3 dt 2 t "0.1M_{Earth}, {/Symbol S} = 0.01/2{/Symbol p} (2M_{Earth}/3M_{Sun})^{-1/3} [M_{Earth}/AU^2]"

pause -1



set xl "<e^2>^{1/2}" offset 0,1
set yl "{/Symbol t}_{dep} [yr]" offset 2,0

set auto
set xr [0.01:0.2]
# set yr [1E-2:1E4]
set xtics add (0.02, 0.05, 0.2)

# set key right top box width -1 spacing 1.2 font "Times-Roman,16"
p "ecc_Mp3E-6_Mtot3E-5_Mmax5E-12_ignoreVS.dat" u 1:3 w l lw LW lt 1 t "m_{max} = 10^{22}g",\
"ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u 1:3 w l lw LW lt 2 t "m_{max} = 10^{19}g",\
"ecc_Mp3E-6_Mtot3E-5_Mmax5E-18_ignoreVS.dat" u 1:3 w l lw LW lt 3 t "m_{max} = 10^{16}g"

pause -1



set xl "<e^2>^{1/2}" offset 0,1
set yl "{/Symbol t}_{dep}/{/Symbol t}_{df}" offset 2,0

set auto
set xr [0.01:0.2]
set yr [1E-3:1E3]
set xtics add (0.02, 0.05, 0.2)

# set key right top box width -1 spacing 1.2 font "Times-Roman,16"
p "ecc_Mp3E-6_Mtot3E-5_Mmax5E-12_ignoreVS.dat" u 1:($3/$2) w l lw LW lt 1 t "m_{max} = 10^{22}g",\
"ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u 1:($3/$2) w l lw LW lt 2 t "m_{max} = 10^{19}g",\
"ecc_Mp3E-6_Mtot3E-5_Mmax5E-18_ignoreVS.dat" u 1:($3/$2) w l lw LW lt 3 t "m_{max} = 10^{16}g"

pause -1



set xl "<e^2>^{1/2}" offset 0,1
set yl "{/Symbol t}_{dep}/{/Symbol t}_{df}" offset 2,0

set auto
set xr [0.01:0.2]
set yr [1E-3:1E3]
set xtics add (0.02, 0.05, 0.2)

# set key right top box width -4 spacing 1.2 font "Times-Roman,16"
p "ecc_Mp3E-6_Mtot3E-5_Mmax5E-12_ignoreVS.dat" u 1:($3/$2) w l lw LW lt 1 t "M_{Earth}, m_{max} = 10^{22}g",\
"ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u 1:($3/$2) w l lw LW lt 2 t "M_{Earth}, m_{max} = 10^{19}g",\
"ecc_Mp3E-6_Mtot3E-5_Mmax5E-18_ignoreVS.dat" u 1:($3/$2) w l lw LW lt 3 t "M_{Earth}, m_{max} = 10^{16}g",\
"ecc_Mp3E-7_Mtot3E-5_Mmax5E-12_ignoreVS.dat" u 1:($3/$2) w l lw LW lt 1 dt 2 t "0.1M_{Earth}, m_{max} = 10^{22}g",\
"ecc_Mp3E-7_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u 1:($3/$2) w l lw LW lt 2 dt 2 t "0.1M_{Earth}, m_{max} = 10^{19}g",\
"ecc_Mp3E-7_Mtot3E-5_Mmax5E-18_ignoreVS.dat" u 1:($3/$2) w l lw LW lt 3 dt 2 t "0.1M_{Earth}, m_{max} = 10^{16}g"

pause



###############

RHILL_1 = (2.0 * 3.0E-6 / 3.0)**(1.0/3.0)
RHILL_2 = (2.0 * 3.0E-7 / 3.0)**(1.0/3.0)


set xl "<e^2>^{1/2}/(2m_p/3M_{Sun})^{1/3}" offset 0,1
set yl "m^{*} [g]" offset 2,0

set xr [1:20]
set yr [1E16:1E26]
set xtics add (2, 5, 20)

set key left top box width -1.5 spacing 1.0 font "Times-Roman,20"
p "ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u ($1/RHILL_1):($4*2E33) w l lw LW t "m_p = M_{Earth}",\
"ecc_Mp3E-7_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u ($1/RHILL_2):($4*2E33) w l lw LW t "m_p = 0.1M_{Earth}"

pause -1



set xl "<e^2>^{1/2}/(2m_p/3M_{Sun})^{1/3}" offset 0,1
set yl "R^{*} [km]" offset 2,0

set auto
set xr [1:20]
# set yr [1E16:1E26]

set key left top box width -1.5 spacing 1.0 font "Times-Roman,20"
p "ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u ($1/RHILL_1):($5/1E5) w l lw LW t "m_p = M_{Earth}",\
"ecc_Mp3E-7_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u ($1/RHILL_2):($5/1E5) w l lw LW t "m_p = 0.1M_{Earth}"

pause


#############
# set term pngcairo size 800,600 font "Times-Roman,20" enhanced

# set out "filledcurves.png"

set xl "<e^2>^{1/2}/(2m_p/3M_{Sun})^{1/3}" offset 0,1
set yl "R^{*} [km]" offset 2,0

# unset log x

set samples 100
set auto
set xr [1:20]
# set yr [100:1000]

set key left top box width -1.5 spacing 1.0 font "Times-Roman,20"
# p "ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u ($1/RHILL_1):($5/1E5) w filledcurves x1=1 fs transparent solid 0.5 t "m_p = M_{Earth}",\
# "ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u ($1/RHILL_2):($5/1E5) w filledcurves y1=1 fs transparent solid 0.5 t "m_p = 0.1M_{Earth}"

# set output

# set term aqua dashed font "Times-Roman,30" enhanced

# pause -1
##############


set xl "<e^2>^{1/2}/(2M_{Earth}/3M_{Sun})^{1/3}" offset 0,1
set yl "{/Symbol t}_{df} [yr]" offset 2,0

set auto
set xr [1:20]
# set yr [1E16:1E26]

set key left top box width -8 spacing 1.4 font "Times-Roman,16"
p "ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u ($1/RHILL_1):2 w l lw LW t "{/Symbol S} = 1/2{/Symbol p} (2M_{Earth}/3M_{Sun})^{-1/3} [M_{Earth}/AU^2]",\
"ecc_Mp3E-6_Mtot3E-6_Mmax5E-15_ignoreVS.dat" u ($1/RHILL_1):2 w l lw LW t "{/Symbol S} = 0.1/2{/Symbol p} (2M_{Earth}/3M_{Sun})^{-1/3} [M_{Earth}/AU^2]",\
"ecc_Mp3E-6_Mtot3E-7_Mmax5E-15_ignoreVS.dat" u ($1/RHILL_1):2 w l lw LW t "{/Symbol S} = 0.01/2{/Symbol p} (2M_{Earth}/3M_{Sun})^{-1/3} [M_{Earth}/AU^2]",\
"ecc_Mp3E-7_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u ($1/RHILL_2):2 w l lw LW t "{/Symbol S} = 1/2{/Symbol p} (2M_{Earth}/3M_{Sun})^{-1/3} [M_{Earth}/AU^2], 2",\

pause -1



set xl "<e^2>^{1/2}/(2M_{Earth}/3M_{Sun})^{1/3}" offset 0,1
set yl "{/Symbol t}_{dep} [yr]" offset 2,0

set auto
set xr [1:20]
# set yr [1E-2:1E4]

set key right top box width -1 spacing 1.2 font "Times-Roman,16"
p "ecc_Mp3E-6_Mtot3E-5_Mmax5E-12_ignoreVS.dat" u ($1/RHILL_1):3 w l lw LW t "m_{max} = 10^{22}g",\
"ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u ($1/RHILL_1):3 w l lw LW t "m_{max} = 10^{19}g",\
"ecc_Mp3E-6_Mtot3E-5_Mmax5E-18_ignoreVS.dat" u ($1/RHILL_1):3 w l lw LW t "m_{max} = 10^{16}g",\
"ecc_Mp3E-7_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u ($1/RHILL_2):3 w l lw LW t "m_{max} = 10^{19}g, 2",\

pause -1



set xl "<e^2>^{1/2}/(2M_{Earth}/3M_{Sun})^{1/3}" offset 0,1
set yl "{/Symbol t}_{dep}/{/Symbol t}_{df}" offset 2,0

set auto
set xr [1:20]
set yr [1E-3:1E3]

set key right top box width -1 spacing 1.2 font "Times-Roman,16"
p "ecc_Mp3E-6_Mtot3E-5_Mmax5E-12_ignoreVS.dat" u ($1/RHILL_1):($3/$2) w l lw LW t "m_{max} = 10^{22}g",\
"ecc_Mp3E-6_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u ($1/RHILL_1):($3/$2) w l lw LW t "m_{max} = 10^{19}g",\
"ecc_Mp3E-6_Mtot3E-5_Mmax5E-18_ignoreVS.dat" u ($1/RHILL_1):($3/$2) w l lw LW t "m_{max} = 10^{16}g",\
"ecc_Mp3E-7_Mtot3E-5_Mmax5E-15_ignoreVS.dat" u ($1/RHILL_2):($3/$2) w l lw LW t "m_{max} = 10^{19}g, 2",\



pause


###################################

SMALL = "S8E2_t1E9_dtlog_ecc1E-4_all/Planetesimal.dat"
LARGE = "S8E2_t1E9_dtlog_ecc1E-4_all/Planet.dat"

set yl "ecc, inc [rad]" offset 2,0
# set yl "ecc, inc [rad]" offset 3,0
set xr [0.1:1E3]
# set yr [0:0.006]
set yr [1E-5:1E-2]

set key left top box width -1 spacing 1.1 font "Times-Roman,20"
p SMALL u 1:2 w l lw 2 t "<e_S^2>^{1/2}",\
LARGE u 1:2 w l lw 2 t "<e_L^2>^{1/2}",\
SMALL u 1:3 w l lw 2 t "<i_S^2>^{1/2}",\
LARGE u 1:3 w l lw 2 t "<i_L^2>^{1/2}"

pause -1


SMALL = "S1E3_t1E9_dtlog_ecc1E-4_all/Planetesimal.dat"

set yl "ecc, inc [rad]" offset 2,0
# set yl "ecc, inc [rad]" offset 3,0
# set xr [0:1E3]
# set yr [0:0.004]
# set ytics 0.001

set key left top box width 0 spacing 1.1 font "Times-Roman,20"
p SMALL u 1:2 w l lw 2 t "<e^2>^{1/2}",\
SMALL u 1:3 w l lw 2 t "<i^2>^{1/2}"


pause

#######################################

# Planet1 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



# Planet1 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planet.dat"
# Planet2 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planet.dat"
# Planet3 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planet.dat"
# Planet4 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planet.dat"
# Planet5 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planet.dat"
# Planet6 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planet.dat"
# Planet7 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planet.dat"

# Planetesimal1 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_nofrag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_nofrag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_nofrag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_nofrag_dt/Planetesimal.dat"



##################################################################################



# Planet1 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-6_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-7_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-9_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-10_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-7_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-8_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-9_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-10_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-11_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-8_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-10_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-11_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach3E-12_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach5E-15_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



# Planet1 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
# Planet2 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
# Planet3 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
# Planet4 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
# Planet5 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
# Planet6 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
# Planet7 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

# Planetesimal1 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
# Planetesimal2 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
# Planetesimal3 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
# Planetesimal4 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
# Planetesimal5 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
# Planetesimal6 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
# Planetesimal7 = "Meach5E-15_Mtot3E-6_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"



 Planet1 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planet.dat"
 Planet2 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planet.dat"
 Planet3 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planet.dat"
 Planet4 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planet.dat"
 Planet5 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planet.dat"
 Planet6 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planet.dat"
 Planet7 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planet.dat"

 Planetesimal1 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_frag_dt/Planetesimal.dat"
 Planetesimal2 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc5E-2_frag_dt/Planetesimal.dat"
 Planetesimal3 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc3E-2_frag_dt/Planetesimal.dat"
 Planetesimal4 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-2_frag_dt/Planetesimal.dat"
 Planetesimal5 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-3_frag_dt/Planetesimal.dat"
 Planetesimal6 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-4_frag_dt/Planetesimal.dat"
 Planetesimal7 = "Meach5E-15_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-5_frag_dt/Planetesimal.dat"




set yl "ecc" offset 2,0
set xr [1:1E9]
# set yr [0.001:0.1]

# p Planet1 u 1:2 w lp lw 1 lt 1, Planetesimal1 u 1:2 w lp lw 1 dt 2 lt 1
#pause

p Planet1 u 1:2 w l lw 2 lt 1,\
Planet2 u 1:2 w l lw 2 lt 2,\
Planet3 u 1:2 w l lw 2 lt 3,\
Planet4 u 1:2 w l lw 2 lt 4,\
Planet5 u 1:2 w l lw 2 lt 5,\
Planet6 u 1:2 w l lw 2 lt 6,\
Planet7 u 1:2 w l lw 2 lt 7,\
Planetesimal1 u 1:2 w l lw 2 dt 2 lt 1,\
Planetesimal2 u 1:2 w l lw 2 dt 2 lt 2,\
Planetesimal3 u 1:2 w l lw 2 dt 2 lt 3,\
Planetesimal4 u 1:2 w l lw 2 dt 2 lt 4,\
Planetesimal5 u 1:2 w l lw 2 dt 2 lt 5,\
Planetesimal6 u 1:2 w l lw 2 dt 2 lt 6,\
Planetesimal7 u 1:2 w l lw 2 dt 2 lt 7



