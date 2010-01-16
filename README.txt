= IRDb

* http://github.com/rvernagus/irdb
* mailto:r.vernagus@gmail.com

== DESCRIPTION:

IRDb stands for IronRuby Database. The central object of IRDb is the Database
and it provides a set of methods for dealing with databases of all types.

IRDb is built on top of the .NET DbProvider model and you can use the IRDb
Database object to interact with any database client that implements the
abstract System.Data.Common.DbProviderFactory class.

IRDb is written in 100% Ruby code.

== SYNOPSIS:

Core specs:
  rake spec:core
  
Specs in IronRuby:
  rake spec:core_ir
  rake spec:sql_server
  rake spec:oracle

Or run at the command line:
  ir mspec/bin/mspec -B spec/core_ir.mspec
  ir mspec/bin/mspec -B spec/oracle.mspec
  ir mspec/bin/mspec -B spec/sql_server.mspec

== REQUIREMENTS:

* IronRuby
* hoe
* shoulda

== INSTALL (not yet available):

* igem install irdb

== LICENSE:

(The MIT License)

Copyright (c) Ray Vernagus

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
