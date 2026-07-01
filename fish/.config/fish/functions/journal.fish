function journal --description "Edit journal of the current day"
    set file "$JOURNAL_DIR/"(date '+%Y-%m-%d')".md"

    if test -f $file
        $EDITOR $file
        return
    end

    touch $file
    printf %s "# Tagesjournal – {{Datum}}

## Heute war ...
😊 Stimmung: _/10

### Drei gute Dinge
1.
2.
3.

### Das hat mich beschäftigt
-

### Das habe ich gelernt
-

### Darauf bin ich stolz
-

### Dankbar bin ich für
-

### Fokus für morgen
-

### Freie Gedanken" >$file

    $EDITOR $file
end
