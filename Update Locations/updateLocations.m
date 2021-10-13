clear all; close all; clc;

%% READ SHAPEFILE AND CONVERT COORDINATES TO LAT/LONG
S = shaperead('tiles.shp');
proj = projcrs(3857); %define the projection properties (EPSG Code = 3857 = Web Mercator)

for i = 1: length(S)
    xx = S(i).X;
    yy = S(i).Y;
    
    Locations(i).x = unique(xx(~isnan(xx)),'stable'); %Remove NaN and Duplicates 
    Locations(i).y = unique(yy(~isnan(yy)),'stable');
    Locations(i).tileName = S(i).Tile_Name;
    
   [Locations(i).latitudes Locations(i).longitudes] = projinv(proj,Locations(i).x,Locations(i).y); 
end
%% DEFINE THE DOMAIN HEIGHT 
Locations(strcmp({Locations.tileName},'50H_SOUTH1')).domainHeight = 300;
Locations(strcmp({Locations.tileName},'50H_SOUTH2')).domainHeight = 1000;
Locations(strcmp({Locations.tileName},'50H_SOUTH3')).domainHeight = 1000;
Locations(strcmp({Locations.tileName},'50G_NORTH1')).domainHeight = 500;
Locations(strcmp({Locations.tileName},'50G_NORTH2')).domainHeight = 900;
Locations(strcmp({Locations.tileName},'50G_NORTH3')).domainHeight = 1100;
Locations(strcmp({Locations.tileName},'50G_SOUTH1')).domainHeight = 900;
Locations(strcmp({Locations.tileName},'50G_SOUTH2')).domainHeight = 1500;
Locations(strcmp({Locations.tileName},'50G_SOUTH3')).domainHeight = 1500;
Locations(strcmp({Locations.tileName},'50H_NORTH')).domainHeight = 1000;
Locations(strcmp({Locations.tileName},'49G_NORTH')).domainHeight = 500;
Locations(strcmp({Locations.tileName},'50J')).domainHeight = 900;
Locations(strcmp({Locations.tileName},'51G')).domainHeight = 900;
Locations(strcmp({Locations.tileName},'49G_SOUTH')).domainHeight = 500;
Locations(strcmp({Locations.tileName},'51H_SOUTH')).domainHeight = 850;
Locations(strcmp({Locations.tileName},'51H_NORTH')).domainHeight = 900;
Locations(strcmp({Locations.tileName},'49H')).domainHeight = 300;
Locations(strcmp({Locations.tileName},'49J')).domainHeight = 300;
Locations(strcmp({Locations.tileName},'48G')).domainHeight = 300;
Locations(strcmp({Locations.tileName},'48H')).domainHeight = 300;
Locations(strcmp({Locations.tileName},'51J')).domainHeight = 900;
Locations(strcmp({Locations.tileName},'52J')).domainHeight = 300;
Locations(strcmp({Locations.tileName},'52H')).domainHeight = 500;
Locations(strcmp({Locations.tileName},'52G')).domainHeight = 900;
Locations(strcmp({Locations.tileName},'47J')).domainHeight = 300;
Locations(strcmp({Locations.tileName},'53J')).domainHeight = 500;
Locations(strcmp({Locations.tileName},'52J')).domainHeight = 300;
Locations(strcmp({Locations.tileName},'53H')).domainHeight = 300;
%% DEFINE THE SKETCHUP X and Y COORDINATES
Locations(strcmp({Locations.tileName},'50H_SOUTH1')).xSketchup = [-157.2396, -457.4110, 160.8532, 457.4694, 445.6020]; 
Locations(strcmp({Locations.tileName},'50H_SOUTH1')).ySketchup = [-597.7275, 431.0462, 597.6783, -424.2419, -432.4362]; 
Locations(strcmp({Locations.tileName},'50H_NORTH')).xSketchup = [-232.7727, -851.0466,-1133.5199, -534.5746, 245.2776, 624.0444, 837.9241, 1133.5907, 916.0749, 873.5804, 812.7457, 528.2015, 100.2419, -185.0583] ; 
Locations(strcmp({Locations.tileName},'50H_NORTH')).ySketchup = [-597.7966, -764.3923, 198.4619, 370.8119, 593.2803, 707.8729, 764.4122, -219.6118, -282.6756, -289.2879, -305.0434, -388.9810, -517.4528, -593.6609];
Locations(strcmp({Locations.tileName},'50H_SOUTH2')).xSketchup = [-238.3569, -534.8670, -487.1524, -201.8487, 226.1166, 534.9307, 482.9668, -4.8660];
Locations(strcmp({Locations.tileName},'50H_SOUTH2')).ySketchup = [-615.3902, 406.5608, 410.6944, 486.8895, 615.3421, -390.9717, -407.2815, -549.1257];
Locations(strcmp({Locations.tileName},'50H_SOUTH3')).xSketchup = [-148.4644, -457.1758, -172.6193, -111.7822, -69.2868, 148.2383, 227.4133, 236.8887, 457.2323, 222.2436];
Locations(strcmp({Locations.tileName},'50H_SOUTH3')).ySketchup = [-587.8367, 418.5086, 502.4043, 518.1509, 524.7569, 587.7887, 337.9254, 318.8975, -409.4265, -474.3036];
Locations(strcmp({Locations.tileName},'50G_NORTH1')).xSketchup = [-196.1765, -404.1811, 198.6666, 210.5343, 402.9914, 404.2112];
Locations(strcmp({Locations.tileName},'50G_NORTH1')).ySketchup = [-446.9943, 273.5080, 438.7770, 446.9709, -203.0307, -225.1965];
Locations(strcmp({Locations.tileName},'50G_NORTH2')).xSketchup = [-265.7143, -266.9319, -459.3239, -225.8308, 262.0066, 459.3544, -41.6600];
Locations(strcmp({Locations.tileName},'50G_NORTH2')).ySketchup = [-440.1450, -417.9791, 232.0418, 298.2986, 440.1267, -211.9027, -358.6270];
Locations(strcmp({Locations.tileName},'50G_NORTH3')).xSketchup = [-224.9981, -422.2793, -370.3131, 0.3986, 235.3895, 422.3057, 347.7039];
Locations(strcmp({Locations.tileName},'50G_NORTH3')).ySketchup = [-423.3805, 228.6690, 244.9718, 358.4926, 423.3619, -190.8324, -256.7631];
Locations(strcmp({Locations.tileName},'50G_SOUTH1')).xSketchup = [-371.2042, -463.3434, 137.0531, 252.7678, 463.4077, -22.1193, -186.1094, -211.6716, -44.6761, -220.5725, -279.3402, -304.9733, -322.5799];
Locations(strcmp({Locations.tileName},'50G_SOUTH1')).ySketchup = [123.9112, 431.8730, 653.6469, 267.7162, -497.0321, -653.7088, -647.5476, -561.9221, -413.7684, -118.6175, -84.3091, -59.6699, -38.6108];
Locations(strcmp({Locations.tileName},'50G_SOUTH2')).xSketchup = [-182.2097, -392.7759, -508.4533, -284.3962, 216.6236, 357.1463, 356.9031, 320.2803, 305.3085, 299.2624, 310.8042, 270.4853, 283.0282, 295.8654, 306.6670, 314.5095, 324.7390, 338.4704, 345.3874, 354.3420, 367.4426, 374.4511, 381.8133, 389.8770, 397.5903, 405.6473, 508.5228];
Locations(strcmp({Locations.tileName},'50G_SOUTH2')).ySketchup = [-689.4955, 75.2731, 461.2150, 542.7248, 689.4310, 167.7062, 153.6307, 152.7913, 145.6648, 133.3862, 81.9823, 73.3295, 60.0770, 52.1968, 41.7303, 30.5276, 8.8736, -22.8672, -34.4363, -44.1602, -54.1873, -58.5842, -61.7536, -63.8711, -65.4619, -73.1949, -454.5302];
Locations(strcmp({Locations.tileName},'50G_SOUTH3')).xSketchup = [-214.8507, -317.6850, -325.7412, -333.4544, -341.5178, -348.8796, -355.8877, -368.9872, -377.9408, -384.8565, -398.5844, -408.8117, -416.6529, -427.4534, -440.2897, -452.8312, -412.5114, -424.0477, -418.0002, -403.0276, -366.4047, -366.1600, -506.6264, 66.0826, 140.6872, 235.4550, 292.5640, 325.1393, 506.6941];
Locations(strcmp({Locations.tileName},'50G_SOUTH3')).ySketchup = [-688.2895, -306.9430, -299.2092, -297.6175, -295.4992, -292.3290, -287.9313, -277.9028, -268.1779, -256.6081, -224.8657, -203.2106, -192.0071, -181.5394, -173.6578, -160.4040, -151.7556, -100.3504, -88.0725, -80.9476, -80.1121, -66.0367, 455.7033, 622.2967, 688.2242, 388.2276, 207.4382, 139.3907, -439.7643];
Locations(strcmp({Locations.tileName},'49G_SOUTH')).xSketchup = [1046.5731, 1072.2112, 1130.9859, 1306.9418, 1139.9761, 476.1295, 530.6194, -305.4009, -1176.6760, -1227.6088, -1306.9431, -1046.5930, -1008.0673, -971.0902, -871.0148, -804.3696, -746.9529, -663.4857, -597.1133, -530.8882, -505.4227, -381.2786, -39.5730, -9.5774, 18.7073, 56.5736, 152.4444, 302.8275, 294.3874, 292.1044, 300.3000, 475.4608, 851.2618, 980.3052, 1028.9623];
Locations(strcmp({Locations.tileName},'49G_SOUTH')).ySketchup = [485.5061, 460.8721, 426.5755, 131.4600, -16.7273, -224.7990, -399.7332, -676.5781, -508.4498, -263.4792, 124.6539, 209.8807, 80.2419, 84.5558, 117.8125, 71.3350, 217.7649, 319.9332, 347.4145, 372.2524, 375.6228, 422.8608, 552.8959, 559.6583, 553.9699, 511.4819, 478.2743, 487.4911, 556.7712, 571.4042, 617.5835, 630.9769, 676.5713, 669.0738, 506.5616];
Locations(strcmp({Locations.tileName},'49G_NORTH')).xSketchup = [1052.4499, 1144.6588, 1015.6152, 639.8153, 464.6548, 456.4604, 458.7438, 467.1856, 316.8027, 220.9311, 183.0637, 154.7789, 124.7835, -216.9190, -341.0619, -366.5273, -432.7518, -499.1235, -582.5882, -640.0013, -706.6476, -806.7222, -843.6992, -882.2281, -983.0214, -1041.1937, -1144.5779, -587.6132, -355.5729, 101.4768, 239.5609, 844.3110];
Locations(strcmp({Locations.tileName},'49G_NORTH')).ySketchup = [92.6228, -215.3181, -207.8238, -253.4274, -266.8251, -313.0046, -327.6375, -396.9174, -406.1379, -372.9327, -330.4456, -324.7579, -331.5210, -461.5645, -508.8056, -512.1766, -537.0161, -564.4990, -666.6694, -813.1006, -766.6248, -799.8840, -804.1988, -674.5609, -312.8953, -103.1580, 258.0580, 413.1896, 477.8228, 605.7168, 644.3452, 813.0864];
Locations(strcmp({Locations.tileName},'51G')).xSketchup = [-1307.3115, -514.0217, 129.8781, 335.5338, 756.7478, 801.3505, 914.3216, 1085.1676, 1189.8173, 1300.4136, 730.2715, 674.8085, 648.7071, 703.3815, 1098.7008, 1133.8924, 1307.5974, 1282.3407, 777.5392, 107.9471, -707.6135, -754.7424, -936.1881, -968.7506, -1025.8256, -1120.5368];
Locations(strcmp({Locations.tileName},'51G')).ySketchup = [634.4282, 870.9087, 1063.6876, 1125.2636, 1256.7342, 1179.3244, 1039.3815, 833.6077, 668.8282, 488.8928, 178.0854, 167.9455, 169.2294, 110.3044, -559.4492, -605.0448, -830.1114, -840.4690, -944.3178, -1085.4331, -1256.8882, -1107.8665, -528.677, -460.6237, -279.8235, 20.1909];
Locations(strcmp({Locations.tileName},'51H_SOUTH')).xSketchup = [959.8415, 1016.0338, 1149.5369, 1186.4405, 765.2349, 559.5832, -84.3043, -877.5789, -1097.7774, -1107.2490, -1186.3741, -1084.9606, -374.2428, -367.6549, 34.0654, 27.5701, 269.6039, 602.0364, 612.6043, 625.1162, 639.2321, 645.0903, 704.9300, 711.0030, 714.6244, 719.6358, 724.2796, 738.2003, 742.2436, 943.3028];
Locations(strcmp({Locations.tileName},'51H_SOUTH')).ySketchup = [774.8587, 504.3440, -138.6868, -231.7937, -363.2913, -424.8805, -617.7008, -854.2321, -125.8642, -106.8344, 143.0447, 138.6349, 343.7372, 347.7821, 466.0669, 486.0642, 560.1020, 660.6894, 653.0241, 659.9449, 676.4779, 678.8548, 683.2423, 685.5458, 690.7454, 753.7777, 765.9154, 796.6908, 809.7694, 854.2479];
Locations(strcmp({Locations.tileName},'51H_NORTH')).xSketchup = [959.6293, 1107.8380, 1159.4366, 1212.5314, 1011.4740, 1007.4313, 993.5118, 988.8684, 983.8595, 980.2384, 974.1655, 914.3259, 908.4678, 894.3526, 881.8410, 871.2728, 538.8444, 296.8136, 303.3097, -98.4059, -104.9937, -815.7032, -917.1169, -1212.4820, -904.4382, -412.1878, -350.3757, 57.1558, 169.4736, 233.9902, 351.4178, 385.3326, 785.2747, 812.9209, 845.7352, 891.1990];
Locations(strcmp({Locations.tileName},'51H_NORTH')).ySketchup = [442.1731, 226.3141, 110.0013, -79.2908, -123.7774, -136.8562, -167.6322, -179.7700, -242.8025, -248.0022, -250.3060, -254.6959, -257.0730, -273.6066, -280.5279, -272.8630, -373.4638, -447.5114, -467.5083, -585.8093, -589.8545, -794.9854, -790.5797, 193.5348, 288.1922, 429.3746, 444.3099, 375.6959, 473.5244, 535.6425, 648.7046, 680.3231, 787.2311, 794.9907, 668.3430, 559.4836];
Locations(strcmp({Locations.tileName},'49H')).xSketchup = [-723.6095, -1038.0420, -1264.9789, -478.2890, 67.7819, 682.1202, 964.8546, 1265.2445, 660.5050, 522.4234, 65.3817, -166.6545];
Locations(strcmp({Locations.tileName},'49H')).ySketchup = [-1273.4037, -124.0408, 687.7840, 924.2935, 1089.9493, 1273.2371, 310.4596, -718.2503, -887.0296, -925.6667, -1053.5894, -1118.2372];
Locations(strcmp({Locations.tileName},'48G')).xSketchup = [896.3518, 999.8460, 1058.0823, 1158.9857, 898.6637, 978.1258, 1029.1391, 327.1591, -125.8157, -1063.4088, -1116.5550, -1158.8712, -1018.6095, -939.7082, -591.3426, -526.4668, -512.8150, -324.9821, -220.7710, -113.9669, -5.1318, 202.7199, 250.8730, 306.9306, 423.7535, 535.0988, 659.7775, 779.7029];
Locations(strcmp({Locations.tileName},'48G')).ySketchup = [825.4751, 464.2906, 254.5710, -107.0638, -192.3763, -580.4834, -825.4371, -463.3703, -119.5655, 194.7957, 416.9418, 555.2147, 545.0969, 510.0460, 417.6523, 428.1641, 440.0828, 488.2112, 516.4306, 544.9542, 574.0227, 632.7839, 644.7245, 660.5993, 693.1211, 723.5032, 760.5413, 793.7774];
Locations(strcmp({Locations.tileName},'48H')).xSketchup = [-1265.6545, -801.2051, -651.2179, -275.3927, -73.6809, 119.0064, 130.2306, 209.8602, 287.8863, 370.7227, 456.7682, 542.8145, 634.7385, 723.9647, 951.1428, 1265.9167, 1149.2695, 1029.3459, 904.6692, 793.3256, 676.5045, 620.4478, 572.2953, 364.4469, 255.6134, 148.8109, 44.6013, -143.2289, -156.8800, -221.7552, -570.1259, -649.0292, -789.2914, -960.2535, -991.6661, -1084.6532, -1096.9436, -1133.4780];
Locations(strcmp({Locations.tileName},'48H')).ySketchup = [610.5657, 746.2888, 789.5945, 898.3052, 956.4372, 1012.7947, 1016.5292, 1039.9996, 1062.4005, 1085.3329, 1109.8657, 1134.3964, 1160.5277, 1184.3832, 372.6259, -776.6436, -808.3477, -841.5904, -878.6355, -909.0236, -941.5520, -957.4298, -969.3730, -1028.1458, -1057.2202, -1085.7498, -1113.9749, -1162.1137, -1174.0331, -1184.5484, -1092.1740, -1057.1275, -1047.0174, -478.5738, -377.3480, -62.7725, -19.0824, 186.7925];
Locations(strcmp({Locations.tileName},'52G')).xSketchup = [-1358.4756, -797.4029, -542.9854, -261.4047, 44.8185, 536.5406, 629.0935, 677.1817, 724.4735, 847.3021, 1019.2898, 1241.0562, 1257.8506, 1285.1542, 1290.4121, 1372.2508, 1415.3340, 1466.9602, 1262.9623, 795.8937, 754.0433, 482.4315, 202.5476, 88.9405, 54.1342, 4.3849, -267.7680, -474.5186, -788.2530, -808.2853, -981.9192, -1017.0964, -1412.2041, -1466.8599, -1440.7589, -1385.2927, -815.0524, -925.5919, -1030.1896, -1200.9706, -1313.8974];
Locations(strcmp({Locations.tileName},'52G')).ySketchup = [958.0644, 1132.1703, 1210.6320, 1297.4599, 1390.7965, 1540.6843, 1240.7358, 1093.6349, 1003.1430, 793.8020, 510.3957, 131.1778, 66.5037, -132.0827, -196.7312, -242.7474, -355.0968, -587.0226, -653.1090, -804.4285, -756.8975, -448.4100, -1080.1707, -1139.4854, -1149.4882, -1150.0008, -1406.6327, -1540.9981, -1148.2716, -1128.9551, -903.8335, -858.2268, -188.3484, -129.4062, -130.6983, -120.5759, 190.0514, 370.0216, 534.8342, 740.6620, 880.6406];
Locations(strcmp({Locations.tileName},'52H')).xSketchup = [-626.2546, -663.1330, -796.4619, -852.5810, -869.0982, -922.1342, -973.6965, -1121.8381, -1190.2320, -1235.6619, -1268.4368, -1075.4539, -846.4732, -594.2591, -554.3950, -509.7352, -111.7260, 467.1660, 738.8668, 925.4710, 948.0224, 1268.6979, 776.9922, 470.7792, 189.2080, -65.2009];
Locations(strcmp({Locations.tileName},'52H')).ySketchup = [-1214.3892, -1121.2723, -478.2053, -207.6755, -128.2818, 61.0268, 177.3557, 393.2608, 510.5926, 619.4661, 746.1240, 799.2950, 859.9310, 926.7251, 937.3831, 951.5666, 1058.4550, 1214.2160, 338.2944, 458.4293, 386.8124, -631.5620, -781.5037, -874.8738, -961.7324, -1040.2220];
Locations(strcmp({Locations.tileName},'47J')).xSketchup = [-692.1297, -720.8236, -784.0078, -806.3441, -857.3968, -874.6237, -893.1227, -914.8011, -771.8343, -850.8653, -873.5381, -896.2115, -919.8291, -956.6730, -989.8671, -995.4037, -1059.6444, -1112.5500, -1233.4847, -1278.4153, -1205.5531, -618.9495, -173.9088, 58.8719, 100.5769, 666.4978, 754.2482, 872.9432, 914.9075, 976.3031, 1043.9297, 1088.3604, 1157.1325, 1278.6794, 856.2518, 726.2095, 473.1144, 373.1885, 243.7765, 30.6954, -33.6563, -105.1514, -142.3288, -176.6656, -368.6644];
Locations(strcmp({Locations.tileName},'47J')).ySketchup = [-1290.3634, -1195.8552, -1213.7185, -1213.0749, -1198.3740, -1181.1293, -1144.7284, -1070.6548, -1029.1918, -768.5542, -691.9005, -614.2989, -534.8077, -409.8973, -294.1861, -276.4685, -55.9779, 118.1457, 529.7937, 690.8171, 715.0942, 895.1017, 1032.4455, 1103.9186, 1116.7248, 1290.1854, 1010.4986, 629.5301, 496.8523, 299.5697, 79.5276, -68.8518, -287.1816, -691.6302, -820.4724, -857.9203, -932.0904, -963.4245, -1003.4492, -1069.9105, -1089.2028, -1110.6407, -1121.3587, -1133.0337, -1191.6468];
Locations(strcmp({Locations.tileName},'53J')).xSketchup = [-875.9765, -975.7091, -814.0822, -882.5260, -941.8785, -1000.2462, -1045.3866, -1058.6802, -1118.5699, -1172.2500, -1186.9570, -1202.2640, -1226.6968, -1271.6228, -1241.3035, -1262.5823, -1140.3234, -1080.8187, -1040.5153, -898.5369, -814.2445, -729.0012, -594.4406, -532.7993, -498.6261, -426.2346, -340.1601, -31.3228, 115.0843, 195.2816, 219.5811, 241.2261, 257.1969, 549.9969, 661.9153, 712.8742, 770.6013, 945.8116, 974.6784, 1025.2574, 1085.7979, 1154.6258, 1243.0526, 1271.8362, 596.9080, 400.5678, -98.8432, -223.8348, -675.2248];
Locations(strcmp({Locations.tileName},'53J')).ySketchup = [-1336.6668, -964.4221, -922.1929, -687.7207, -490.4395, -291.7161, -140.2732, -94.9999, 108.9845, 302.6911, 348.2746, 377.9167, 398.4662, 417.9191, 490.7441, 563.0710, 608.2360, 620.9308, 640.9897, 711.1911, 763.2028, 831.6957, 853.3911, 921.2107, 994.3309, 1039.2859, 1119.9538, 1170.9536, 1217.0624, 1224.5241, 1217.7485, 1221.1013, 1218.2995, 1302.4525, 1336.4917, 1135.3487, 894.0064, 333.2800, 243.3632, 83.2848, -105.6932, -329.9456, -611.0219, -704.0051, -904.8335, -963.2373, -1111.7919, -1148.9728, -1281.8018];
Locations(strcmp({Locations.tileName},'52J')).xSketchup = [-549.7862, -577.4339, -640.2320, -968.1420, -1087.9698, -1057.7987, -990.8214, -1018.1789, -1043.6916, -1305.0562, -1293.7174, -1076.6972, -972.3771, -916.1775, -819.3175, -814.1854, -810.5283, -803.7524, -795.4188, -742.0366, -688.3517, -659.4387, -565.8404, -543.1545, -502.2026, -384.5149, -290.5016, -240.2403, -206.4542, -194.1004, -181.6877, -170.1233, -119.7517, -104.0548, -95.7778, -92.4454, -75.6684, -66.8113, -59.3381, -11.3450, 22.5062, 61.2894, 93.4640, 95.8827, 85.7752, 157.0026, 212.0352, 224.5174, 238.3762, 252.6911, 261.9222, 273.4760, 281.3295, 260.6900, 276.7709, 295.8385, 331.0129, 384.0601, 409.3794, 446.9067, 517.1781, 526.0820, 615.0817, 657.0383, 789.2709, 877.5407, 856.7920, 847.2444, 892.1766, 916.6159, 931.9323, 946.6537, 1000.3953, 1060.3496, 1073.6575, 1118.8459, 1177.2765, 1236.6916, 1305.2096, 1143.5962, 1243.4467, 1185.7663, 606.8910, 208.8933, 164.2350, 124.3721, -127.8348, -356.8090];
Locations(strcmp({Locations.tileName},'52J')).ySketchup = [-1375.3905, -1383.1445, -1029.3136, -1105.0771, -801.6688, -756.5677, -559.9406, -224.4514, 107.3352, 309.3348, 324.3722, 612.1596, 704.5468, 668.4871, 647.9955, 681.9054, 687.6329, 689.7067, 688.1286, 676.8334, 689.7750, 689.7284, 736.4893, 748.9602, 778.6033, 801.1602, 805.1234, 785.2333, 773.6228, 765.3506, 790.9029, 802.4311, 843.5907, 860.8878, 878.1978, 895.5210, 919.2522, 931.7800, 958.9961, 1048.8407, 1073.5298, 1089.9573, 1097.3299, 1177.0944, 1207.6237, 1248.1804, 1273.9722, 1277.6494, 1276.2381, 1271.1283, 1265.5653, 1266.4695, 1265.9938, 1325.7199, 1325.0966, 1328.9358, 1349.7311, 1374.0697, 1378.7933, 1382.9004, 1380.9939, 1363.9964, 1341.4982, 1323.5497, 1235.6461, 1008.2875, 935.9673, 863.1327, 843.6940, 823.1522, 793.5150, 747.9362, 554.2466, 350.2811, 305.0121, 153.5835, -45.1214, -242.3838, -476.8343, -519.1147, -891.3278, -907.1121, -1062.9352, -1169.8664, -1184.0547, -1194.7170, -1261.5382, -1322.1988];
Locations(strcmp({Locations.tileName},'53H')).xSketchup = [-584.6918, -905.0852, -927.6168, -1114.2543, -1385.7125, -1328.0260, -1127.2706, -675.8717, -550.8776, -51.4565, 144.8876, 819.8294, 1041.4582, 1099.9206, 1291.4881, 1385.9682, 514.5865, 134.2931];
Locations(strcmp({Locations.tileName},'53H')).ySketchup = [-1247.2168, -228.7536, -157.1305, -277.2138, 598.7831, 614.5452, 669.3967, 802.1952, 839.3676, 987.8885, 1046.2790, 1247.0618, 510.2593, 315.9229, -321.2882, -635.5645, -902.9503, -1020.1330];

