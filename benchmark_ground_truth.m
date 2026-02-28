%     y = [T_exwall_in   T_exwall_out   T_R   T_tube   T_C   T_H   T_A   T_B]';
%     u = [U_C   U_H   U_A   U_B]';
%     d = [To   Q_int   P_solar]';
        
function  ydot = benchmark_ground_truth(y,u,d)

    ydot = zeros(8,1);

    R_cond = 1 / A_exwall * ( 1 / h_exwall - 1 / h_in - 1 / h_out );
    ydot(1) = (-(h_in * A_exwall + 1 / R_cond) * y(1) + 1 / R_cond * y(2) + h_in * A_exwall * y(3)) / (1 / 2 * M_exwall * C_exwall);
    ydot(2) = (1 / R_cond * y(1) - (h_out * A_exwall + 1 / R_cond) * y(2) + h_out * A_exwall * d(1) + alpha_solar * tau_exwall * A_exwall * d(3)) / (1 / 2 * M_exwall * C_exwall);
    ydot(3) = (h_in * A_exwall * y(1) + - (h_in * A_exwall + u(3) * Cpa + h_heater * A_heater + U_inf * Cpa + A_roof * h_roof + A_floor * h_floor + 1 / R_win + 1 / R_door) * y(3) +...
        h_heater * A_heater * y(6) + u(3) * Cpa * y(7) + (U_inf * Cpa + A_roof * h_roof + A_win * h_win + A_door * h_door) * d(1) + A_floor * h_floor * T_floor + 1 * d(2) + alpha_solar * tau_win * A_win * d(3)) / C_R;
    ydot(4) = (-(h_w * A_coil_in + h_a * A_coil_out * phi_sur) * y(4) + h_w * A_coil_in * y(5) + h_a * A_coil_out * phi_sur * y(7)) / C_tube;
    ydot(5) = (h_w * A_coil_in * y(4) - (h_w * A_coil_in + u(1) * Cpw) * y(5) + u(1) * Cpw * y(8)) / C_C;
    ydot(6) = (h_heater * A_heater * y(3) - (h_heater * A_heater + u(2) * Cpw) * y(6) + u(2) * Cpw * y(8)) / C_H;
    ydot(7) = (h_a * A_coil_out * phi_sur * y(4) + u(3) * Cpa * (1 - r_o) * y(3) - (u(3) * Cpa + h_a * A_coil_out * phi_sur) * y(7) + u(3) * Cpa * r_o * d(1) + W_fan * f) / C_A;
    ydot(8) = (u(1) * Cpw * y(5) + u(2) * Cpw * y(6) - (u(1) * Cpw + u(2) * Cpw + UA_b * u(4)) * y(8) + UA_b * u(4) * T_set) / C_B;

end