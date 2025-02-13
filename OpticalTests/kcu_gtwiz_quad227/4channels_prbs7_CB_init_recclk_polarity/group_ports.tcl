create_hw_probe -map {probe0[31:0]}   receiver_0[31:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[63:32]}  receiver_1[31:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[95:64]}   receiver_2[31:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[127:96]}  receiver_3[31:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[159:128]}   transmitter_0[31:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[191:160]}  transmitter_1[31:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[223:192]}   transmitter_2[31:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[255:224]}  transmitter_3[31:0] [get_hw_ilas hw_ila_1]

create_hw_probe -map {probe0[259:256]}  prbs_match_int[3:0] [get_hw_ilas hw_ila_1]

create_hw_probe -map {probe0[260]}  hb0_gtwiz_userclk_rx_usrclk2_int [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[261]}  hb0_gtwiz_userclk_rx_active_int [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[262]}  hb_gtwiz_reset_all_int [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[263]}  hb0_gtwiz_reset_rx_done_int [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[264]}  hb0_gtwiz_userclk_tx_usrclk2_int [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[265]}  hb0_gtwiz_userclk_tx_active_int [get_hw_ilas hw_ila_1]

create_hw_probe -map {probe0[269:266]} rx8b10ben_int[3:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[273:270]} rxcommadeten_int[3:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[277:274]} rxlpmen_int[3:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[281:278]} rxmcommaalignen_int[3:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[285:282]} rxpcommaalignen_int[3:0] [get_hw_ilas hw_ila_1]

create_hw_probe -map {probe0[289:286]} tx8b10ben_int[3:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[293:290]} gtpowergood_int[3:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[297:294]} rxbyteisaligned_int[3:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[301:298]} rxbyterealign_int[3:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[305:302]} rxcommadet_int[3:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[309:306]} rxpmaresetdone_int[3:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[313:310]} txpmaresetdone_int[3:0] [get_hw_ilas hw_ila_1]

create_hw_probe -map {probe0[329:314]}  ch0_rxctrl0_int[15:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[345:330]}  ch1_rxctrl0_int[15:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[361:346]}  ch2_rxctrl0_int[15:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[377:362]}  ch3_rxctrl0_int[15:0] [get_hw_ilas hw_ila_1]

create_hw_probe -map {probe0[393:378]}  ch0_rxctrl1_int[15:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[409:394]}  ch1_rxctrl1_int[15:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[425:410]}  ch2_rxctrl1_int[15:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[441:426]}  ch3_rxctrl1_int[15:0] [get_hw_ilas hw_ila_1]

create_hw_probe -map {probe0[449:442]}  ch0_rxctrl2_int[7:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[457:450]}  ch1_rxctrl2_int[7:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[465:458]}  ch2_rxctrl2_int[7:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[473:466]}  ch3_rxctrl2_int[7:0] [get_hw_ilas hw_ila_1]

create_hw_probe -map {probe0[481:474]}  ch0_rxctrl3_int[7:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[489:482]}  ch1_rxctrl3_int[7:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[497:490]}  ch2_rxctrl3_int[7:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[505:498]}  ch3_rxctrl3_int[7:0] [get_hw_ilas hw_ila_1]

create_hw_probe -map {probe0[521:506]}  ch0_txctrl0_int[15:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[537:522]}  ch1_txctrl0_int[15:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[553:538]}  ch2_txctrl0_int[15:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[569:554]}  ch3_txctrl0_int[15:0] [get_hw_ilas hw_ila_1]

create_hw_probe -map {probe0[585:570]}  ch0_txctrl1_int[15:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[601:586]}  ch1_txctrl1_int[15:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[617:602]}  ch2_txctrl1_int[15:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[633:618]}  ch3_txctrl1_int[15:0] [get_hw_ilas hw_ila_1]

create_hw_probe -map {probe0[641:634]}  ch0_txctrl2_int[7:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[649:642]}  ch1_txctrl2_int[7:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[657:650]}  ch2_txctrl2_int[7:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[665:658]}  ch3_txctrl2_int[7:0] [get_hw_ilas hw_ila_1]

create_hw_probe -map {probe0[705:666]}  hb0_rxdata_nml_ctr[39:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[721:706]}  ch0_rxdata_err_ctr[15:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[737:722]}  ch1_rxdata_err_ctr[15:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[753:738]}  ch2_rxdata_err_ctr[15:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[769:754]}  ch3_rxdata_err_ctr[15:0] [get_hw_ilas hw_ila_1]

create_hw_probe -map {probe0[773:770]}  rxchanisaligned_int[3:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[777:774]}  rxchanrealign_int[3:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[781:778]}  rxchanbondseq_int[3:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[801:782]}  rxchbondi_int[19:0] [get_hw_ilas hw_ila_1]
create_hw_probe -map {probe0[821:802]}  rxchbondo_int[19:0] [get_hw_ilas hw_ila_1]
