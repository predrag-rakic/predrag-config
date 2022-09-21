# RFC: Proposal for in-place struct generation
`openapi-codegen` is tool developed primarily for API definitions in mind, but it is also very useful for struct definition. This proposal makes it even more useful and accessible.

## What
- OpenAPI struct definition without overhead of whole valid OpenAPI spec.
- In the same directory: struct definition (`.yml` file) together with generated `.ex` file and other manually created `.ex` files.
	- OpenAPI struct definition becomes first-level citizen.
- Automated struct generation (openapi-codegen compiler is automatically invoked each time app is compiled).

## Why
-   Simplifies definition and maintenance of structs.
-   Simplifies/automates usage of openapi-codegen tool.
-   Guaranties that .yml and .ex files are always in sync.
-   .yml spec can be used in other .yml specifications hierarchically, throughout the codebase.
-   OpenAPI struct definition becomes first-level citizen.

## How
- Elixir struct spec is defined within `lib`  directory but with its own extension `openapi-struct.yml`.
	- That file should contain valid object spec, but not valid top-level OpenAPI spec.
- Compiler:
	- Is added to list of compilers (before elixir compiler).
	- Searches through compile directories and finds all files with that extension.
	- For each file:
		- Adds missing boilerplate to make it valid OpenAPI spec.
		- Spec is transpiled into `.ex` file (in the same dir as original spec).