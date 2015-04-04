With Ada.Unchecked_Deallocation ; 

package body Struct is

	procedure Liberer is new Ada.Unchecked_Deallocation(Noeud,Arbre) ;

	procedure Inserer(a : in out Arbre ; e : Integer) is

		procedure Inserermem (a : in out Arbre ; e : Integer ; Mem : Arbre) is

			procedure IncrementerComptePeres(PtSuppr : in Arbre) is
				PtCour : Arbre := PtSuppr;
			begin
				while PtCour.all.Pere /= Null loop
					PtCour := PtCour.all.Pere;
					PtCour.all.Compte := PtCour.all.Compte + 1;
				end loop;
			end;
		begin
			if a = null then
				a := new noeud;
				a.all.Compte := 1;
				a.all.Fils(Gauche) := null;
				a.all.Fils(Droite) := null;
				a.all.C := e;
				a.all.Pere := Mem;
				IncrementerComptePeres(a);
			else
				if e<a.all.C then
					Inserermem(a.all.Fils(gauche),e, a);
				elsif e>a.all.C then
					Inserermem(a.all.Fils(droite),e, a);
				end if;
			end if;
		end;
	begin
		Inserermem(a,e,a);
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

	procedure Supprimer(Ptracine : in out Arbre; e : Integer) is -- Il manque un cas dans suppr2
		PtDel : Arbre ;

		procedure suppr(Ptracine : in out Arbre; PtSuppr : in out Arbre) is

			procedure DecrementerComptePeres(PtSuppr : in Arbre) is
				PtCour : Arbre := PtSuppr;
			begin
				while PtCour.all.Pere /= Null loop
					PtCour := PtCour.all.Pere;
					PtCour.all.Compte := PtCour.all.Compte - 1;
				end loop;
			end;

			procedure suppr0(Ptracine : in out Arbre; PtSuppr : in out Arbre) is
			begin
				DecrementerComptePeres(PtSuppr);
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
				DecrementerComptePeres(PtSuppr);
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
				DecrementerComptePeres(PtSuppr);
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
				DecrementerComptePeres(PtSuppr);
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

	procedure Noeuds_Voisins(Cible : Arbre ; Petit_Voisin, Grand_Voisin : out Arbre) is

		function PetitVoisin(Cible : Arbre) return Arbre is
			Pt, Mem : Arbre := Cible;
			PereGaucheTrouve : Boolean := False;
		begin
			if Cible.all.Fils(Gauche) /= null then
				Pt := Cible.all.Fils(Gauche);
				While Pt.all.Fils(Droite) /= Null loop
					Pt := Pt.all.Fils(Droite);
				end loop;
			else
				While Pt /= Null and not PereGaucheTrouve loop
					if Pt.all.Fils(Droite) /= Null and then Pt.all.Fils(Droite).all.C = Mem.all.C then
						PereGaucheTrouve := True;
					end if;
					Mem := Pt;
					Pt := Pt.all.Pere; 
				end loop;

				if not PereGaucheTrouve then
					Pt := Null;
				end if;
			end if;

			return Pt;
		end;

		function GrandVoisin(Cible : Arbre) return Arbre is
			Pt : Arbre := Cible;
			PereDroiteTrouve : Boolean := False;
		begin
			if Cible.all.Fils(Droite) /= null then
				Pt := Cible.all.Fils(Droite);
				While Pt.all.Fils(Gauche) /= Null loop
					Pt := Pt.all.Fils(Gauche);
				end loop;
			else
				While Pt /= Null and not PereDroiteTrouve loop
					if Pt.all.Pere.all.C > Pt.all.C then
						PereDroiteTrouve := True;
					end if;
					Pt := Pt.all.Pere;
				end loop;
			end if;

			return Pt;
		end;

	begin
		Petit_Voisin := PetitVoisin(Cible);
		Grand_Voisin := GrandVoisin(Cible);
	end;

	procedure Compte_Position(Cible : Arbre ; Nb_Petits, Nb_Grands : out Natural) is
	begin
		null;
	end;

end struct;
