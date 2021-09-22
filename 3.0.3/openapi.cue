// https://swagger.io/specification/

package openapi

#url:          string
#emailAddress: string
#richText:     string

// This is the root document object of the OpenAPI document.
// https://swagger.io/specification/#openapi-object.
#OpenAPI: {
	// This string MUST be the semantic version number of the OpenAPI Specification version that the OpenAPI document uses.
	// The openapi field SHOULD be used by tooling specifications and clients to interpret the OpenAPI document.
	// This is not related to the API info.version string.
	openapi: string
	// Provides metadata about the API.
	// The metadata MAY be used by tooling as required.
	info: #Info
	// An array of Server Objects, which provide connectivity information to a target server.
	// If the servers property is not provided, or is an empty array,
	// the default value would be a Server Object with a url value of /.
	servers?: [...#Server] | *[...#serverDefault]
	// The available paths and operations for the API.
	paths: #Paths
	// An element to hold various schemas for the specification.
	component?: #Components
	// A declaration of which security mechanisms can be used across the API.
	// The list of values includes alternative security requirement objects that can be used.
	// Only one of the security requirement objects need to be satisfied to authorize a request.
	// Individual operations can override this definition.
	// To make security optional, an empty security requirement ({}) can be included in the array.
	security?: [...{#SecurityRequirement | {}}]
	// A list of tags used by the specification with additional metadata.
	// The order of the tags can be used to reflect on their order by the parsing tools.
	// Not all tags that are used by the Operation Object must be declared.
	// The tags that are not declared MAY be organized randomly or based on the tools' logic.
	tags?: [...#Tag]
	// Each tag name in the list MUST be unique.
	_tag_names: {}
	// Additional external documentation.
	externalDocs?: {}
	#SpecificationExtension
}

// https://swagger.io/specification/#info-object.
#Info: {
	// The title of the API.
	title: string
	// A short description of the API.
	description?: string | #richText
	// A URL to the Terms of Service for the API.
	termsOfService?: #url
	// The contact information for the exposed API.
	contact?: #Contact
	// The license information for the exposed API.
	license?: #License
	// The version of the OpenAPI document (which is distinct from the OpenAPI Specification version or the API implementation version).
	version: string
	#SpecificationExtension
}

// https://swagger.io/specification/#contact-object.
#Contact: {
	// The identifying name of the contact person/organization.
	name?: string
	// The URL pointing to the contact information.
	url?: #url
	// The email address of the contact person/organization.
	email?: #emailAddress
	#SpecificationExtension
}

// https://swagger.io/specification/#license-object.
#License: {
	// The license name used for the API.
	name: string
	// A URL to the license used for the API.
	url?: #url
	#SpecificationExtension
}

// https://swagger.io/specification/#server-object.
#Server: {
	// A URL to the target host.
	// This URL supports Server Variables and MAY be relative,
	// to indicate that the host location is relative to the location where the OpenAPI document is being served.
	// Variable substitutions will be made when a variable is named in {brackets}.
	url: #url
	// An optional string describing the host designated by the URL.
	description?: string | #richText
	// A map between a variable name and its value.
	// The value is used for substitution in the server's URL template.
	variables?: [name=string]: #ServerVariable
	#SpecificationExtension
}

#serverDefault: #Server & {
	url: "/"
}

// https://swagger.io/specification/#server-variable-object.
#ServerVariable: {
	// An enumeration of string values to be used if the substitution options are from a limited set.
	// The array SHOULD NOT be empty.
	enum?: [string, ...string]
	// The default value to use for substitution, which SHALL be sent if an alternate value is not supplied.
	// Note this behavior is different than the Schema Object's treatment of default values,
	// because in those cases parameter values are optional.
	// If the enum is defined, the value SHOULD exist in the enum's values.
	default: string
	// An optional description for the server variable.
	description?: string | #richText
	#SpecificationExtension
}

