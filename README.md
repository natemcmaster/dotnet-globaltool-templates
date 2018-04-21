.NET Core Global Tool Template
==============================

This project contains templates for creating .NET Core Global tools.

## Usage

Install the templates package

    dotnet new --install "McMaster.DotNet.GlobalTool.Templates::2.1.300-preview2"

Create a new project

    dotnet new global-tool

Options:

    --no-restore        If specified, skips the automatic restore of the project on create.
                        bool - Optional
                        Default: false

    -cn|--command-name  The name of the global command. This is what users will type to invoke this tool once it is installed.
                        text - Optional
                        Default: my-tool