%% DEFINE THE PLANE HEIGHTS TO EXTRACT
for i=1:length(Locations)
    if isempty(Locations(i).domainHeight)
        %checks if the sketchup coordinates are defined yet
        continue 
    end 
    Locations(i).planeHeights = [1 2:2:20 24:4:100 200:100:Locations(i).domainHeight; 1.5 2:2:20 24:4:100 200:100:Locations(i).domainHeight];
end
%% DEFINE THE GEOMETRIC TRANSFORMATION FOR EACH TILE 
for i=1:length(Locations)
    if isempty(Locations(i).xSketchup) | isempty(Locations(i).ySketchup)
        %checks if the sketchup coordinates are defined yet
        continue 
    end 
    Locations(i).transformLatLong2Sketchup = estimateGeometricTransform([Locations(i).longitudes' Locations(i).latitudes'],[Locations(i).xSketchup' Locations(i).ySketchup'],'projective');
end
%% DRAW THE LAT/LONG TILES 
%Uncomment this to draw unshifted tile
figure;
for i=1:length(Locations)
    subplot(1,2,1)
    hold on
    Shape = polyshape(Locations(i).longitudes,Locations(i).latitudes); %Defines polygon for each tile based on lat and long coordinates
    plot(Shape,'FaceColor','blue','FaceAlpha',0.1,'EdgeColor','black','EdgeAlpha',0.5);
    plot(Locations(i).longitudes, Locations(i).latitudes, '.k');
    [xCent yCent] = centroid(Shape);
    T=text(xCent-0.002,yCent,Locations(i).tileName); %add tile name to the centroid of the shape
    set(T,'fontsize', 4);
    set(T,'Interpreter','none');
    title('Lat/Long');