// Holds a set of reusable objects for different aspects of the OAS.
// All objects defined within the components object will have no effect on the API unless they are explicitly referenced from properties outside the components object.
// https://swagger.io/specification/#components-object.
#Components: {
	// An object to hold reusable Schema Objects.
	schemas?: [string]: #Schema | #Reference
	// An object to hold reusable Response Objects.
	responses?: [string]: #Response | #Reference
	// An object to hold reusable Parameter Objects.
	parameters: [string]: #Parameter | #Reference
	// An object to hold reusable Example Objects.
	examples: [string]: #Example | #Reference
	// An object to hold reusable Request Body Objects.
	requestBodies: [string]: #RequestBody | #Reference
	// An object to hold reusable Header Objects.
	headers: [string]: #Header | #Reference
	// An object to hold reusable Security Scheme Objects.
	securitySchemes: [string]: #SecurityScheme | #Reference
	// An object to hold reusable Link Objects.
	links: [string]: #Link | #Reference
	// An object to hold reusable Callback Objects.
	callbacks: [string]: #Callback | #Reference
	#SpecificationExtension
}

// https://swagger.io/specification/#paths-object.
// todo make constraint more accurate.
#Paths: {
	// A relative path to an individual endpoint.
	// The field name MUST begin with a forward slash (/).
	// The path is appended (no relative URL resolution) to the expanded URL from the Server Object's url field in order to construct the full URL.
	// Path templating is allowed.
	// When matching URLs, concrete (non-templated) paths would be matched before their templated counterparts.
	// Templated paths with the same hierarchy but different templated names MUST NOT exist as they are identical.
	// In case of ambiguous matching, it's up to the tooling to decide which one to use.
	[=~"/\\.+"]: #PathItem
	#SpecificationExtension
}

