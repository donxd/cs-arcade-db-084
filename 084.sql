/*Please add ; after each select statement*/
CREATE PROCEDURE tictactoeTournament()
BEGIN
    SELECT
    ddd.name
    , ((ddd.won*2) + ddd.draw) points
    , ddd.played
    , ddd.won
    , ddd.draw
    , ddd.lost
    FROM 
    (
        SELECT
        dd.name
        , COUNT(dd.name) played
        , SUM(dd.type = 'winner') won
        , SUM(dd.type = 'draw') draw
        , SUM(dd.type = 'loser') lost
        FROM
        (
            SELECT 
            CASE WHEN d.winx THEN d.px WHEN d.wino THEN d.po END name
            , 'winner' type
            , 'c1' type2
            , d.tm
            FROM (
                SELECT 
                  name_naughts po 
                , name_crosses px
                , timestamp tm
                , CASE WHEN REGEXP_LIKE(board, '(^XXX[.XO]+$)|(^[.XO]{3}XXX[.XO]{3}$)|(^[.XO]{6}XXX$)|(^(X[.XO]{2}){3}$)|(^[.XO](X[.XO]{2}){2}X[.XO]$)|(^([.XO]{2}X){3}$)|(^(X[.XO]{3}){2}X$)|(^[.XO]{2}(X[.XO]){2}X[.XO]{2}$)') THEN TRUE ELSE FALSE
                END winx
                , CASE WHEN REGEXP_LIKE(board, '(^OOO[.XO]+$)|(^[.XO]{3}OOO[.XO]{3}$)|(^[.XO]{6}OOO$)|(^(O[.XO]{2}){3}$)|(^[.XO](O[.XO]{2}){2}O[.XO]$)|(^([.XO]{2}O){3}$)|(^(O[.XO]{3}){2}O$)|(^[.XO]{2}(O[.XO]){2}O[.XO]{2}$)') THEN TRUE ELSE FALSE
                END wino
                FROM results
            ) d
            WHERE d.winx OR d.wino
            UNION ALL 
        -- )
        -- (
            SELECT 
            CASE WHEN d.winx THEN d.po WHEN d.wino THEN d.px END name
            , 'loser' type
            , 'c2' type2
            , d.tm
            FROM (
                SELECT 
                  name_naughts po 
                , name_crosses px
                , timestamp tm
                , CASE WHEN REGEXP_LIKE(board, '(^XXX[.XO]+$)|(^[.XO]{3}XXX[.XO]{3}$)|(^[.XO]{6}XXX$)|(^(X[.XO]{2}){3}$)|(^[.XO](X[.XO]{2}){2}X[.XO]$)|(^([.XO]{2}X){3}$)|(^(X[.XO]{3}){2}X$)|(^[.XO]{2}(X[.XO]){2}X[.XO]{2}$)') THEN TRUE ELSE FALSE
                END winx
                , CASE WHEN REGEXP_LIKE(board, '(^OOO[.XO]+$)|(^[.XO]{3}OOO[.XO]{3}$)|(^[.XO]{6}OOO$)|(^(O[.XO]{2}){3}$)|(^[.XO](O[.XO]{2}){2}O[.XO]$)|(^([.XO]{2}O){3}$)|(^(O[.XO]{3}){2}O$)|(^[.XO]{2}(O[.XO]){2}O[.XO]{2}$)') THEN TRUE ELSE FALSE
                END wino
                FROM results
            ) d
            WHERE d.winx OR d.wino
            UNION ALL 
            SELECT 
            d.px name
            , 'draw' type
            , 'c3' type2
            , d.tm
            FROM (
                SELECT 
                  name_naughts po 
                , name_crosses px
                , timestamp tm
                , CASE WHEN REGEXP_LIKE(board, '(^XXX[.XO]+$)|(^[.XO]{3}XXX[.XO]{3}$)|(^[.XO]{6}XXX$)|(^(X[.XO]{2}){3}$)|(^[.XO](X[.XO]{2}){2}X[.XO]$)|(^([.XO]{2}X){3}$)|(^(X[.XO]{3}){2}X$)|(^[.XO]{2}(X[.XO]){2}X[.XO]{2}$)') THEN TRUE ELSE FALSE
                END winx
                , CASE WHEN REGEXP_LIKE(board, '(^OOO[.XO]+$)|(^[.XO]{3}OOO[.XO]{3}$)|(^[.XO]{6}OOO$)|(^(O[.XO]{2}){3}$)|(^[.XO](O[.XO]{2}){2}O[.XO]$)|(^([.XO]{2}O){3}$)|(^(O[.XO]{3}){2}O$)|(^[.XO]{2}(O[.XO]){2}O[.XO]{2}$)') THEN TRUE ELSE FALSE
                END wino
                FROM results
            ) d
            WHERE !d.winx AND !d.wino
            UNION ALL 
            SELECT 
            d.po name
            , 'draw' type
            , 'c4' type2
            , d.tm
            FROM (
                SELECT 
                  name_naughts po 
                , name_crosses px
                , timestamp tm
                , CASE WHEN REGEXP_LIKE(board, '(^XXX[.XO]+$)|(^[.XO]{3}XXX[.XO]{3}$)|(^[.XO]{6}XXX$)|(^(X[.XO]{2}){3}$)|(^[.XO](X[.XO]{2}){2}X[.XO]$)|(^([.XO]{2}X){3}$)|(^(X[.XO]{3}){2}X$)|(^[.XO]{2}(X[.XO]){2}X[.XO]{2}$)') THEN TRUE ELSE FALSE
                END winx
                , CASE WHEN REGEXP_LIKE(board, '(^OOO[.XO]+$)|(^[.XO]{3}OOO[.XO]{3}$)|(^[.XO]{6}OOO$)|(^(O[.XO]{2}){3}$)|(^[.XO](O[.XO]{2}){2}O[.XO]$)|(^([.XO]{2}O){3}$)|(^(O[.XO]{3}){2}O$)|(^[.XO]{2}(O[.XO]){2}O[.XO]{2}$)') THEN TRUE ELSE FALSE
                END wino
                FROM results
            ) d
            WHERE !d.winx AND !d.wino
        ) dd
        GROUP BY dd.name
    ) ddd
    ORDER BY points DESC, played ASC, won DESC, name ASC
    ;
END