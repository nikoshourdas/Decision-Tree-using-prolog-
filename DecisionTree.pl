% Anaprastash dedomenwn

%  τιμές(ΝαιΌχι_ΕργΤιμές,[ΒΑΟ, Οξείδωση, ΔΟΑ_ΣΟΑ, [ΘολόΝερό, ΧρώμαΝερού]])

values(YesNo_LabValues, [BOD,Oxidability,DOC_TOC,[Cloudy,Colour]]).

/*

Values = values(yes,[6,2,15,[Cloudy,Colour]]).
Values = values(yes,[BOD,12,5,[Cloudy,Colour]]).
Values = values(yes,[BOD,15,DOC_TOC,[Cloudy,Colour]]).
Values = values(no,[BOD,Oxidability,DOC_TOC,[yes,grey]]).
Values = values(no,[BOD,Oxidability,DOC_TOC,[no,tea]]).
Values = values(no,[BOD,Oxidability,DOC_TOC,[no,no]]).

*/
% stoxoi

%


omp(Results) :-
    write('Yparxoun ergasthriakes times (yes/no)?'),nl,
    read(YesNo),
    % anagnorish dedomenwn
    (
    omp_labValues(YesNo,[BOD,Oxid,DOC_TOC]); omp_noLabValues(YesNo,omp_noLabValues)
    ),
    % euresh apotelesmatwn
    bagof(Answer,
          rule(values(YesNo,[BOD,Oxid,DOC_TOC,NoLabValues]),Answer),Results).


omp_labValues(yes, LabValues) :-
    nl, write('Υπάρχουν εργαστηριακές τιμές για ΒΑΟ/BOD (yes/no);'), nl,
    read(BOD_YesNo),
    omp_BOD(BOD_YesNo, BOD_labValue),nl,
    write('Υπάρχουν εργ/κές τιμές για την οξείδωση/oxidability (yes/no);'),
    nl, read(Oxid_YesNo),
    omp_oxidability(Oxid_YesNo, Oxid_labValue),nl,
    write('Υπάρχουν εργαστ/κές τιμές για ΔΟΑ-ΣΟΑ /DOC-TOC(yes/no);'), nl,
    read(DOC_TOC_YesNo),
    omp_DOC_TOC(DOC_TOC_YesNo, DOC_TOC_labValue),
    LabValues = [BOD_labValue,Oxid_labValue, DOC_TOC_labValue].


% Ανάγνωση εργαστηριακών δεδομένων, BOD.

omp_BOD(no, BOD_labValue). % ή omp_BOD(no, no).

omp_BOD(yes, BOD_labValue) :-
	nl, write('Δώσε τις εργαστηριακές τιμές για ΒΑΟ/BOD.'), nl,
	read(BOD_labValue).

% Ανάγνωση εργαστηριακών δεδομένων, Oxidability.

omp_oxidability(no,Oxid_labValue). % ή omp_oxidability(no,no).

omp_oxidability(yes, Oxid_labValue) :- nl,
	write('Δώσε τις εργαστηριακές τιμές για την Οξείδωση/oxidability.'),
	nl, read(Oxid_labValue).


% Ανάγνωση εργαστηριακών δεδομένων, DOC-TOC.

omp_DOC_TOC(no,DOC_TOC_labValue). % ή omp_DOC_TOC( no, no).

omp_DOC_TOC(yes, DOC_TOC_labValue) :-
	nl, write('Δώσε τις εργαστηριακές τιμές για ΔΟΑ-ΣΟΑ /DOC-TOC.'),
	nl, read(DOC_TOC_labValue).

% Ανάγνωση δεδομένων μη εργαστηριακών.

omp_noLabValues(no, NoLabValues) :-
  	nl, write('Είναι το νερό θολό (yes/no);'),nl,
  	read(CloudyWater),
  	( ( CloudyWater = yes, nl,
  	write('Δώσε το χρώμα του νερού: γκρί ή καφέ (grey/brown)'),
  	nl, read(WaterColour),
  	member(WaterColour, [grey, brown])
  	);

    % Ανάγνωση δεδομένων μη εργαστηριακών.
    ( CloudyWater = no, nl, write('Έχει το νερό χρώμα (yes/no);'), nl,
    read(Has_water_colour),
    ( (Has_water_colour = no,WaterColour =no);
    ( Has_water_colour = yes,nl,
    write('Δώσε το χρώμα του νερού: καφέ ή τσαγιού (brown/tea).'),nl,
    read(WaterColour),
    member(WaterColour, [brown, tea])
    ) ) ) ),
    NoLabValues = [CloudyWater, WaterColour].


