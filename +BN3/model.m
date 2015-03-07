classdef model
    % MODEL - BN3 prediction
    %   Compute probability of 'Pd' given the evidences
    
    properties
        P_Pd;
        P_Xb_given_Pd;
        P_Xh_given_Pd;
        P_Xt_given_Pd;
    end
    
    methods
        %
        % Initializer
        %
        function obj = model( ...
            P_Pd, P_Xb_given_Pd, P_Xh_given_Pd, P_Xt_given_Pd)
        
            obj.P_Pd = P_Pd;
            % Add total of probability as the last column
            obj.P_Xb_given_Pd = [P_Xb_given_Pd ones(2,1)];
            obj.P_Xh_given_Pd = [P_Xh_given_Pd ones(2,1)];
            obj.P_Xt_given_Pd = [P_Xt_given_Pd ones(2,1)];
        end
        
        %
        % Compute P(pd|e)
        %
        function P = predict(obj, pd, e)
            p_pd_is_1 = obj.p_pd(1);
            p_xb_given_pd_is_1 = obj.p_x_given_pd(e(1), 1, obj.P_Xb_given_Pd);
            p_xh_given_pd_is_1 = obj.p_x_given_pd(e(2), 1, obj.P_Xh_given_Pd);
            p_xt_given_pd_is_1 = obj.p_x_given_pd(e(3), 1, obj.P_Xt_given_Pd);
           
            p_pd_is_0 = obj.p_pd(0);
            p_xb_given_pd_is_0 = obj.p_x_given_pd(e(1), 0, obj.P_Xb_given_Pd);
            p_xh_given_pd_is_0 = obj.p_x_given_pd(e(2), 0, obj.P_Xh_given_Pd);
            p_xt_given_pd_is_0 = obj.p_x_given_pd(e(3), 0, obj.P_Xt_given_Pd);
            
            P_normalized = [ ...
              p_pd_is_1 * p_xb_given_pd_is_1 * p_xh_given_pd_is_1 * p_xt_given_pd_is_1 ...
              p_pd_is_0 * p_xb_given_pd_is_0 * p_xh_given_pd_is_0 * p_xt_given_pd_is_0
            ];
            P = P_normalized(obj.pd_row(pd)) / sum(P_normalized);
        end
    end
    
    %
    % private functions
    %
    methods(Access = private)
        %
        % Compute P(x|pd) probability from 1-D Gaussian
        %
        function P = p_x_given_pd(obj, x, pd, cpd)
            parameters = cpd(obj.pd_row(pd),:);
            if x ~= 0
                m = parameters(1);
                v = parameters(2);

                P = (1/(sqrt(2*pi*v))) * exp(-(1/(2*v))*(x-m)^2); 
            else
                P = parameters(3);
            end
        end
        
        %
        % 
        %
        
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
    end
end
