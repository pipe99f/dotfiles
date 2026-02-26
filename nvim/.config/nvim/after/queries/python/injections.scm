; extends

; Doc-strings are RST
(function_definition
  (block
    (expression_statement
      (string
        (string_content) @injection.content
        (#set! injection.language "rst")))))

(expression_statement
  (call
    function: (attribute
      attribute: (identifier) @_method (#any-of? @_method
                                        "execute"
                                        "executemany"
                                        "mogrify"))
    arguments: (argument_list
      (string
        (string_content) @injection.content (#set! injection.language "sql")))))

(expression_statement
  (assignment
    left: (identifier) @_name (#eq? @_name "sql")
    right: (string
      (string_content) @injection.content (#set! injection.language "sql"))))

; Variables ending in "_json" and "_JSON"
(expression_statement
  (assignment
    left: (identifier) @_left
    (#match? @_left "(_json|_JSON)$")
    right: (string
      (string_content) @injection.content
      (#set! injection.language "json"))))

; This sql injection is working, the others are not
(
    [
        (string_content)
    ] @injection.content
    (#match? @injection.content "(SELECT|INSERT|UPDATE|DELETE).+(FROM|INTO|VALUES|SET).*(WHERE|GROUP BY)?")
    (#set! injection.language "sql")
)