%Η αναπαράσταση σε Prolog της Βάσης Γνώσης του περιβαλλοντικού ΣΓ.
  rule(values(yes, [BOD, Oxidability,DOC_TOC,[Cloudy,Colour]]),Answer):-
    number(BOD), BOD =< 5,
    Answer= 'ΒΑΟ(BOD): Δεν υπάρχει πρόβλημα με ΜΟΥ.'.

  rule(values(yes, [BOD, Oxidability,DOC_TOC,[Cloudy,Colour]]),Answer):-
    number(BOD), BOD >5, BOD =<7,
    Answer='ΒΑΟ(BOD): Μέτριο πρόβλημα με ΜΟΥ.'.

  rule(values(yes, [BOD, Oxidability,DOC_TOC,[Cloudy,Colour]]),Answer):-
    number(BOD), BOD >5, BOD =< 15,
    Answer='ΒΑΟ(BOD): Έντονο πρόβλημα ΜΟΥ.'.

  rule(values(yes, [BOD, Oxidability,DOC_TOC,[Cloudy,Colour]]),Answer):-
    number(BOD),BOD >15,
    Answer= 'ΒΑΟ(BOD): Πολύ Έντονο πρόβλημα ΜΟΥ.'.

  rule(values(yes, [BOD, Oxidability,DOC_TOC,[Cloudy,Colour]]),Answer):-
    number(Oxidability), Oxidability =< 3,
    Answer='Οξείδωση (Oxidability): Έντονο πρόβλημα ΜΟΥ.'.

  rule(values(yes, [BOD, Oxidability,DOC_TOC,[Cloudy,Colour]]),Answer):-
    number(Oxidability), Oxidability >3,
    Oxidability =<7,
    Answer='Οξείδωση (Oxidability): Μέτριο πρόβλημα με ΜΟΥ.'.

  rule(values(yes, [BOD, Oxidability,DOC_TOC,[Cloudy,Colour]]),Answer):-
    number(Oxidability),Oxidability >7,
    Answer='Οξείδωση (Oxidability): Δεν υπάρχει πρόβλημα με ΜΟΥ.'.


  rule(values(yes, [BOD, Oxidability,DOC_TOC,[Cloudy,Colour]]),Answer):-
    number(DOC_TOC), DOC_TOC =<5,
    Answer= 'ΔΟΑ-ΣΟΑ (DOC-TOC): Δεν υπάρχει πρόβλημα με ΜΟΥ.'.

  rule(values(yes, [BOD, Oxidability,DOC_TOC,[Cloudy,Colour]]),Answer):-
    number(DOC_TOC), DOC_TOC > 5, DOC_TOC=<7,
    Answer= 'ΔΟΑ-ΣΟΑ (DOC-TOC): Μέτριο πρόβλημα ΜΟΥ.'.

  rule(values(yes, [BOD, Oxidability,DOC_TOC,[Cloudy,Colour]]),Answer):-
    number(DOC_TOC),DOC_TOC >7, DOC_TOC=<12,
    Answer='ΔΟΑ-ΣΟΑ (DOC-TOC): Έντονο πρόβλημα ΜΟΥ.'.

  rule(values(yes, [BOD, Oxidability,DOC_TOC,[Cloudy,Colour]]),Answer):-
    number(DOC_TOC), DOC_TOC>12,
    Answer='ΔΟΑ-ΣΟΑ (DOC-TOC): Πολύ Έντονο πρόβλημα ΜΟΥ.'.

  rule(values(no, [BOD, Oxidability, DOC_TOC,[Cloudy,Colour]]),Answer):-
    Cloudy=yes,Colour=grey,
    Answer='Θολό νερό με χρώμα νερού γκρι: Πολύ Έντονο πρόβλημα ΜΟΥ.'.

  rule(values(no, [BOD, Oxidability, DOC_TOC,[Cloudy,Colour]]),Answer):-
    Cloudy=yes,Colour=brown,
    Answer='Θολό νερό με χρώμα νερού καφέ: Δεν υπάρχει πρόβλημα με ΜΟΥ.'.

  rule(values(no, [BOD, Oxidability, DOC_TOC,[Cloudy,Colour]]),Answer):-
    Cloudy=no,Colour=brown,
    Answer='Όχι Θολό νερό με χρώμα νερού καφέ: Δεν υπάρχει πρόβλημα με ΜΟΥ.'.

  rule(values(no, [BOD, Oxidability, DOC_TOC,[Cloudy,Colour]]),Answer):-
    Cloudy=no,Colour=tea,
    Answer='Όχι Θολό νερό με χρώμα νερού τσαγιού: Δεν υπάρχει πρόβλημα με ΜΟΥ.'.

  rule(values(no, [BOD, Oxidability, DOC_TOC,[Cloudy,Colour]]),Answer):-
    Cloudy=no,Colour=no,
    Answer='Όχι Θολό νερό και χωρίς χρώμα: Δεν υπάρχει πρόβλημα με ΜΟΥ.'.
