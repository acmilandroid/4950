function xcp = Senior_Design_G4xcp

xcp.events     =  repmat(struct('id',{}, 'sampletime', {}, 'offset', {}), getNumEvents, 1 );
xcp.parameters =  repmat(struct('symbol',{}, 'size', {}, 'dtname', {}, 'baseaddr', {}), getNumParameters, 1 );
xcp.signals    =  repmat(struct('symbol',{}), getNumSignals, 1 );
xcp.models     =  cell(1,getNumModels);
    
xcp.models{1} = 'Senior_Design_G4';
   
   
         
xcp.events(1).id         = 0;
xcp.events(1).sampletime = 0.001;
xcp.events(1).offset     = 0.0;
    
xcp.signals(1).symbol =  'Senior_Design_G4_B.Period';
    
xcp.signals(2).symbol =  'Senior_Design_G4_B.stepper_left_right';
    
xcp.signals(3).symbol =  'Senior_Design_G4_B.Gain';
    
xcp.signals(4).symbol =  'Senior_Design_G4_B.Quantizer';
    
xcp.signals(5).symbol =  'Senior_Design_G4_B.load_cell';
    
xcp.signals(6).symbol =  'Senior_Design_G4_B.Q4AD_o1';
    
xcp.signals(7).symbol =  'Senior_Design_G4_B.Q4AD_o2';
    
xcp.signals(8).symbol =  'Senior_Design_G4_B.uUsesimulatedmotor0Userealmotor';
    
xcp.signals(9).symbol =  'Senior_Design_G4_B.Derivative1';
    
xcp.signals(10).symbol =  'Senior_Design_G4_B.Kd';
    
xcp.signals(11).symbol =  'Senior_Design_G4_B.Ki';
    
xcp.signals(12).symbol =  'Senior_Design_G4_B.Kp';
    
xcp.signals(13).symbol =  'Senior_Design_G4_B.Setpoint';
    
xcp.signals(14).symbol =  'Senior_Design_G4_B.Integrator1';
    
xcp.signals(15).symbol =  'Senior_Design_G4_B.ErrorSignal';
    
xcp.signals(16).symbol =  'Senior_Design_G4_B.Sum4';
    
xcp.signals(17).symbol =  'Senior_Design_G4_B.Merge1';
    
xcp.signals(18).symbol =  'Senior_Design_G4_B.Merge3';
    
xcp.signals(19).symbol =  'Senior_Design_G4_B.PulseGenerator1';
    
xcp.signals(20).symbol =  'Senior_Design_G4_B.Merge2';
    
xcp.signals(21).symbol =  'Senior_Design_G4_B.angular_positionrelative_countC';
    
xcp.signals(22).symbol =  'Senior_Design_G4_B.Saturation';
    
xcp.signals(23).symbol =  'Senior_Design_G4_B.Channel0ofEncoderInputs';
    
xcp.signals(24).symbol =  'Senior_Design_G4_B.BackemfKe1';
    
xcp.signals(25).symbol =  'Senior_Design_G4_B.Dampingb1';
    
xcp.signals(26).symbol =  'Senior_Design_G4_B.GainKt2';
    
xcp.signals(27).symbol =  'Senior_Design_G4_B.GainKt3';
    
xcp.signals(28).symbol =  'Senior_Design_G4_B.Inductance';
    
xcp.signals(29).symbol =  'Senior_Design_G4_B.ResistanceR1';
    
xcp.signals(30).symbol =  'Senior_Design_G4_B.Integrator1_h';
    
xcp.signals(31).symbol =  'Senior_Design_G4_B.Integrator5';
    
xcp.signals(32).symbol =  'Senior_Design_G4_B.Integrator6';
    
xcp.signals(33).symbol =  'Senior_Design_G4_B.Sum1';
    
xcp.signals(34).symbol =  'Senior_Design_G4_B.Sum2_e';
    
xcp.signals(35).symbol =  'Senior_Design_G4_B.complementtheinput';
    
