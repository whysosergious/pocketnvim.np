




# autocomplete for sqeel column types
export def column-types [] {
    [
        "INTEGER",
        "REAL",
        "TEXT",
        "BLOB",
        "NUMERIC",
        "BOOLEAN",
        "DATE",
        "DATETIME",
        "VARCHAR(N)",
        "CHAR(N)",
        "DOUBLE",
        "FLOAT",
        "INT",
        "TINYINT",
        "SMALLINT",
        "MEDIUMINT",
        "BIGINT",
        "UNSIGNED BIG INT",
        "INT2",
        "INT8",
        "CLOB"
    ]
}

# Autocomplete for column properties
export def column-properties [] {
    [
      "PRIMARY KEY",
      "AUTOINCREMENT",
      "NOT NULL",
      "UNIQUE",
      "CHECK",
      "COLLATE",
      "FOREIGN KEY"
    ]
}


export def date_now_iso [] {
    date now | format date "%Y-%m-%dT%H:%M:%S%.3f%:z"
}

# create table with columns
export def "sqeel create" [table_name: string, columns: list<record<name: string, type: string>> --save(-s) = true] {
    let columns_def = $columns | each { |col| $"($col.name) ($col.type)" } | str join ", "
    let sql = $"CREATE TABLE IF NOT EXISTS ($table_name) \(($columns_def)\);"

    stor open | query db $sql

    if $save == true {
        sqeel save
    }

    return true
}

# insert item into table (shorthand, only content is non-default)
export def "sqeel insert" [table_name: string, content: string = "", --json(-j): string = "", --save(-s) = true] {
    let date_now = date_now_iso
    
  let table = (if $json == "" { $'{content: "($content)"}' } else { $json }) 
    | from json 
    | insert created $date_now 
    | insert modified $date_now

    let sql = $"INSERT INTO ($table_name) \(($table | columns | str join ', ')\) VALUES \(($table | values | each {|it| if ($it | describe) == string { $"'($it)'" } else { $it } } | str join ', ')\);"
    
    stor open | query db $sql

    if $save == true {
        sqeel save
    }

    sqeel select $table_name -l 1  
}

# insert item into table (generici & using the record syntax)
export def "sqeel insert-columns" [table_name: string, columns: list<record<name: string, value: string>>, --save(-s) = true] {
    let date_now = date_now_iso
    let columns_def = $columns | each { |col| $col.name } | str join ", "
    let values = $columns | each { |col| $"'($col.value)'" } | str join ", "
    let sql = $"INSERT INTO ($table_name) \(($columns_def)\) VALUES \(($values)\);"

    stor open | query db $sql

    if $save == true {
        sqeel save
    }
}

# all-round selection cmd 
export def "sqeel select" [table_name: string, --columns(-c): string = "*", --where(-w): string = "", --orderby(-o): string = "modified DESC", --limit(-l): int = 0, --no-default-filters(-a)] {
    let sql = $"SELECT ($columns) FROM ($table_name) (if $no_default_filters == false { 'WHERE is_deleted = false' }) (if $where != '' { $'and ($where)' }) ORDER BY ($orderby) (if $limit != 0 { $'LIMIT ($limit)' });"

    stor open | query db $sql
}



# update item in table
export def "sqeel update" [table_name: string, id: string, content: string = "", --json(-j): string = "", --save(-s) = true] {
    if ($content == "" and $json == "") {
        return "no columns were provided to update"
    }

    let date_now = date_now_iso
    let table = (if $json == "" { $'{content: "($content)"}' } else { $json }) 
    | from json 
    | insert modified $date_now

    let sql = $"UPDATE ($table_name) SET ($table | columns | each {|c| $'($c) = ($table | get $c | do {if ($in | describe) == string { $"'($in)'" } else { $in }} )' } | str join ', ') WHERE id = ($id);"

    stor open | query db $sql

    if $save == true {
        sqeel save
    }

    sqeel select $table_name -w $"id = ($id)"
}

# soft delete entry 
export def "sqeel delete" [table_name: string, id: string, --save(-s) = true] {

  sqeel update $table_name $id -j '{is_deleted: true}'
  
  return true
}