%     subplot(1,2,2)
%     hold on
%     Shape = polyshape(Locations(i).x,Locations(i).y); %Defines polygon for each tile based on lat and long coordinates
%     plot(Shape,'FaceColor','blue','FaceAlpha',0.1,'EdgeColor','black','EdgeAlpha',0.5);
%     [xCent yCent] = centroid(Shape);
%     T=text(xCent-300,yCent,Locations(i).tileName); %add tile name to the centroid of the shape
%     set(T,'fontsize', 4);
%     set(T,'Interpreter','none');
%     title('x/y');
end 
%% DRAW THE SKETCHUP TILES 
% Uncomment this to draw shifted tile
n = find(strcmp({Locations.tileName},'53H')); %the row of tile 
for i=n
    subplot(1,2,2)
    hold on
    Shape = polyshape(Locations(i).xSketchup,Locations(i).ySketchup); %Defines polygon for each tile based on lat and long coordinates
    plot(Shape,'FaceColor','blue','FaceAlpha',0.1,'EdgeColor','black','EdgeAlpha',0.5)
    plot(Locations(i).xSketchup,Locations(i).ySketchup, '.k');
    [xCent yCent] = centroid(Shape);
    T=text(xCent-100,yCent,Locations(i).tileName); %add tile name to the centroid of the shape
    set(T,'fontsize', 6);
    set(T,'Interpreter','none');
end 

save('Locations.mat','Locations');