xcp.signals(36).symbol =  'Senior_Design_G4_B.Product';
    
xcp.signals(37).symbol =  'Senior_Design_G4_B.Product1';
    
xcp.signals(38).symbol =  'Senior_Design_G4_B.complementtheinput1';
    
xcp.signals(39).symbol =  'Senior_Design_G4_B.Product2';
    
xcp.signals(40).symbol =  'Senior_Design_G4_B.Product3';
    
xcp.signals(41).symbol =  'Senior_Design_G4_B.Sum2';
    
xcp.signals(42).symbol =  'Senior_Design_G4_B.Merge1';
    
xcp.signals(43).symbol =  'Senior_Design_G4_B.Merge1';
    
xcp.signals(44).symbol =  'Senior_Design_G4_B.Merge3';
    
xcp.signals(45).symbol =  'Senior_Design_G4_B.Merge3';
    
xcp.signals(46).symbol =  'Senior_Design_G4_B.Merge3';
    
xcp.signals(47).symbol =  'Senior_Design_G4_B.Merge2';
    
xcp.signals(48).symbol =  'Senior_Design_G4_B.Merge2';
         
xcp.parameters(1).symbol = 'Senior_Design_G4_P.Period_Value';
xcp.parameters(1).size   =  1;       
xcp.parameters(1).dtname = 'real_T'; 
xcp.parameters(2).baseaddr = '&Senior_Design_G4_P.Period_Value';     
         
xcp.parameters(2).symbol = 'Senior_Design_G4_P.gripper_on_Value';
xcp.parameters(2).size   =  1;       
xcp.parameters(2).dtname = 'real_T'; 
xcp.parameters(3).baseaddr = '&Senior_Design_G4_P.gripper_on_Value';     
         
xcp.parameters(3).symbol = 'Senior_Design_G4_P.linear_act_Value';
xcp.parameters(3).size   =  1;       
xcp.parameters(3).dtname = 'real_T'; 
xcp.parameters(4).baseaddr = '&Senior_Design_G4_P.linear_act_Value';     
         
xcp.parameters(4).symbol = 'Senior_Design_G4_P.position_Value';
xcp.parameters(4).size   =  1;       
xcp.parameters(4).dtname = 'real_T'; 
xcp.parameters(5).baseaddr = '&Senior_Design_G4_P.position_Value';     
         
xcp.parameters(5).symbol = 'Senior_Design_G4_P.stepper_left_right_Value';
xcp.parameters(5).size   =  1;       
xcp.parameters(5).dtname = 'real_T'; 
xcp.parameters(6).baseaddr = '&Senior_Design_G4_P.stepper_left_right_Value';     
         
xcp.parameters(6).symbol = 'Senior_Design_G4_P.stepper_on_off_Value';
xcp.parameters(6).size   =  1;       
xcp.parameters(6).dtname = 'real_T'; 
xcp.parameters(7).baseaddr = '&Senior_Design_G4_P.stepper_on_off_Value';     
         
xcp.parameters(7).symbol = 'Senior_Design_G4_P.Gain_Gain';
xcp.parameters(7).size   =  1;       
xcp.parameters(7).dtname = 'real_T'; 
xcp.parameters(8).baseaddr = '&Senior_Design_G4_P.Gain_Gain';     
         
xcp.parameters(8).symbol = 'Senior_Design_G4_P.Quantizer_Interval';
xcp.parameters(8).size   =  1;       
xcp.parameters(8).dtname = 'real_T'; 
xcp.parameters(9).baseaddr = '&Senior_Design_G4_P.Quantizer_Interval';     
         
xcp.parameters(9).symbol = 'Senior_Design_G4_P.load_cell_Interval';
xcp.parameters(9).size   =  1;       
xcp.parameters(9).dtname = 'real_T'; 
xcp.parameters(10).baseaddr = '&Senior_Design_G4_P.load_cell_Interval';     
         
