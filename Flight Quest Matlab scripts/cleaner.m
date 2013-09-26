function cleaner(filename)
    listfile=dir([folder '/' folder '_FlightHistory_flighthistory_*.mat']);
    for nbfile=1:size(listfile,1)

    eval(['load ' folder '/' listfile(nbfile).name ';']);
    nbline=size(segarray{1},1); list(1:nbline)=0; cp=0; %#ok<USENS>

    for i=1:size(head,2)
         if strcmpi(head(i).er, 'flight_history_id'); id1=i; end
         if strcmpi(head(i).er, 'airline_code'); id2=i; end
         if strcmpi(head(i).er, 'airline_icao_code'); id3=i; end
         if strcmpi(head(i).er, 'flight_number'); id4=i; end
         if strcmpi(head(i).er, 'departure_airport_code'); id5=i; end
        if strcmpi(head(i).er, 'departure_airport_icao_code'); id6=i; end
        if strcmpi(head(i).er, 'arrival_airport_code'); id7=i; end
        if strcmpi(head(i).er, 'arrival_airport_icao_code'); id8=i; end
         if strcmpi(head(i).er, 'published_departure'); id9=i; end
         if strcmpi(head(i).er, 'published_arrival'); id10=i; end
         if strcmpi(head(i).er, 'scheduled_gate_departure'); id11=i; end
        if strcmpi(head(i).er, 'actual_gate_departure'); id12=i; end
        if strcmpi(head(i).er, 'scheduled_gate_arrival'); id13=i; end   
        if strcmpi(head(i).er, 'actual_gate_arrival'); id14=i; end
        if strcmpi(head(i).er, 'scheduled_runway_departure'); id15=i; end
        if strcmpi(head(i).er, 'actual_runway_departure'); id16=i; end
        if strcmpi(head(i).er, 'scheduled_runway_arrival'); id17=i; end
        if strcmpi(head(i).er, 'actual_runway_arrival'); id18=i; end
         if strcmpi(head(i).er, 'creator_code'); id19=i; end
         if strcmpi(head(i).er, 'scheduled_air_time'); id20=i; end
         if strcmpi(head(i).er, 'scheduled_block_time'); id21=i; end
    end
end