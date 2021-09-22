# Translation

The following rules were applied to translate the reference specification to 
CUE. Where the reference occurs in a reference field definition, it is removed from the
documentation in the CUE definition.

| Aspect          | Reference                                                        | CUE                                                | Comments                                                      |
| --------------- | ---------------------------------------------------------------- | -------------------------------------------------- | ------------------------------------------------------------- |
| Optional fields | See excerpt below                                                | `<field>?: _`                                      |                                                               |
| Identifiers     | `<Word> <Word>* Object`                                          | `#<Word><Word>*`                                   | Title case phrases to CamelCase                               |
| Default values  | Default value is false                                           | `<field>: bool \| *false `                         |                                                               |
| String values   | This MUST be in the form of a URL.                               | `<field>: #url`                                    | Todo: actual url constraint not implemented, only identified. |
|                 | Valid values are `<list>`                                        | `<field>: or(<list>)`                              |                                                               |
|                 | Possible values are `<list>`                                     | `<field>: or(<list>)`                              | Todo: this may to over-constrained.                           |
|                 | CommonMark syntax MAY be used for rich text representation       | `<field>: string \| #richText`                     | All `description` fields                                      |
| Extension       | This object MAY be extended with Specification Extensions.       | `{ #SpecificationExtension }`                      | All except `#SecurityRequirement` and `#Reference`            |
| Map values      | `Map[string, <constraint>]`                                      | `[string]: <constraint>`                           | Todo: may be underconstrained in permitting empty maps.       |
|                 | The map MAY be empty.                                            | `{[string]: <constraint>} \| {}`                   | Todo: not sure if actually necessary.                         |
| Disjunctions    | Applies To                                                       | `{<key>: <value1>, ...} \| {<key>: <value2>, ...}` | Todo: incomplete                                              |
|                 | The `<ident1>` field and `<ident2> field are mutually exclusive. | Todo                                               | Todo                                                          |
### Optional fields

See the following [excerpt](https://swagger.io/specification/#schema) from the reference 
specification:

> ## Schema
>
> In the following description, if a field is not explicitly REQUIRED or 
> described with a MUST or SHALL, it can be considered OPTIONAL.