xcp.parameters(10).symbol = 'Senior_Design_G4_P.Q4AD_P1';
xcp.parameters(10).size   =  1;       
xcp.parameters(10).dtname = 'real_T'; 
xcp.parameters(11).baseaddr = '&Senior_Design_G4_P.Q4AD_P1';     
         
xcp.parameters(11).symbol = 'Senior_Design_G4_P.Q4AD_P2';
xcp.parameters(11).size   =  2;       
xcp.parameters(11).dtname = 'real_T'; 
xcp.parameters(12).baseaddr = '&Senior_Design_G4_P.Q4AD_P2[0]';     
         
xcp.parameters(12).symbol = 'Senior_Design_G4_P.Q4AD_P3';
xcp.parameters(12).size   =  2;       
xcp.parameters(12).dtname = 'real_T'; 
xcp.parameters(13).baseaddr = '&Senior_Design_G4_P.Q4AD_P3[0]';     
         
xcp.parameters(13).symbol = 'Senior_Design_G4_P.Q4AD_P5';
xcp.parameters(13).size   =  1;       
xcp.parameters(13).dtname = 'real_T'; 
xcp.parameters(14).baseaddr = '&Senior_Design_G4_P.Q4AD_P5';     
         
xcp.parameters(14).symbol = 'Senior_Design_G4_P.Q4AD_P6';
xcp.parameters(14).size   =  1;       
xcp.parameters(14).dtname = 'real_T'; 
xcp.parameters(15).baseaddr = '&Senior_Design_G4_P.Q4AD_P6';     
         
xcp.parameters(15).symbol = 'Senior_Design_G4_P.Q4AD_P7';
xcp.parameters(15).size   =  1;       
xcp.parameters(15).dtname = 'real_T'; 
xcp.parameters(16).baseaddr = '&Senior_Design_G4_P.Q4AD_P7';     
         
xcp.parameters(16).symbol = 'Senior_Design_G4_P.Q4Cnt_P1';
xcp.parameters(16).size   =  1;       
xcp.parameters(16).dtname = 'real_T'; 
xcp.parameters(17).baseaddr = '&Senior_Design_G4_P.Q4Cnt_P1';     
         
xcp.parameters(17).symbol = 'Senior_Design_G4_P.Q4Cnt_P2';
xcp.parameters(17).size   =  2;       
xcp.parameters(17).dtname = 'real_T'; 
xcp.parameters(18).baseaddr = '&Senior_Design_G4_P.Q4Cnt_P2[0]';     
         
xcp.parameters(18).symbol = 'Senior_Design_G4_P.Q4Cnt_P3';
xcp.parameters(18).size   =  2;       
xcp.parameters(18).dtname = 'real_T'; 
xcp.parameters(19).baseaddr = '&Senior_Design_G4_P.Q4Cnt_P3[0]';     
         
xcp.parameters(19).symbol = 'Senior_Design_G4_P.Q4Cnt_P4';
xcp.parameters(19).size   =  2;       
xcp.parameters(19).dtname = 'real_T'; 
xcp.parameters(20).baseaddr = '&Senior_Design_G4_P.Q4Cnt_P4[0]';     
         
xcp.parameters(20).symbol = 'Senior_Design_G4_P.Q4Cnt_P5';
xcp.parameters(20).size   =  2;       
xcp.parameters(20).dtname = 'real_T'; 
xcp.parameters(21).baseaddr = '&Senior_Design_G4_P.Q4Cnt_P5[0]';     
         
xcp.parameters(21).symbol = 'Senior_Design_G4_P.Q4Cnt_P6';
xcp.parameters(21).size   =  2;       
xcp.parameters(21).dtname = 'real_T'; 
xcp.parameters(22).baseaddr = '&Senior_Design_G4_P.Q4Cnt_P6[0]';     
         
