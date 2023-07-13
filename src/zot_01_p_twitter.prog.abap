*&---------------------------------------------------------------------*
*& Report zot_01_p_twitter
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_p_twitter.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_twt_id(3) TYPE n OBLIGATORY,
              p_twt(150)  TYPE c OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  PARAMETERS: tweet_at RADIOBUTTON GROUP g1,
              tweet_de RADIOBUTTON GROUP g1,
              tweet_si RADIOBUTTON GROUP g1,
              tweet_go RADIOBUTTON GROUP g1.
SELECTION-SCREEN END OF BLOCK b2.

START-OF-SELECTION.
  TYPES: BEGIN OF t_tweet_show,
           tweet_id(3) TYPE n,
           tweet(150)  TYPE c,
         END OF t_tweet_show.
  DATA: gs_tweet      TYPE zot_01_t_twitter,
        lt_tweet_show TYPE TABLE OF t_tweet_show.
  CASE 'X'.
    WHEN tweet_at.
      gs_tweet-tweet_id = p_twt_id.
      gs_tweet-tweet = p_twt.
      INSERT zot_01_t_twitter FROM gs_tweet.
      CLEAR gs_tweet.
      COMMIT WORK AND WAIT.
      IF sy-subrc = 0.
        WRITE :/ 'Success'.
      ELSE.
        WRITE :/ 'Error'.
      ENDIF.
    WHEN tweet_si.
*      gs_tweet-tweet_id = p_twt_id.
*      gs_tweet-tweet = p_twt.
*      DELETE zot_01_t_twitter FROM gs_tweet.
*      CLEAR gs_tweet.
      DELETE FROM zot_01_t_twitter
      WHERE tweet_id = p_twt_id OR tweet = p_twt.
      COMMIT WORK AND WAIT.
      IF sy-subrc = 0.
        WRITE :/ 'Success'.
      ELSE.
        WRITE :/ 'Error'.
      ENDIF.
    WHEN tweet_de.
      UPDATE zot_01_t_twitter SET tweet = p_twt
      WHERE tweet_id = p_twt_id.
      COMMIT WORK AND WAIT.
      IF sy-subrc = 0.
        WRITE :/ 'Success'.
      ELSE.
        WRITE :/ 'Error'.
      ENDIF.
    WHEN tweet_go.
      SELECT tweet_id, tweet
      FROM zot_01_t_twitter AS t1
      INTO TABLE @lt_tweet_show.
      COMMIT WORK AND WAIT.
      IF sy-subrc = 0.
        cl_demo_output=>display( lt_tweet_show ).
      ELSE.
        WRITE :/ 'Error'.
      ENDIF.
  ENDCASE.
