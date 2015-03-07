classdef model
    % MODEL - BN2 prediction
    %   Compute probability of 'Pd' given the evidences
    
    properties
        P_Pd;
        P_Xa;
        P_Xb_given_Pd_and_Xa;
        P_Xh_given_Pd_and_Xa;
        P_Xt_given_Pd_and_Xa;
    end
    
    methods
        %
        % Initializer
        %
        function obj = model( ...
            P_Pd, P_Xa, P_Xb_given_Pd_and_Xa, P_Xh_given_Pd_and_Xa, P_Xt_given_Pd_and_Xa)
        
            obj.P_Pd = P_Pd;
            obj.P_Xa = P_Xa;
            % Add total probabilities
            obj.P_Xb_given_Pd_and_Xa = [
                P_Xb_given_Pd_and_Xa(:,1:3) ones(2,1) ... 
                P_Xb_given_Pd_and_Xa(:,4:6) ones(2,1) ...
                P_Xb_given_Pd_and_Xa(:,7:9) ones(2,1)];
            obj.P_Xh_given_Pd_and_Xa = [
                P_Xh_given_Pd_and_Xa(:,1:3) ones(2,1) ...
                P_Xh_given_Pd_and_Xa(:,4:6) ones(2,1) ...
                P_Xh_given_Pd_and_Xa(:,7:9) ones(2,1)];
            obj.P_Xt_given_Pd_and_Xa = [
                P_Xt_given_Pd_and_Xa(:,1:3) ones(2,1) ...
                P_Xt_given_Pd_and_Xa(:,4:6) ones(2,1) ...
                P_Xt_given_Pd_and_Xa(:,7:9) ones(2,1)];
        end
        
        %
        % Compute P(pd|e)
        %
        function P = predict(obj, pd, e)
            p_pd_is_1 = obj.p_pd(1);
            p_e_given_pd_is_1 = obj.p_e_given_pd(1, e);
            
            p_pd_is_0 = obj.p_pd(0);
            p_e_given_pd_is_0 = obj.p_e_given_pd(0, e);
            
            P_normalized = [
              p_pd_is_1 * p_e_given_pd_is_1 
              p_pd_is_0 * p_e_given_pd_is_0
            ];
            P = P_normalized(obj.pd_row(pd)) / sum(P_normalized);
        end
    end
    
    %
    % private functions
    %
    methods(Access = private)
        %
        % Compute P(e|pd)
        %
        function P = p_e_given_pd(obj, pd, e)
            xa = e(4);
            % xa = 0 (represent xa is not given)
            if xa == 0
                xa = [1 2 3];
            end
            p = zeros(1, length(xa));
            % sum over all xa
            for i = 1:length(xa)
                p(i) = obj.P_Xa(xa) * ...
                    obj.p_x_given_pd_and_xa(e(1), pd, xa, obj.P_Xb_given_Pd_and_Xa) * ...
                    obj.p_x_given_pd_and_xa(e(2), pd, xa, obj.P_Xh_given_Pd_and_Xa) * ...
                    obj.p_x_given_pd_and_xa(e(3), pd, xa, obj.P_Xt_given_Pd_and_Xa);
            end
            P = sum(p);
        end
        
        %
        % Lookup P(x|pd,xa) probability from CPT
        %
        function P = p_x_given_pd_and_xa(obj, x, pd, xa, cpt)
            P = cpt(obj.pd_row(pd), obj.x_column(xa, x));
        end
        
        %
        % Lookup P(pd) from CPT
        %
        function P = p_pd(obj, pd)
            P = obj.P_Pd(obj.pd_row(pd));
        end
                
        %
        % Map Pd values {1 0} to row [1 2] in the CPT
        %
        function r = pd_row(~, pd)
            pds = [1 0];
            rows = [1 2];
            
            r = rows(pds == pd);
        end
        
        %
        % Map the values
        %   xa = {1, 2, 3} and
        %   x = {H, M, L , -} to 
        % column 1:12
        %
        function c = x_column(~, xa, x)
            xs = ['H' 'M' 'L' '-'];
            columns = [1 2 3 4] + (xa - 1) * 4;
            
            c = columns(xs == x);
        end
    end
end
