module KdbConnect

using Tables
using Missings
using TimesDates
using Dates
using DataFrames
using REPL

using Base: IteratorSize, IteratorEltype, HasLength, HasShape, IsInfinite, SizeUnknown
using Base.Iterators: enumerate, zip, flatten

export KdbHandle, KdbConnectionInfo
export open, close!, execute

const NANOSECONDSPERDAY = 86400000000000

include("k_lib.jl") # interface to KDB C API
include("k_types.jl") # K objects in Julia
include("jl_to_k.jl") # Convert Julia types to K objects
include("k_to_jl.jl") # Convert K objects to Julia types
include("client.jl") # Connection and interface with KDB

if K_lib.IS_EMBEDDED_Q
    export q
    include("embed.jl") # embedding into q process
end

end
