
%% initialize keyboard
global key
InitKeyboard();

while 1
    % get distance from sensor
    distance = brick.UltrasonicDist(3);
    color = brick.ColorCode(4);
    % Moves as keys are pressed
    switch key
        case 'uparrow'
            brick.MoveMotor('A', -30);
            brick.MoveMotor('D', -30);
        case 'downarrow'
            brick.MoveMotor('A', 30);
            brick.MoveMotor('D', 30);
        case 'leftarrow'
            brick.MoveMotor('A', -15);
            brick.MoveMotor('D', 15);
        case 'rightarrow'
            brick.MoveMotor('D', -15);
            brick.MoveMotor('A', 15);
        case '1'
            brick.MoveMotor('C', 2.5);
        case '2'
            brick.MoveMotor('C', -2.5);
        case 'q'
            break;
        case 0
            % Stops at red
            if color == 5
                disp("red");
                brick.StopMotor('A');
                brick.StopMotor('D');
                pause(3);
                brick.MoveMotor('A', -50);
                brick.MoveMotor('D', -50);
                pause(.5);
            % Allows keyboard control at green or blue
            elseif color == 3 || color == 2
                disp("green or blue");
                brick.StopMotor('A');
                brick.StopMotor('D');
            % Turns left when bumber sensor is hit
            elseif brick.TouchPressed(2) == 1
                brick.MoveMotor('D', 30);
                brick.MoveMotor('A', 30);
                pause(.5);
                brick.StopMotor('D');
                brick.StopMotor('A');
                brick.MoveMotor('D', 25);
                brick.MoveMotor('A', -25);
                pause(.5);
                brick.StopMotor('A');
                brick.StopMotor('D');
            % Turns right if the robot is greater than distance 30 from
            % wall, detected by ultrasonic sensor
            elseif distance > 30
                disp("distance greater than 30");
                % turn right
                brick.MoveMotor('D', -25);
                brick.MoveMotor('A', 25);
                pause(0.4);
                brick.StopMotor('A');
                brick.StopMotor('D');
                pause(0.1);
                brick.MoveMotor('A', -30);
                brick.MoveMotor('D', -30);
                pause(0.6);
            % Moves forward
            else
                brick.MoveMotor('A', -30);
                brick.MoveMotor('D', -30);
            end
    end
    pause(0.05);
end

%close keyboard
CloseKeyboard();