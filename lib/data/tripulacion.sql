declare
cursor cur_vuelo is
    select * from vuelo;
v_es_carga number;
v_es_comercial number;
begin
    for r in cur_vuelo loop
        select es_carga, es_comercial
        into v_es_carga, v_es_comercial
        from avion
        where id_avion = r.id_avion;
        if es_comercial == 1
    end loop;
end;
/
show errors;