// https://swagger.io/specification/#path-item-object.
#PathItem: {
	// Allows for an external definition of this path item.
	// The referenced structure MUST be in the format of a Path Item Object.
	// In case a Path Item Object field appears both in the defined object and the referenced object, the behavior is undefined.
	$ref: string
	// An optional, string summary, intended to apply to all operations in this path.
	summary: string
	// An optional, string description, intended to apply to all operations in this path.
	description?: string | #richText
	// A definition of a GET operation on this path.
	get: #Operation
	// A definition of a PUT operation on this path.
	put: #Operation
	// A definition of a POST operation on this path.
	post: #Operation
	// A definition of a DELETE operation on this path.
	delete: #Operation
	// A definition of a OPTIONS operation on this path.
	options: #Operation
	// A definition of a HEAD operation on this path.
	head: #Operation
	// A definition of a PATCH operation on this path.
	patch: #Operation
	// A definition of a TRACE operation on this path.
	trace: #Operation
	// An alternative server array to service all operations in this path.
	servers?: [...#Server]
	// A list of parameters that are applicable for all the operations described under this path.
	// These parameters can be overridden at the operation level, but cannot be removed there.
	// The list MUST NOT include duplicated parameters.
	// A unique parameter is defined by a combination of a name and location.
	// The list can use the #Reference to link to parameters that are defined at the OpenAPI Object's components/parameters.
	parameters: [... {#Parameter | #Reference}]
	#SpecificationExtension
}

#Operation: {
	// A list of tags for API documentation control.
	// Tags can be used for logical grouping of operations by resources or any other qualifier.
	tags?: [...string]
	// A short summary of what the operation does.
	summary?: string
	// A verbose explanation of the operation behavior.
	description?: string | #richText
	// Additional external documentation for this operation.
	externalDocs?: #ExternalDocumentation
	// Unique string used to identify the operation.
	// The id MUST be unique among all operations described in the API.
	// The operationId value is case-sensitive.
	// Tools and libraries MAY use the operationId to uniquely identify an operation, therefore, it is RECOMMENDED to follow common programming naming conventions.
	operationId?: string
	// A list of parameters that are applicable for this operation.
	// If a parameter is already defined at the Path Item, the new definition will override it but can never remove it.
	// The list MUST NOT include duplicated parameters.
	// A unique parameter is defined by a combination of a name and location.
	// The list can use the #Reference to link to parameters that are defined at the OpenAPI Object's components/parameters.
	parameters?: [#Parameter | #Reference]
	// The request body applicable for this operation.
	// The requestBody is only supported in HTTP methods where the HTTP 1.1 specification RFC7231 has explicitly defined semantics for request bodies.
	// In other cases where the HTTP spec is vague, requestBody SHALL be ignored by consumers.
	requestBody?: #RequestBody | #Reference
	// REQUIRED.
	// The list of possible responses as they are returned from executing this operation.
	responses: #Responses
	// A map of possible out-of band callbacks related to the parent operation.
	// The key is a unique identifier for the Callback Object.
	// Each value in the map is a Callback Object that describes a request that may be initiated by the API provider and the expected responses.
	callbacks?: [string]: #Callback | #Reference
	// Declares this operation to be deprecated.
	// Consumers SHOULD refrain from usage of the declared operation.
	deprecated?: bool | *false
	// A declaration of which security mechanisms can be used for this operation.
	// The list of values includes alternative security requirement objects that can be used.
	// Only one of the security requirement objects need to be satisfied to authorize a request.
	// To make security optional, an empty security requirement ({}) can be included in the array.
	// This definition overrides any declared top-level security.
	// To remove a top-level security declaration, an empty array can be used.
	security?: [...#SecurityRequirement]
	// An alternative server array to service this operation.
	// If an alternative server object is specified at the Path Item Object or Root level, it will be overridden by this value.
	servers?: [...#Server]
	#SpecificationExtension
}

#ExternalDocumentation: {
	// A short description of the target documentation.
	description?: string | #richText
	// REQUIRED.
	// The URL for the target documentation.
	url: #url
	#SpecificationExtension
}

// todo
// Describes a single operation parameter.
//
// A unique parameter is defined by a combination of a name and location.
// Parameter Locations
//
// There are four possible parameter locations specified by the in field:
//
//    path - Used together with Path Templating, where the parameter value is actually part of the operation's URL.
//           This does not include the host or base path of the API.
//           For example, in /items/{itemId}, the path parameter is itemId.
//    query - Parameters that are appended to the URL.
//            For example, in /items?id=###, the query parameter is id.
//    header - Custom headers that are expected as part of the request.
//             Note that RFC7230 states header names are case insensitive.
//    cookie - Used to pass a specific cookie value to the API.
// https://swagger.io/specification/#parameter-object.
#Parameter: {
	// The name of the parameter.
	// Parameter names are case sensitive.
	//    If in is "path", the name field MUST correspond to a template expression occurring within the path field in the Paths Object.
	//      See Path Templating for further information.
	//    If in is "header" and the name field is "Accept", "Content-Type" or "Authorization", the parameter definition SHALL be ignored.
	//    For all other cases, the name corresponds to the parameter name used by the in property.
	name: string
	// The location of the parameter.
	in: "query" | "header" | "path" | "cookie"
	// A brief description of the parameter.
	// This could contain examples of use.
	description?: string | #richText
	// Determines whether this parameter is mandatory.
	// If the parameter location is "path", this property is REQUIRED and its value MUST be true.
	// Otherwise, the property MAY be included and its default value is false.
	// todo implement optionality as documented.
	required?: bool | *false
	// Specifies that a parameter is deprecated and SHOULD be transitioned out of usage.
	deprecated?: bool | *false
	// Sets the ability to pass empty-valued parameters.
	// This is valid only for query parameters and allows sending a parameter with an empty value.
	// If style is used, and if behavior is n/a (cannot be serialized), the value of allowEmptyValue SHALL be ignored.
	// Use of this property is NOT RECOMMENDED, as it is likely to be removed in a later revision.
	allowEmptyValue?: bool | *false
	#SpecificationExtension
}

#RequestBody: {
	// A brief description of the request body.
	// This could contain examples of use.
	description: string | #richText
	// The content of the request body.
	// The key is a media type or media type range and the value describes it.
	// For requests that match multiple keys, only the most specific key is applicable.
	// e.g. text/plain overrides text/*.
	content: [string]: #MediaType
	// Determines if the request body is required in the request.
	required: bool | *false
	#SpecificationExtension
}

// https://swagger.io/specification/#media-type-object.
#MediaType: {
	// The schema defining the content of the request, response, or parameter.
	schema: #Schema | #Reference
	// Example of the media type.
	// The example object SHOULD be in the correct format as specified by the media type.
	// The example field is mutually exclusive of the examples field.
	// Furthermore, if referencing a schema which contains an example, the example value SHALL override the example provided by the schema.
	example: _
	// Examples of the media type.
	// Each example object SHOULD match the media type and specified schema if present.
	// The examples field is mutually exclusive of the example field.
	// Furthermore, if referencing a schema which contains an example, the examples value SHALL override the example provided by the schema.
	examples: [ string]: #Example | #Reference
	// A map between a property name and its encoding information.
	// The key, being the property name, MUST exist in the schema as a property.
	// The encoding object SHALL only apply to requestBody objects when the media type is multipart or application/x-www-form-urlencoded.
	encoding: [string]: #Encoding
	#SpecificationExtension
}

