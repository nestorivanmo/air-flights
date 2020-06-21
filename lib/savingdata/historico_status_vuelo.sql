set serveroutput on;

create or replace procedure sp_insert_into_historico(
  p_fecha in date, id_status_vuelo in number, p_id_vuelo in number ) is
v_query varchar2(4000);
begin
  v_query := 'insert into historico_status_vuelo( 
  id_historico_status_vuelo,fecha,id_status_vuelo,id_vuelo) values (
  historico_status_vuelo_seq.nextval,'
  ||':p_fecha,'
  ||':id_status_vuelo,'
  ||':p_id_vuelo)';
  execute immediate v_query using p_fecha,id_status_vuelo,p_id_vuelo;
end sp_insert_into_historico;
/ 
show errors;