# hard delete item from table
export def "sqeel hard-delete" [table_name: string, id: string, --save(-s) = true] {
    let sql = $"DELETE FROM ($table_name) WHERE id = ($id);"
    stor open | query db $sql

    if $save == true {
        sqeel save
    }

    return true
}

const default_dbname = "sqeel.db"
export def get_db_path [] {
  if ('shelly.toml' | path exists) {
    let sqeel_config = open shelly.toml | select sqeel | flatten

    let dir = ($sqeel_config | get dir | to text)
    let name = ($sqeel_config | get filename | to text)
    let path = [$dir, $name] | str join ''

    if ($dir != [] and ($dir | path exists) == false) {
      mkdir $dir   
    } 

    return $path
  }

  return $default_dbname
}

# opens/creates a sqeel db file and loads ito memory
export def "sqeel open" [path: string = ""] {

  let path = if $path == "" {
    get_db_path
  } else {
    $path
  }

  if ($path | path exists) == true  {
    stor import -f $path
  } else {
    sqeel create-default-db $path
  }
   
}

# saves the in memory db to file
export def --env "sqeel save" [path: string = ""] {

  let path = if $path == "" {
    get_db_path
  } else {
    $path
  }

  if ($path | path exists) == true  {
     rm $path 
  }
  stor export -f $path
}

export def --env "sqeel create-default-db" [path?: string, dir?: string, name?: string] {
    stor open;

    let defaults = [
      {name: "id", type: "INTEGER PRIMARY KEY AUTOINCREMENT"},
      {name: "profile", type: "TEXT FORIEGN KEY REFERENCES profiles(id) DEFAULT '__SHELLY__'"},
      {name: "created", type: "TEXT"},
      {name: "modified", type: "TEXT"},
      {name: "is_deleted", type: "BOOLEAN DEFAULT FALSE"}
      #  ↓⇩ↆ added individually bc of the default value ↆ↓⇩
      # {name: "shtore_type", type: "TEXT DEFAULT ($table_name)"} 
    ]

    let profiles = [
      {name: "id", type: "TEXT PRIMARY KEY UNIQUE"},
      {name: "name", type: "TEXT"},
      {name: "created", type: "TEXT"},
      {name: "modified", type: "TEXT"},
      {name: "is_deleted", type: "BOOLEAN DEFAULT FALSE"},
      {name: "shtore_type", type: "TEXT DEFAULT 'profiles'"}

    ]

    let effect_patterns = [
      ...$defaults, 
      {name: "content", type: "TEXT"},
      {name: "shtore_type", type: "TEXT DEFAULT 'effect_patterns'"}
    ]

    let api_patterns = [
      ...$defaults, 
      {name: "content", type: "TEXT"},
      {name: "shtore_type", type: "TEXT DEFAULT 'api_patterns'"}
    ]

    let keymaps = [
      ...$defaults, 
      {name: "content", type: "TEXT"},
      {name: "shtore_type", type: "TEXT DEFAULT 'keymaps'"}
    ]

    let clipboard = [
      ...$defaults,
      {name: "content", type: "TEXT"},
      {name: "shtore_type", type: "TEXT DEFAULT 'clipboard'"}
    ]

    let blocks = [
      ...$defaults,
      {name: "content", type: "TEXT"},
      {name: "shtore_type", type: "TEXT DEFAULT 'blocks'"}
    ]
    
    sqeel create "profiles" $profiles -s false
    sqeel insert profiles -j '{id:"__SHELLY__",name:"shelly"}' -s false

    sqeel create "effect_patterns" $clipboard -s false
    sqeel create "api_patterns" $clipboard -s false
    sqeel create "clipboard" $clipboard -s false
    sqeel create "keymaps" $keymaps -s false
    sqeel create "blocks" $blocks -s false

    sqeel save $path
}

########################
# 
### list of subcommands
#
########################
#
# sqeel create
# sqeel insert
# sqeel insert_columns
# sqeel select
# sqeel select-last
# sqeel update
# sqeel delete
# sqeel hard_delete
#
# sqeel open 
# - reads shelly.toml in cwd and looks for the [sqeel] configuration (mainly for path & filename)
# - if neither is exist, looks for .db files in cwd .. opens first found
# - if no .db files found, creates a new db file named sqeel.db and inits defaults
#
# sqeel save
# sqeel create-default-db
#
# base command for sqeel
export def sqeel [] {
    help
}