// https://swagger.io/specification/#encoding-object.
#Encoding: {
	// The Content-Type for encoding a specific property.
	// Default value depends on the property type:
	//   for string with format being binary – application/octet-stream;
	//   for other primitive types – text/plain; for object - application/json;
	//   for array – the default is defined based on the inner type.
	// The value can be a specific media type (e.g. application/json), a wildcard media type (e.g. image/*),
	// or a comma-separated list of the two types.
	contentType: string
	// A map allowing additional information to be provided as headers, for example Content-Disposition.
	// Content-Type is described separately and SHALL be ignored in this section.
	// This property SHALL be ignored if the request body media type is not a multipart.
	headers: [string]: #Header | #Reference
	// Describes how a specific property value will be serialized depending on its type.
	// See Parameter Object for details on the style property.
	// The behavior follows the same values as query parameters, including default values.
	// This property SHALL be ignored if the request body media type is not application/x-www-form-urlencoded.
	style: string
	// When this is true, property values of type array or object generate separate parameters for each value of the array, or key-value-pair of the map.
	// For other types of properties this property has no effect.
	// When style is form, the default value is true.
	// For all other styles, the default value is false.
	// This property SHALL be ignored if the request body media type is not application/x-www-form-urlencoded.
	explode: bool
	// Determines whether the parameter value SHOULD allow reserved characters, as defined by RFC3986 :/?#[]@!$&'()*+,;= to be included without percent-encoding.
	// The default value is false.
	// This property SHALL be ignored if the request body media type is not application/x-www-form-urlencoded.
	allowReserved: bool
	#SpecificationExtension
}

#Responses: {
	// Use this field to cover undeclared responses.
	// A Reference Object can link to a response that the OpenAPI Object's components/responses section defines.
	// The documentation of responses other than the ones declared for specific HTTP response codes.
	default: #Response | #Reference
	// Any HTTP status code can be used as the property name, but only one property per code, to describe the expected response for that HTTP status code.
	// A Reference Object can link to a response that is defined in the OpenAPI Object's components/responses section.
	// This field MUST be enclosed in quotation marks (for example, "200") for compatibility between JSON and YAML.
	// To define a range of response codes, this field MAY contain the uppercase wildcard character X.
	// For example, 2XX represents all response codes between [200-299].
	// Only the following range definitions are allowed: 1XX, 2XX, 3XX, 4XX, and 5XX.
	// If a response is defined using an explicit code, the explicit code definition takes precedence over the range definition for that code.
	[=~"[\\dX]{3}"]: #Response | #Reference
	#SpecificationExtension
}

// Describes a single response from an API Operation, including design-time,
// static links to operations based on the response.
// https://swagger.io/specification/#response-object.
#Response: {
	// A short description of the response.
	description: string | #richText
	// Maps a header name to its definition.
	// RFC7230 states header names are case insensitive.
	// If a response header is defined with the name "Content-Type", it SHALL be ignored.
	headers?: [string]: #Header | #Reference
	// A map containing descriptions of potential response payloads.
	// The key is a media type or media type range and the value describes it.
	// For responses that match multiple keys, only the most specific key is applicable.
	// e.g. text/plain overrides text/*.
	content?: [string]: #MediaType
	// A map of operations links that can be followed from the response.
	// The key of the map is a short name for the link, following the naming constraints of the names for Component Objects.
	links?: [string]: #Link | #Reference
	#SpecificationExtension
}