xcp.parameters(22).symbol = 'Senior_Design_G4_P.Q4Cnt_P7';
xcp.parameters(22).size   =  2;       
xcp.parameters(22).dtname = 'real_T'; 
xcp.parameters(23).baseaddr = '&Senior_Design_G4_P.Q4Cnt_P7[0]';     
         
xcp.parameters(23).symbol = 'Senior_Design_G4_P.Q4Cnt_P8';
xcp.parameters(23).size   =  1;       
xcp.parameters(23).dtname = 'real_T'; 
xcp.parameters(24).baseaddr = '&Senior_Design_G4_P.Q4Cnt_P8';     
         
xcp.parameters(24).symbol = 'Senior_Design_G4_P.Q4Cnt_P9';
xcp.parameters(24).size   =  1;       
xcp.parameters(24).dtname = 'real_T'; 
xcp.parameters(25).baseaddr = '&Senior_Design_G4_P.Q4Cnt_P9';     
         
xcp.parameters(25).symbol = 'Senior_Design_G4_P.Q4Cnt_P10';
xcp.parameters(25).size   =  1;       
xcp.parameters(25).dtname = 'real_T'; 
xcp.parameters(26).baseaddr = '&Senior_Design_G4_P.Q4Cnt_P10';     
         
xcp.parameters(26).symbol = 'Senior_Design_G4_P.Q4DO_P1';
xcp.parameters(26).size   =  1;       
xcp.parameters(26).dtname = 'real_T'; 
xcp.parameters(27).baseaddr = '&Senior_Design_G4_P.Q4DO_P1';     
         
xcp.parameters(27).symbol = 'Senior_Design_G4_P.Q4DO_P2';
xcp.parameters(27).size   =  2;       
xcp.parameters(27).dtname = 'real_T'; 
xcp.parameters(28).baseaddr = '&Senior_Design_G4_P.Q4DO_P2[0]';     
         
xcp.parameters(28).symbol = 'Senior_Design_G4_P.Q4DO_P3';
xcp.parameters(28).size   =  1;       
xcp.parameters(28).dtname = 'real_T'; 
xcp.parameters(29).baseaddr = '&Senior_Design_G4_P.Q4DO_P3';     
         
xcp.parameters(29).symbol = 'Senior_Design_G4_P.Q4DO_P4';
xcp.parameters(29).size   =  2;       
xcp.parameters(29).dtname = 'real_T'; 
xcp.parameters(30).baseaddr = '&Senior_Design_G4_P.Q4DO_P4[0]';     
         
xcp.parameters(30).symbol = 'Senior_Design_G4_P.Q4DO_P5';
xcp.parameters(30).size   =  2;       
xcp.parameters(30).dtname = 'real_T'; 
xcp.parameters(31).baseaddr = '&Senior_Design_G4_P.Q4DO_P5[0]';     
         
xcp.parameters(31).symbol = 'Senior_Design_G4_P.Q4DO_P6';
xcp.parameters(31).size   =  1;       
xcp.parameters(31).dtname = 'real_T'; 
xcp.parameters(32).baseaddr = '&Senior_Design_G4_P.Q4DO_P6';     
         
xcp.parameters(32).symbol = 'Senior_Design_G4_P.Q4DO_P7';
xcp.parameters(32).size   =  1;       
xcp.parameters(32).dtname = 'real_T'; 
xcp.parameters(33).baseaddr = '&Senior_Design_G4_P.Q4DO_P7';     
         
xcp.parameters(33).symbol = 'Senior_Design_G4_P.Q4DO_P8';
xcp.parameters(33).size   =  1;       
xcp.parameters(33).dtname = 'real_T'; 
xcp.parameters(34).baseaddr = '&Senior_Design_G4_P.Q4DO_P8';     
         
xcp.parameters(34).symbol = 'Senior_Design_G4_P.uUsesimulatedmotor0Userealmotor';
xcp.parameters(34).size   =  1;       
xcp.parameters(34).dtname = 'real_T'; 
xcp.parameters(35).baseaddr = '&Senior_Design_G4_P.uUsesimulatedmotor0Userealmotor';     
         
