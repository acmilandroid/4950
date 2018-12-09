%% move.m
% logic to control movement
% takes input of begin position and end position

function move(sim, start, stop)

    dcmotor = [260,515,780,1080,1385,1735,2085,2400];
    
    %retract claw and actuator
    sim.setparam(sim.getparamid('linear_act', 'Value'), 0);
    sim.setparam(sim.getparamid('gripper_on', 'Value'), 0);
    
    %move dc motor begin position
    %sim.setparam(sim.getparamid('position', 'Value'), start(1) * 245 + 275);
    sim.setparam(sim.getparamid('position', 'Value'), dcmotor(start(1)));
    
    %move stepper motor begin position
    sim.setparam(sim.getparamid('stepper_left_right', 'Value'), 1);
    sim.setparam(sim.getparamid('stepper_on_off', 'Value'), 1);
    pause((start(2)-1) * 1.71);
    sim.setparam(sim.getparamid('stepper_on_off', 'Value'), 0);
    
    %grab object
    sim.setparam(sim.getparamid('linear_act', 'Value'), 1);
    pause(9);
    sim.setparam(sim.getparamid('gripper_on', 'Value'), 1);
    sim.setparam(sim.getparamid('linear_act', 'Value'), 0);
    pause(8);
    
    %move dc motor end position
    %sim.setparam(sim.getparamid('position', 'Value'), stop(1) * 245 + 275);
    sim.setparam(sim.getparamid('position', 'Value'), dcmotor(stop(1)));
    
    %calculate steppor motor movement
    if stop(2) - start(2) < 0
        leftright = 0; %moves left
    else
        leftright = 1; %moves right
    end
    
    %get new waiting time for stepper motor
    waittime = stop(2) - start(2);
    if waittime < 0 %magnitude of time
        waittime = 0 - waittime;
    end
    waittime = waittime * 1.71;
    
    %move stepper motor end position
    sim.setparam(sim.getparamid('stepper_left_right', 'Value'),  leftright);
    sim.setparam(sim.getparamid('stepper_on_off', 'Value'), 1);
    pause(waittime);
    sim.setparam(sim.getparamid('stepper_on_off', 'Value'), 0);
    
    %place object
    sim.setparam(sim.getparamid('linear_act', 'Value'), 1);
    pause(9);
    sim.setparam(sim.getparamid('gripper_on', 'Value'), 0);
    sim.setparam(sim.getparamid('linear_act', 'Value'), 0);
    pause(3);
    
    %move to load cell
    sim.setparam(sim.getparamid('position', 'Value'), 0);
    sim.setparam(sim.getparamid('stepper_left_right', 'Value'), 0);
    sim.setparam(sim.getparamid('stepper_on_off', 'Value'), 1);
    pause((stop(2)-1) * 1.71);
    sim.setparam(sim.getparamid('stepper_on_off', 'Value'), 0);
    
    %hit load cell
    pause(4);
    sim.setparam(sim.getparamid('linear_act', 'Value'), 2);
    sim.setparam(sim.getparamid('gripper_on', 'Value'), 1);
    pause(4);
    sim.setparam(sim.getparamid('linear_act', 'Value'), 0);

end