// todo
#Callback: {
	//{expression}  #PathItem  A Path Item Object used to define a callback request and expected responses.
	// A complete example is available.
	#SpecificationExtension
}

#Example: {
	// Short description for the example.
	summary?: string
	// Long description for the example.
	description?: string | #richText
	// Embedded literal example.
	// The value field and externalValue field are mutually exclusive.
	// To represent examples of media types that cannot naturally represented in JSON or YAML, use a string value to contain the example, escaping where necessary.
	value?: _
	// A URL that points to the literal example.
	// This provides the capability to reference examples that cannot easily be included in JSON or YAML documents.
	// The value field and externalValue field are mutually exclusive.
	externalValue?: #url
	#SpecificationExtension
}

// todo!
#Link: {
	// A relative or absolute URI reference to an OAS operation.
	// This field is mutually exclusive of the operationId field, and MUST point to an Operation Object.
	// Relative operationRef values MAY be used to locate an existing Operation Object in the OpenAPI definition.
	operationRef: string
	// The name of an existing, resolvable OAS operation, as defined with a unique operationId.
	// This field is mutually exclusive of the operationRef field.
	operationId: string
	//parameters   Map[string, Any | {expression}]  A map representing parameters to pass to an operation as specified with operationId or identified via operationRef.
	// The key is the parameter name to be used, whereas the value can be a constant or an expression to be evaluated and passed to the linked operation.
	// The parameter name can be qualified using the parameter location [{in}.]{name} for operations that use the same parameter name in different locations (e.g. path.id).
	//requestBody  Any | {expression}               A literal value or {expression} to use as a request body when calling the target operation.
	// A description of the link.
	description: string | #richText
	// A server object to be used by the target operation.
	server: #Server
	#SpecificationExtension
}

// todo validate correctness.
// https://swagger.io/specification/#header-object.
#Header: {
	description?:     #Parameter.description
	required?:        #Parameter.required
	deprecated?:      #Parameter.deprecated
	allowEmptyValue?: #Parameter.allowEmptyValue
	#SpecificationExtension
}

#Tag: {
	// The name of the tag.
	name: string
	// A short description for the tag.
	description?: string | #richText
	// Additional external documentation for this tag.
	externalDocs?: #ExternalDocumentation
	#SpecificationExtension
}

#Reference: {
	// The reference string.
	$ref: string
}

#Schema: {
	// A true value adds "null" to the allowed type specified by the type keyword, only if type is explicitly defined within the same Schema Object.
	// Other Schema Object constraints retain their defined behavior, and therefore may disallow the use of null as a value.
	// A false value leaves the specified or default type unmodified.
	// The default value is false.
	nullable: bool | *false
	//discriminator  #Discriminator  Adds support for polymorphism.
	// The discriminator is an object name that is used to differentiate between other schemas which may satisfy the payload description.
	// See Composition and Inheritance for more details.
	// Relevant only for Schema "properties" definitions.
	// Declares the property as "read only".
	// This means that it MAY be sent as part of a response but SHOULD NOT be sent as part of the request.
	// If the property is marked as readOnly being true and is in the required list, the required will take effect on the response only.
	// A property MUST NOT be marked as both readOnly and writeOnly being true.
	readOnly: bool | *false
	// Relevant only for Schema "properties" definitions.
	// Declares the property as "write only".
	// Therefore, it MAY be sent as part of a request but SHOULD NOT be sent as part of the response.
	// If the property is marked as writeOnly being true and is in the required list, the required will take effect on the request only.
	// A property MUST NOT be marked as both readOnly and writeOnly being true.
	writeOnly: bool | *false
	// This MAY be used only on properties schemas.
	// It has no effect on root schemas.
	// Adds additional metadata to describe the XML representation of this property.
	xml: #XML
	// Additional external documentation for this schema.
	externalDocs: #ExternalDocumentation
	// A free-form property to include an example of an instance for this schema.
	// To represent examples that cannot be naturally represented in JSON or YAML, a string value can be used to contain the example with escaping where necessary.
	example: _
	// Specifies that a schema is deprecated and SHOULD be transitioned out of usage.
	deprecated?: bool | *false
	#SpecificationExtension
}

