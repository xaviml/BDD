CREATE OR REPLACE FUNCTION guanyadorPais(paisEntrada text) RETURNS TABLE(dni text,nom text,partidesGuanyades bigint) AS $$
	DECLARE

	BEGIN
		RETURN QUERY(
		SELECT pe.dni,pe.nom,count(p.victoria) as partidesGuanyades 
		from partida p inner join jugador j on (p.victoria = j.persona) 
		inner join persona pe on (pe.dni = j.persona) 
		inner join pais pa on (pe.pais = pa.nom)
		WHERE pa.nom = paisEntrada 
		group by pa.nom , pe.dni,pe.nom
		order by partidesGuanyades DESC 
		limit 1);
			
	END;
$$LANGUAGE plpgsql;