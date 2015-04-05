With Ada.Unchecked_Deallocation ; 

package body Struct is

	procedure Liberer is new Ada.Unchecked_Deallocation(Noeud,Arbre) ;

	procedure Inserer(Ptracine : in out Arbre ; Clef : Integer) is --Ptracine est en out au cas où c'est le pointeur null

		procedure Inserermem (Ptracine : in out Arbre ; Clef : Integer ; Mem : Arbre) is --Besoin de garder le père en mémoire pour le pointeur pere du noeud inséré

			procedure IncrementerComptePeres(PtSuppr : in Arbre) is --procédure incrémentant le compte de tous les noeuds pères du noeud pointé
				PtCour : Arbre := PtSuppr;
			begin
				while PtCour.all.Pere /= Null loop
					PtCour := PtCour.all.Pere;
					PtCour.all.Compte := PtCour.all.Compte + 1;
				end loop;
			end;
		begin
			if Ptracine = null then --on insère que dans ce cas, car tout noeud inséré sera forcément une feuille
				Ptracine := new noeud;
				Ptracine.all.Compte := 1;
				Ptracine.all.Fils(Gauche) := null;
				Ptracine.all.Fils(Droite) := null;
				Ptracine.all.C := Clef;
				Ptracine.all.Pere := Mem;
				IncrementerComptePeres(Ptracine);
			else
				if Clef<Ptracine.all.C then
					Inserermem(Ptracine.all.Fils(gauche),Clef, Ptracine);
				elsif Clef>Ptracine.all.C then
					Inserermem(Ptracine.all.Fils(droite),Clef, Ptracine);
				end if; --exclut le cas où on donne en argument une clef déjà présente, ainsi ce n'est pas une précondition
			end if;
		end;
	begin
		Inserermem(Ptracine,Clef,Ptracine);
	end;

	function Rechercher (Ptracine : in Arbre ; Clef : Integer) return Arbre is
		PtCour : Arbre := Ptracine ;
	begin
		while PtCour /= null and then Clef /= PtCour.all.C loop --on parcourt l'arbre depuis la racine, jusqu'à ce que l'on trouve le noeud cherché ou que l'on arrive à une feuille sans l'avoir trouvé
			if Clef < PtCour.all.C then
				PtCour := PtCour.all.Fils(Gauche); --structure des ABR
			else
				PtCour := PtCour.all.Fils(Droite);
			end if ;
		end loop;

			return PtCour;
	end;

	procedure Supprimer(Ptracine : in out Arbre; Clef : Integer) is -- Il manque un cas dans Suppr2
		PtDel : Arbre ;

		procedure Suppr(Ptracine : in out Arbre; PtSuppr : in out Arbre) is

			procedure DecrementerComptePeres(PtSuppr : in Arbre) is
				PtCour : Arbre := PtSuppr;
			begin
				while PtCour.all.Pere /= Null loop
					PtCour := PtCour.all.Pere;
					PtCour.all.Compte := PtCour.all.Compte - 1;
				end loop;
			end;

			procedure Suppr0(Ptracine : in out Arbre; PtSuppr : in out Arbre) is
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

			procedure Suppr1G(Ptracine : in out Arbre ; PtSuppr : in out Arbre) is
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

					Pt := PtSuppr.all.Fils(Gauche); --Ici, contrairement à Suppr1D, on ne libère pas le noeud supprimé, cela facilitera l'implémentation de la procédure
				        				--Suppr2 où l'on supprime un noeud possédant deux fils, car on a choisi de remplacer l'élément supprimé par
									--l'élement de clef directement inférieure, on utilise donc la procédure Suppr1G pour supprimer ce noeud, sans le perdre
									--en mémoire
					Pt.all.Pere := Mem;
				end if;
			end;

			procedure Suppr1D(Ptracine : in out Arbre ; PtSuppr : in out Arbre) is
				Pt, Mem : Arbre;
			begin
				DecrementerComptePeres(PtSuppr);
				if PtSuppr.all.Pere = null then --PtSuppr et Ptracine pointent ici vers la même case mémoire
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
					Liberer(Pt.all.Pere); --Cf commentaire Suppr1G
					Pt.all.Pere := Mem;
				end if;
			end;

			procedure Suppr2(Ptracine : in out Arbre ; PtSuppr : in Arbre) is

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
				Pere : Arbre := PtSuppr.all.Pere;


			begin
				DecrementerComptePeres(PtSuppr);
				Max := RechercheMax(PtSuppr);

				Suppr1G(Ptracine, Max); --Cf commentaire Suppr1G

				if Pere = null then --PtSuppr et Ptracine pointent ici vers la même case mémoire
					Liberer(Ptracine);
					Ptracine := Max;
				else
					if Pere.all.Fils(Droite) /= Null and then Pere.all.Fils(Droite) = PtSuppr then
						Pere.all.Fils(Droite) := Max;
					else
						Pere.all.Fils(Gauche) := Max;
					end if;

					Max.all.Pere := Pere;
				end if;

				Max.all.Fils(Droite) := PtD;
				Max.all.Fils(Gauche) := PtG;
				PtD.all.Pere := Max;
				PtG.all.Pere := Max;

			end;

		begin --Il faut considérer 4 cas différents (dont deux similaires)
			if PtSuppr.all.Fils(Gauche)=Null and PtSuppr.all.Fils(Droite)=Null then		 --Aucun fils
				Suppr0(Ptracine, PtSuppr);
			elsif PtSuppr.all.Fils(Gauche) /= Null and PtSuppr.all.Fils(Droite) = Null then  -- 1 fils gauche
				Suppr1G(Ptracine, PtSuppr);
			elsif PtSuppr.all.Fils(Gauche) = Null and PtSuppr.all.Fils(Droite) /= Null then  -- 1 fils droite
				Suppr1D(Ptracine, PtSuppr);
			elsif PtSuppr.all.Fils(Gauche) /= Null and PtSuppr.all.Fils(Droite) /= Null then -- 2 fils
				Suppr2(Ptracine, PtSuppr);
			end if ;
		end;

	begin
		PtDel := rechercher(Ptracine,Clef);

		if PtDel = Null then
			null; --Rien à faire si l'élement à supprimer n'existe déjà pas
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
				While Pt.all.Pere /= Null and not PereGaucheTrouve loop
					if Pt.all.Pere.all.Fils(Droite) /= Null and then Pt.all.Pere.all.Fils(Droite).all.C = Mem.all.C then
						PereGaucheTrouve := True;
					end if;
					Mem := Pt;
					Pt := Pt.all.Pere; 
				end loop;
			end if;

			return Pt;
		end;

		function GrandVoisin(Cible : Arbre) return Arbre is --Analogue à PetitVoisin, il suffit de permuter droite et gauche
			Pt, Mem : Arbre := Cible;
			PereDroiteTrouve : Boolean := False;
		begin
			if Cible.all.Fils(Droite) /= null then
				Pt := Cible.all.Fils(Droite);
				While Pt.all.Fils(Gauche) /= Null loop
					Pt := Pt.all.Fils(Gauche);
				end loop;
			else
				While Pt.all.Pere /= Null and not PereDroiteTrouve loop
					if Pt.all.Pere.all.Fils(Gauche) /= Null and then Pt.all.Pere.all.Fils(Gauche).all.C = Mem.all.C then
						PereDroiteTrouve := True;
					end if;
					Mem := Pt;
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

		function NbPetits(Cible : Arbre) return Natural is
			Compteur : Natural := 0;
			PtCour : Arbre := Cible;
		begin
			if Cible.all.Fils(Gauche) /= Null then
				Compteur := Compteur + Cible.all.Fils(Gauche).all.Compte;
			end if;

			While PtCour.all.Pere /= Null loop
				if PtCour.all.Pere.all.Fils(Droite) /= Null and then PtCour.all.Pere.all.Fils(Droite) = PtCour then
					Compteur := Compteur + PtCour.all.Pere.all.Compte - PtCour.all.Compte;
				end if;
				PtCour := PtCour.all.Pere;
			end loop;

			return Compteur;
		end;

		function NbGrands(Cible : Arbre) return Natural is 
			Compteur : Natural := 0;
			PtCour : Arbre := Cible;
		begin
			if Cible.all.Fils(Droite) /= Null then
				Compteur := Compteur + Cible.all.Fils(Droite).all.Compte;
			end if;

			While PtCour.all.Pere /= Null loop
				if PtCour.all.Pere.all.Fils(Gauche) /= Null and then PtCour.all.Pere.all.Fils(Gauche) = PtCour then
					Compteur := Compteur + PtCour.all.Pere.all.Compte - PtCour.all.Compte;
				end if;
				PtCour := PtCour.all.Pere;
			end loop;

			return Compteur;
		end;

	begin
		Nb_Petits := NbPetits(Cible);
		Nb_Grands := NbGrands(Cible);
	end;

end struct;