#XML: {
	// Replaces the name of the element/attribute used for the described schema property.
	// When defined within items, it will affect the name of the individual XML elements within the list.
	// When defined alongside type being array (outside the items), it will affect the wrapping element and only if wrapped is true.
	// If wrapped is false, it will be ignored.
	name: string
	// The URI of the namespace definition.
	// Value MUST be in the form of an absolute URI.
	namespace: string
	// The prefix to be used for the name.
	prefix: string
	// Declares whether the property definition translates to an attribute instead of an element.
	attribute: bool | *false
	// MAY be used only for an array definition.
	// Signifies whether the array is wrapped (for example, <books><book/><book/></books>) or unwrapped (<book/><book/>).
	// The definition takes effect only when defined alongside type being array (outside the items).
	wrapped: bool | *false
	#SpecificationExtension
}

// https://swagger.io/specification/#security-scheme-object.
#SecurityScheme: {
	// The type of the security scheme.
	type: "apiKey" | "http" | "oauth2" | "openIdConnect"
	// A short description for security scheme.
	description?: string | #richText

	#ApiKey: {
		type: "apiKey"
		// The name of the header, query or cookie parameter to be used.
		name: string
		// The location of the API key.
		in: "query" | "header" | "cookie"
	}

	#Http: {
		type: "http"
		// The name of the HTTP Authorization scheme to be used in the Authorization header as defined in RFC7235.
		// The values used SHOULD be registered in the IANA Authentication Scheme registry.
		scheme: string
		// A hint to the client to identify how the bearer token is formatted.
		// Bearer tokens are usually generated by an authorization server, so this information is primarily for documentation purposes.
		bearerFormat?: string // todo implement applies to constraint.
	}

	#OAuth2: {
		type: "oauth2"
		// An object containing configuration information for the flow types supported.
		flows: #OAuthFlows
	}

	#OpenIdConnect: {
		type: "openIdConnect"
		// OpenId Connect URL to discover OAuth2 configuration values.
		openIdConnectUrl: #url
	}

	#ApiKey | #Http | #OAuth2 | #OpenIdConnect

	#SpecificationExtension
}

// https://swagger.io/specification/#oauth-flows-object.
#OAuthFlows: {
	// Configuration for the OAuth Implicit flow.
	implicit?: #OAuthFlow
	// Configuration for the OAuth Resource Owner Password flow.
	password?: #OAuthFlow
	// Configuration for the OAuth Client Credentials flow.
	// Previously called application in OpenAPI 2.0.
	clientCredentials?: #OAuthFlow
	// Configuration for the OAuth Authorization Code flow.
	// Previously called accessCode in OpenAPI 2.0.
	authorizationCode?: #OAuthFlow
	#SpecificationExtension
}

// todo
#OAuthFlow: {
	// oauth2 ("implicit", "authorizationCode")  REQUIRED.
	// The authorization URL to be used for this flow.
	authorizationUrl: #url
	// oauth2 ("password", "clientCredentials", "authorizationCode")  REQUIRED.
	// The token URL to be used for this flow.
	tokenUrl: #url
	// oauth2                                                         The URL to be used for obtaining refresh tokens.
	refreshUrl?: #url
	// oauth2  REQUIRED.
	// The available scopes for the OAuth2 security scheme.
	// A map between the scope name and a short description for it.
	scopes: {[string]: string} | {}
	#SpecificationExtension
}

// https://swagger.io/specification/#security-requirement-object.
// todo implement documented constraints.
#SecurityRequirement: {
	// Each name MUST correspond to a security scheme which is declared in the Security Schemes under the Components Object.
	// If the security scheme is of type "oauth2" or "openIdConnect", then the value is a list of scope names required for the execution, and the list MAY be empty if authorization does not require a specified scope.
	// For other security scheme types, the array MUST be empty.
	[string]: [...string]
}

// todo validate correctness.
#SpecificationExtension: {
	// Allows extensions to the OpenAPI Schema.
	// The field name MUST begin with x-, for example, x-internal-id.
	// The value can be null, a primitive, an array or an object.
	// Can have any valid JSON format value.
	[=~"^x-.+"]: _
}