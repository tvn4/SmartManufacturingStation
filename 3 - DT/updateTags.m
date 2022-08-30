function tag = updateTags(num_tags,node,client)
    for i = 1:num_tags
        tag(i) = tagdefinition;
        tag(i).Name = node.Children(1,i).Name;
        tag(i).Value = readValue(node.Children(1,i));
        tag(i).Node = node.Children(1,i);
        tag(i).Client = client;
    end
end