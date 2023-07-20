*&---------------------------------------------------------------------*
*& Include zot_09_i_sports_top
*&---------------------------------------------------------------------*

DATA: lv_randint   LIKE qf00-ran_int,
      lv_control_a TYPE i VALUE 1,
      lv_control_b TYPE i VALUE 1,
      lv_control_c TYPE i VALUE 1,
      lv_control_d TYPE i VALUE 1.


TYPES: BEGIN OF gty_sports,
         id        TYPE c LENGTH 10,
         takim_adi TYPE  c LENGTH 15,
         ulke_adi  TYPE c LENGTH 5,
         torba     TYPE c LENGTH 1,
       END OF gty_sports.

DATA: gs_sports TYPE gty_sports,
      gt_sports TYPE TABLE OF gty_sports.

TYPES : BEGIN OF gty_grup,
          takim_ad TYPE c LENGTH 15,
        END OF gty_grup.

DATA: gt_agrup TYPE TABLE OF gty_grup,
      gt_bgrup TYPE TABLE OF gty_grup,
      gt_cgrup TYPE TABLE OF gty_grup,
      gt_dgrup TYPE TABLE OF gty_grup.

gt_sports = VALUE #( BASE gt_sports ( id = 1
                                      takim_adi = 'Liverpool'
                                      ulke_adi = 'EN'
                                      torba = 1
                                      )
                                      ( id = 2
                                      takim_adi = 'Bayern'
                                      ulke_adi = 'DE'
                                      torba = 1
                                      )
                                      ( id = 3
                                      takim_adi = 'Inter'
                                      ulke_adi = 'IT'
                                      torba = 1
                                      )
                                      ( id = 4
                                      takim_adi = 'PSG'
                                      ulke_adi = 'FR'
                                      torba = 1
                                       )
                                      ( id = 5
                                      takim_adi = 'ManC'
                                      ulke_adi = 'EN'
                                      torba = 2
                                      )
                                      ( id = 6
                                      takim_adi = 'PSV'
                                      ulke_adi = 'NE'
                                      torba = 2
                                       )
                                       ( id = 7
                                      takim_adi = 'Porto'
                                      ulke_adi = 'PO'
                                      torba = 2
                                       )
                                       ( id = 8
                                      takim_adi = 'Real Madrid'
                                      ulke_adi = 'ES'
                                      torba = 2
                                       )
                                       ( id = 9
                                      takim_adi = 'Dortmund'
                                      ulke_adi = 'DE'
                                      torba = 3
                                       )
                                       ( id = 10
                                      takim_adi = 'Galatasaray'
                                      ulke_adi = 'TR'
                                      torba = 3
                                       )
                                       ( id = 11
                                      takim_adi = 'Marsilya'
                                      ulke_adi = 'FR'
                                      torba = 3
                                       )
                                       ( id = 12
                                      takim_adi = 'Ajax'
                                      ulke_adi = 'NL'
                                      torba = 3
                                       )
                                       ( id = 13
                                      takim_adi = 'AEK'
                                      ulke_adi = 'GR'
                                      torba = 4
                                       )
                                       ( id = 14
                                      takim_adi = 'Roma'
                                      ulke_adi = 'IT'
                                      torba = 4
                                       )
                                       ( id = 15
                                      takim_adi = 'Steua B.'
                                      ulke_adi = 'RO'
                                      torba = 4
                                       )
                                       ( id = 16
                                      takim_adi = 'Atletico Madrid'
                                      ulke_adi = 'ES'
                                      torba = 4
                                       ) ).
