classdef tagdefinition
    properties
        Name; Value; Node; Client;
    end
    methods(Static)
        function out = w2s(obj,value)
            writeValue(obj.Client,obj.Node,value);
            out = value;
        end
        function readvalue = rs(obj)
            readvalue = readValue(obj.Node);
        end
        function type = ct(obj)
            if isinteger(obj.Value) == true
                type = 'integer';
            elseif islogical(obj.Value) == true
                type = 'boolean';
            else
                type = 'notbooleanorinteger';
            end
        end
    end
end