xcp.parameters(35).symbol = 'Senior_Design_G4_P.Kd_Gain';
xcp.parameters(35).size   =  1;       
xcp.parameters(35).dtname = 'real_T'; 
xcp.parameters(36).baseaddr = '&Senior_Design_G4_P.Kd_Gain';     
         
xcp.parameters(36).symbol = 'Senior_Design_G4_P.Ki_Gain';
xcp.parameters(36).size   =  1;       
xcp.parameters(36).dtname = 'real_T'; 
xcp.parameters(37).baseaddr = '&Senior_Design_G4_P.Ki_Gain';     
         
xcp.parameters(37).symbol = 'Senior_Design_G4_P.Kp_Gain';
xcp.parameters(37).size   =  1;       
xcp.parameters(37).dtname = 'real_T'; 
xcp.parameters(38).baseaddr = '&Senior_Design_G4_P.Kp_Gain';     
         
xcp.parameters(38).symbol = 'Senior_Design_G4_P.gain_Gain';
xcp.parameters(38).size   =  1;       
xcp.parameters(38).dtname = 'real_T'; 
xcp.parameters(39).baseaddr = '&Senior_Design_G4_P.gain_Gain';     
         
xcp.parameters(39).symbol = 'Senior_Design_G4_P.Integrator1_IC';
xcp.parameters(39).size   =  1;       
xcp.parameters(39).dtname = 'real_T'; 
xcp.parameters(40).baseaddr = '&Senior_Design_G4_P.Integrator1_IC';     
         
xcp.parameters(40).symbol = 'Senior_Design_G4_P.Grip_Value';
xcp.parameters(40).size   =  1;       
xcp.parameters(40).dtname = 'real_T'; 
xcp.parameters(41).baseaddr = '&Senior_Design_G4_P.Grip_Value';     
         
xcp.parameters(41).symbol = 'Senior_Design_G4_P.Ungrip_Value';
xcp.parameters(41).size   =  1;       
xcp.parameters(41).dtname = 'real_T'; 
xcp.parameters(42).baseaddr = '&Senior_Design_G4_P.Ungrip_Value';     
         
xcp.parameters(42).symbol = 'Senior_Design_G4_P.Down_Value';
xcp.parameters(42).size   =  1;       
xcp.parameters(42).dtname = 'real_T'; 
xcp.parameters(43).baseaddr = '&Senior_Design_G4_P.Down_Value';     
         
xcp.parameters(43).symbol = 'Senior_Design_G4_P.Ld_Cll_Value';
xcp.parameters(43).size   =  1;       
xcp.parameters(43).dtname = 'real_T'; 
xcp.parameters(44).baseaddr = '&Senior_Design_G4_P.Ld_Cll_Value';     
         
xcp.parameters(44).symbol = 'Senior_Design_G4_P.Up_Value';
xcp.parameters(44).size   =  1;       
xcp.parameters(44).dtname = 'real_T'; 
xcp.parameters(45).baseaddr = '&Senior_Design_G4_P.Up_Value';     
         
xcp.parameters(45).symbol = 'Senior_Design_G4_P.PulseGenerator1_Amp';
xcp.parameters(45).size   =  1;       
xcp.parameters(45).dtname = 'real_T'; 
xcp.parameters(46).baseaddr = '&Senior_Design_G4_P.PulseGenerator1_Amp';     
         
xcp.parameters(46).symbol = 'Senior_Design_G4_P.PulseGenerator1_Period';
xcp.parameters(46).size   =  1;       
xcp.parameters(46).dtname = 'real_T'; 
xcp.parameters(47).baseaddr = '&Senior_Design_G4_P.PulseGenerator1_Period';     
         
xcp.parameters(47).symbol = 'Senior_Design_G4_P.PulseGenerator1_Duty';
xcp.parameters(47).size   =  1;       
xcp.parameters(47).dtname = 'real_T'; 
xcp.parameters(48).baseaddr = '&Senior_Design_G4_P.PulseGenerator1_Duty';     
         
