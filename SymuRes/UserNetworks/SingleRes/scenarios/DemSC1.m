%% Scenario 1: one trip, demand peak
%--------------------------------------------------------------------------
% Fig. 4.a1.b1.c1 (section 2.3) of Mariotte & Leclercq (Part B 2019)

Assignment.Periods = [0 Simulation.Duration];
Assignment.PredefRoute = 1;
Assignment.Convergence = 0;

% Entry supply function
i = 1;
Reservoir(i).EntryfctParam = [Reservoir(i).MaxAcc Reservoir(i).CritAcc Reservoir(i).MaxProd ...
    0.8*Reservoir(i).CritAcc 1*Reservoir(i).CritAcc 1*Reservoir(i).MaxProd];

% Entry demand
%--------------------------------------------------------------------------
iroute = 1;
for od = 1:NumODmacro
    if ODmacro(od).NodeOriginID == 1 && ODmacro(od).NodeDestinationID == 3
        od0 = od;
    end
end
Route(iroute).ODmacroID = od0;
Route(iroute).ResPath = ODmacro(od0).PossibleRoute(1).ResPath;
Route(iroute).NodePath = ODmacro(od0).PossibleRoute(1).NodePath;
Route(iroute).TripLengths = ODmacro(od0).PossibleRoute(1).TripLengths;
j = 1;
Route(iroute).Demand0(j).Purpose = 'cartrip';
Td1 = 1000;
Td2 = 6000;
q0 = 0.3;
q1 = 1.3;
q2 = 0.3;
qinD = @(t_) q0*bumpfct(t_,Td1,Td2,q1/q0,q2/q0);
Route(iroute).Demand0(j).Time = [0 Td1:20:(Td2+20)]; % [s]
Route(iroute).Demand0(j).Data = [q0 qinD(Td1:20:Td2) q2]; % [veh/s]

% Exit supply
%--------------------------------------------------------------------------
i = 3;
MacroNode(i).Capacity.Time = 0; % [s]
MacroNode(i).Capacity.Data = 0.7; % [veh/s]


