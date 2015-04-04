With Ada.Unchecked_Deallocation ; 

package body Struct is

	procedure Liberer is new Ada.Unchecked_Deallocation(Noeud,Arbre) ;

	procedure Inserer(a : in out Arbre ; e : Integer) is -- Compte et Pere ne sont pas gérés
	begin
		if a = null then
			a := new noeud;
			a.all.Compte := 1;
			a.all.Fils(Gauche) := null;
			a.all.Fils(Droite) := null;
			a.all.C := e;
		else
			if e<a.all.C then
				a.all.compte := a.all.compte + 1;
				Inserer(a.all.Fils(gauche),e);
			elsif e>a.all.C then
				a.all.compte := a.all.compte + 1;
				Inserer(a.all.Fils(droite),e);
			end if;
		end if;
	end;

	function Rechercher (a : in Arbre ; e : Integer) return Arbre is
		Pt : Arbre := a ;
	begin
		while Pt /= null and then e /= Pt.all.C loop
			if e < Pt.all.C then
				Pt := Pt.all.Fils(Gauche);
			else
				Pt := Pt.all.Fils(Droite);
			end if ;
		end loop;

		if Pt /= null then
			return Pt;
		else
			return null;
		end if;
	end;

	procedure Supprimer(Ptracine : in out Arbre; e : Integer) is -- Je me suis pas occupé des Compte
		PtDel : Arbre ;

		procedure suppr(Ptracine : in out Arbre; PtSuppr : in out Arbre) is

			procedure suppr0(Ptracine : in out Arbre; PtSuppr : in out Arbre) is
			begin
				if PtSuppr.all.Pere = null then
					Liberer(PtSuppr); --PtSuppr et Ptracine pointent ici vers la même case mémoire
				else
					if PtSuppr.all.Pere.all.C > PtSuppr.all.C then
						PtSuppr.all.Pere.all.Fils(Gauche) := null;
					else
						PtSuppr.all.Pere.all.Fils(Droite) := null;
					end if;
				end if;
			end;

			procedure suppr1G(Ptracine : in out Arbre ; PtSuppr : in out Arbre) is
				Pt, Mem : Arbre;
			begin
				if PtSuppr.all.Pere = null then --PtSuppr et Ptracine pointent ici vers la même case mémoire
					Ptracine := Ptracine.all.Fils(Gauche);
					Liberer(PtSuppr);
				else
					Mem := PtSuppr.all.Pere;

					if PtSuppr.all.Pere.all.C > PtSuppr.all.C then
						PtSuppr.all.Pere.all.Fils(Gauche) := PtSuppr.all.Fils(Gauche);
					else
						PtSuppr.all.Pere.all.Fils(Droite) := PtSuppr.all.Fils(Gauche);
					end if;

					Pt := PtSuppr.all.Fils(Gauche);
					Pt.all.Pere := Mem;
				end if;
			end;

			procedure suppr1D(Ptracine : in out Arbre ; PtSuppr : in out Arbre) is
				Pt, Mem : Arbre;
			begin
				if PtSuppr.all.Pere = null then
					Ptracine := Ptracine.all.Fils(Droite);
					Liberer(PtSuppr);
				else
					Mem := PtSuppr.all.Pere;

					if PtSuppr.all.Pere.all.C > PtSuppr.all.C then
						PtSuppr.all.Pere.all.Fils(Gauche) := PtSuppr.all.Fils(Gauche);
					else
						PtSuppr.all.Pere.all.Fils(Droite) := PtSuppr.all.Fils(Gauche);
					end if;

					Pt := PtSuppr.all.Fils(Droite);
					Liberer(Pt.all.Pere);
					Pt.all.Pere := Mem;
				end if;
			end;

			procedure suppr2(Ptracine : in out Arbre ; PtSuppr : in Arbre) is

				function RechercheMax (PtSuppr : in Arbre) return Arbre is
					PtMax : Arbre := PtSuppr;
				begin
					PtMax := PtMax.all.Fils(Gauche);
					While PtMax.all.Fils(Droite) /= Null loop
						PtMax := PtMax.all.Fils(Droite);
					end loop;

					return PtMax;
				end;

				PtG : Arbre := PtSuppr.all.Fils(Gauche);
				PtD : Arbre := PtSuppr.all.Fils(Droite);
				Max : Arbre ;
				

			begin
				Max := RechercheMax(PtSuppr);

				if PtSuppr.all.Pere = null then
					Suppr1G(Ptracine, Max);
					Liberer(Ptracine);
					Ptracine := Max ;
					Max.all.Fils(Droite) := PtD;
					Max.all.Fils(Gauche) := PtG;
					PtD.all.Pere := Max;
					PtG.all.Pere := Max;
				end if;
			end;

		begin
			if PtSuppr.all.Fils(Gauche)=Null and PtSuppr.all.Fils(Droite)=Null then --Pas de fils
				suppr0(Ptracine, PtSuppr);
			elsif PtSuppr.all.Fils(Gauche) /= Null and PtSuppr.all.Fils(Droite) = Null then -- 1 fils gauche
				suppr1G(Ptracine, PtSuppr);
			elsif PtSuppr.all.Fils(Gauche) = Null and PtSuppr.all.Fils(Droite) /= Null then -- 1 fils droite
				suppr1D(Ptracine, PtSuppr);
			elsif PtSuppr.all.Fils(Gauche) /= Null and PtSuppr.all.Fils(Droite) /= Null then -- 2 fils
				suppr2(Ptracine, PtSuppr);
			end if ;
		end;

	begin
		PtDel := rechercher(Ptracine,e);

		if PtDel = Null then
			null;
		else
			Suppr(Ptracine, PtDel);
		end if;
	end;

end struct;