xcp.parameters(48).symbol = 'Senior_Design_G4_P.PulseGenerator1_PhaseDelay';
xcp.parameters(48).size   =  1;       
xcp.parameters(48).dtname = 'real_T'; 
xcp.parameters(49).baseaddr = '&Senior_Design_G4_P.PulseGenerator1_PhaseDelay';     
         
xcp.parameters(49).symbol = 'Senior_Design_G4_P.angular_positionrelative_countC';
xcp.parameters(49).size   =  1;       
xcp.parameters(49).dtname = 'real_T'; 
xcp.parameters(50).baseaddr = '&Senior_Design_G4_P.angular_positionrelative_countC';     
         
xcp.parameters(50).symbol = 'Senior_Design_G4_P.Saturation_UpperSat';
xcp.parameters(50).size   =  1;       
xcp.parameters(50).dtname = 'real_T'; 
xcp.parameters(51).baseaddr = '&Senior_Design_G4_P.Saturation_UpperSat';     
         
xcp.parameters(51).symbol = 'Senior_Design_G4_P.Saturation_LowerSat';
xcp.parameters(51).size   =  1;       
xcp.parameters(51).dtname = 'real_T'; 
xcp.parameters(52).baseaddr = '&Senior_Design_G4_P.Saturation_LowerSat';     
         
xcp.parameters(52).symbol = 'Senior_Design_G4_P.Channel0Controlsignaltomotort_m';
xcp.parameters(52).size   =  1;       
xcp.parameters(52).dtname = 'real_T'; 
xcp.parameters(53).baseaddr = '&Senior_Design_G4_P.Channel0Controlsignaltomotort_m';     
         
xcp.parameters(53).symbol = 'Senior_Design_G4_P.Channel0Controlsignaltomotort_k';
xcp.parameters(53).size   =  1;       
xcp.parameters(53).dtname = 'real_T'; 
xcp.parameters(54).baseaddr = '&Senior_Design_G4_P.Channel0Controlsignaltomotort_k';     
         
xcp.parameters(54).symbol = 'Senior_Design_G4_P.Channel0Controlsignaltomotort_c';
xcp.parameters(54).size   =  1;       
xcp.parameters(54).dtname = 'real_T'; 
xcp.parameters(55).baseaddr = '&Senior_Design_G4_P.Channel0Controlsignaltomotort_c';     
         
xcp.parameters(55).symbol = 'Senior_Design_G4_P.Channel0Controlsignaltomotort_d';
xcp.parameters(55).size   =  1;       
xcp.parameters(55).dtname = 'real_T'; 
xcp.parameters(56).baseaddr = '&Senior_Design_G4_P.Channel0Controlsignaltomotort_d';     
         
xcp.parameters(56).symbol = 'Senior_Design_G4_P.Channel0Controlsignaltomotort_n';
xcp.parameters(56).size   =  1;       
xcp.parameters(56).dtname = 'real_T'; 
xcp.parameters(57).baseaddr = '&Senior_Design_G4_P.Channel0Controlsignaltomotort_n';     
         
xcp.parameters(57).symbol = 'Senior_Design_G4_P.Channel0Controlsignaltomotort_g';
xcp.parameters(57).size   =  1;       
xcp.parameters(57).dtname = 'real_T'; 
xcp.parameters(58).baseaddr = '&Senior_Design_G4_P.Channel0Controlsignaltomotort_g';     
         
xcp.parameters(58).symbol = 'Senior_Design_G4_P.Channel0Controlsignaltomotort_f';
xcp.parameters(58).size   =  1;       
xcp.parameters(58).dtname = 'real_T'; 
xcp.parameters(59).baseaddr = '&Senior_Design_G4_P.Channel0Controlsignaltomotort_f';     
         
xcp.parameters(59).symbol = 'Senior_Design_G4_P.Channel0Controlsignaltomotor_gv';
xcp.parameters(59).size   =  1;       
xcp.parameters(59).dtname = 'real_T'; 
xcp.parameters(60).baseaddr = '&Senior_Design_G4_P.Channel0Controlsignaltomotor_gv';     
         
xcp.parameters(60).symbol = 'Senior_Design_G4_P.Channel0Controlsignaltomotor_gp';
xcp.parameters(60).size   =  1;       
xcp.parameters(60).dtname = 'real_T'; 
xcp.parameters(61).baseaddr = '&Senior_Design_G4_P.Channel0Controlsignaltomotor_gp';     
         
xcp.parameters(61).symbol = 'Senior_Design_G4_P.Channel0ofEncoderInputs_P1';
xcp.parameters(61).size   =  1;       
xcp.parameters(61).dtname = 'real_T'; 
xcp.parameters(62).baseaddr = '&Senior_Design_G4_P.Channel0ofEncoderInputs_P1';     
         
xcp.parameters(62).symbol = 'Senior_Design_G4_P.Channel0ofEncoderInputs_P2';
xcp.parameters(62).size   =  1;       
xcp.parameters(62).dtname = 'real_T'; 
xcp.parameters(63).baseaddr = '&Senior_Design_G4_P.Channel0ofEncoderInputs_P2';     
         
xcp.parameters(63).symbol = 'Senior_Design_G4_P.Channel0ofEncoderInputs_P3';
xcp.parameters(63).size   =  1;       
xcp.parameters(63).dtname = 'real_T'; 
xcp.parameters(64).baseaddr = '&Senior_Design_G4_P.Channel0ofEncoderInputs_P3';     
         
xcp.parameters(64).symbol = 'Senior_Design_G4_P.Channel0ofEncoderInputs_P4';
xcp.parameters(64).size   =  1;       
xcp.parameters(64).dtname = 'real_T'; 
xcp.parameters(65).baseaddr = '&Senior_Design_G4_P.Channel0ofEncoderInputs_P4';     
         
xcp.parameters(65).symbol = 'Senior_Design_G4_P.Channel0ofEncoderInputs_P5';
xcp.parameters(65).size   =  1;       
xcp.parameters(65).dtname = 'real_T'; 
xcp.parameters(66).baseaddr = '&Senior_Design_G4_P.Channel0ofEncoderInputs_P5';     
         
xcp.parameters(66).symbol = 'Senior_Design_G4_P.Channel0ofEncoderInputs_P6';
xcp.parameters(66).size   =  1;       
xcp.parameters(66).dtname = 'real_T'; 
xcp.parameters(67).baseaddr = '&Senior_Design_G4_P.Channel0ofEncoderInputs_P6';     
         
xcp.parameters(67).symbol = 'Senior_Design_G4_P.Channel0ofEncoderInputs_P7';
xcp.parameters(67).size   =  1;       
xcp.parameters(67).dtname = 'real_T'; 
xcp.parameters(68).baseaddr = '&Senior_Design_G4_P.Channel0ofEncoderInputs_P7';     
         
xcp.parameters(68).symbol = 'Senior_Design_G4_P.Channel0ofEncoderInputs_P8';
xcp.parameters(68).size   =  1;       
xcp.parameters(68).dtname = 'real_T'; 
xcp.parameters(69).baseaddr = '&Senior_Design_G4_P.Channel0ofEncoderInputs_P8';     
         
xcp.parameters(69).symbol = 'Senior_Design_G4_P.Channel0ofEncoderInputs_P9';
xcp.parameters(69).size   =  1;       
xcp.parameters(69).dtname = 'real_T'; 
xcp.parameters(70).baseaddr = '&Senior_Design_G4_P.Channel0ofEncoderInputs_P9';     
         
xcp.parameters(70).symbol = 'Senior_Design_G4_P.Channel0ofEncoderInputs_P10';
xcp.parameters(70).size   =  1;       
xcp.parameters(70).dtname = 'real_T'; 
xcp.parameters(71).baseaddr = '&Senior_Design_G4_P.Channel0ofEncoderInputs_P10';     
         
xcp.parameters(71).symbol = 'Senior_Design_G4_P.Channel0ofEncoderInputs_P11';
xcp.parameters(71).size   =  1;       
xcp.parameters(71).dtname = 'real_T'; 
xcp.parameters(72).baseaddr = '&Senior_Design_G4_P.Channel0ofEncoderInputs_P11';     
         
xcp.parameters(72).symbol = 'Senior_Design_G4_P.Channel0ofEncoderInputs_P12';
xcp.parameters(72).size   =  1;       
xcp.parameters(72).dtname = 'real_T'; 
xcp.parameters(73).baseaddr = '&Senior_Design_G4_P.Channel0ofEncoderInputs_P12';     
         
xcp.parameters(73).symbol = 'Senior_Design_G4_P.BackemfKe1_Gain';
xcp.parameters(73).size   =  1;       
xcp.parameters(73).dtname = 'real_T'; 
xcp.parameters(74).baseaddr = '&Senior_Design_G4_P.BackemfKe1_Gain';     
         
xcp.parameters(74).symbol = 'Senior_Design_G4_P.Dampingb1_Gain';
xcp.parameters(74).size   =  1;       
xcp.parameters(74).dtname = 'real_T'; 
xcp.parameters(75).baseaddr = '&Senior_Design_G4_P.Dampingb1_Gain';     
         
xcp.parameters(75).symbol = 'Senior_Design_G4_P.GainKt2_Gain';
xcp.parameters(75).size   =  1;       
xcp.parameters(75).dtname = 'real_T'; 
xcp.parameters(76).baseaddr = '&Senior_Design_G4_P.GainKt2_Gain';     
         
xcp.parameters(76).symbol = 'Senior_Design_G4_P.GainKt3_Gain';
xcp.parameters(76).size   =  1;       
xcp.parameters(76).dtname = 'real_T'; 
xcp.parameters(77).baseaddr = '&Senior_Design_G4_P.GainKt3_Gain';     
         
xcp.parameters(77).symbol = 'Senior_Design_G4_P.Inductance_Gain';
xcp.parameters(77).size   =  1;       
xcp.parameters(77).dtname = 'real_T'; 
xcp.parameters(78).baseaddr = '&Senior_Design_G4_P.Inductance_Gain';     
         
xcp.parameters(78).symbol = 'Senior_Design_G4_P.ResistanceR1_Gain';
xcp.parameters(78).size   =  1;       
xcp.parameters(78).dtname = 'real_T'; 
xcp.parameters(79).baseaddr = '&Senior_Design_G4_P.ResistanceR1_Gain';     
         
xcp.parameters(79).symbol = 'Senior_Design_G4_P.Integrator1_IC_j';
xcp.parameters(79).size   =  1;       
xcp.parameters(79).dtname = 'real_T'; 
xcp.parameters(80).baseaddr = '&Senior_Design_G4_P.Integrator1_IC_j';     
         
xcp.parameters(80).symbol = 'Senior_Design_G4_P.Integrator5_IC';
xcp.parameters(80).size   =  1;       
xcp.parameters(80).dtname = 'real_T'; 
xcp.parameters(81).baseaddr = '&Senior_Design_G4_P.Integrator5_IC';     
         
xcp.parameters(81).symbol = 'Senior_Design_G4_P.Integrator6_IC';
xcp.parameters(81).size   =  1;       
xcp.parameters(81).dtname = 'real_T'; 
xcp.parameters(82).baseaddr = '&Senior_Design_G4_P.Integrator6_IC';     

function n = getNumParameters
n = 81;

function n = getNumSignals
n = 48;

function n = getNumEvents
n = 1;

function n = getNumModels
n = 1;

