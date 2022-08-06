module K_lib

# Note:
# This library was mostly generated by Clang.jl and edited manually to fix
# parts that were incorrectly parsed. See <root>/src/gen for details.

#TODO: ./deps/build.jl or artifact & programatically determine C_LIBQ location
# library location
C_LIBQ = "/Users/pcasgrain/Documents/GitHub/Q.jl/src/c.dylib"

using CEnum

# Define C type aliases
const J = Clonglong
const H = Cshort
const I = Cint
const E = Cfloat
const F = Cdouble
const S = Ptr{Cchar}
const C = Cchar
const U = UInt128
const V = Cvoid
const G = Cuchar

# Type Union for convenience
const K_CTypes = Union{J,H,I,E,F,S,C,U,V,G}

# Define Base K type
struct k0
    data::NTuple{24,UInt8}
end
const K = Ptr{k0}

const K_NULL = K(C_NULL)

function Base.getproperty(x::Ptr{k0}, f::Symbol)
    f === :m && return Ptr{Int8}(x + 0)
    f === :a && return Ptr{Int8}(x + 1)
    f === :t && return Ptr{Int8}(x + 2)
    f === :u && return Ptr{C}(x + 3)
    f === :r && return Ptr{I}(x + 4)
    f === :g && return Ptr{G}(x + 8)
    f === :h && return Ptr{H}(x + 8)
    f === :i && return Ptr{I}(x + 8)
    f === :j && return Ptr{J}(x + 8)
    f === :e && return Ptr{E}(x + 8)
    f === :f && return Ptr{F}(x + 8)
    f === :s && return Ptr{S}(x + 8)
    f === :k && return Ptr{K}(x + 8)
    f === :n && return Ptr{J}(x + 8)
    f === :G0 && return Ptr{NTuple{1,G}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::k0, f::Symbol)
    r = Ref{k0}(x)
    ptr = Base.unsafe_convert(Ptr{k0}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{k0}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

# Define Type Constants
TYPE_LETTERS = "kb  ghijefcspmdznuvt"
for (t, x) in enumerate(TYPE_LETTERS)
    isspace(x) || @eval const $(Symbol("K", uppercase(x))) = $(I(t - 1))
end

const UU = I(2)
const XT = I(98)
const XD = I(99)
const EE = I(128)  #   error

# Define head accessors
xt(x::K) = unsafe_load(x.t) # type
xr(x::K) = unsafe_load(x.r) # reference_count
xn(x::K) = unsafe_load(x.n) # size

# define scalar accessors
xg(x::K) = unsafe_load(x.g)
xh(x::K) = unsafe_load(x.h)
xi(x::K) = unsafe_load(x.i)
xj(x::K) = unsafe_load(x.j)
xe(x::K) = unsafe_load(x.e)
xf(x::K) = unsafe_load(x.f)
xs(x::K) = unsafe_string(unsafe_load(x.s))
xk(x::K) = unsafe_load(x.k)
xp(x::K) = unsafe_string(Ptr{C}(x + 16), xn(x)) # string accessor

# xg(x::K_) = unsafe_load(Ptr{G_}(x + 8))
# xs(x::K_) = (s = unsafe_load(Ptr{S_}(x + 8)); s == C_NULL ? "null" : unsafe_string(s))


# vector accessors (no copy)
kG(x::K) = unsafe_wrap(Array, Ptr{G}(x + 16), (xn(x),))
kH(x::K) = unsafe_wrap(Array, Ptr{H}(x + 16), (xn(x),))
kI(x::K) = unsafe_wrap(Array, Ptr{I}(x + 16), (xn(x),))
kJ(x::K) = unsafe_wrap(Array, Ptr{J}(x + 16), (xn(x),))
kE(x::K) = unsafe_wrap(Array, Ptr{E}(x + 16), (xn(x),))
kF(x::K) = unsafe_wrap(Array, Ptr{F}(x + 16), (xn(x),))
kC(x::K) = unsafe_wrap(Array, Ptr{C}(x + 16), (xn(x),))
kS(x::K) = unsafe_wrap(Array, Ptr{S}(x + 16), (xn(x),))
kK(x::K) = unsafe_wrap(Array, Ptr{K}(x + 16), (xn(x),))
#TODO add KU (GUID) type implementation


kX(::Type{C}, x::K) where {C} = unsafe_wrap(Array, Ptr{C}(x + 16), (xn(x),)) # extra vector loader

# table and dict accessors
# xk(x::K) = unsafe_load(Ptr{K}(x + 8))
xx(x::K) = unsafe_load(x.k, 1)
xy(x::K) = unsafe_load(x.k, 2)

# scalar constructors

# ku(x::U_) =(p = ka(-UU); unsafe_store!(Ptr{U_}(p + 16), x); p)
# ku(x::Integ er) = ku(U_(x))

"Create a keyed table"
knt(arg1, arg2) = @ccall C_LIBQ.knt(arg1::J, arg2::K)::K

"Create a simple list of type and length"
ktn(arg1, arg2) = @ccall C_LIBQ.ktn(arg1::I, arg2::J)::K

"create fixed-length string"
kpn(arg1, arg2) = @ccall C_LIBQ.kpn(arg1::S, arg2::J)::K

# Connection Functions
khpunc(arg1, arg2, arg3, arg4, arg5) = @ccall C_LIBQ.khpunc(arg1::S, arg2::I, arg3::S, arg4::I, arg5::I)::I
khpun(arg1, arg2, arg3, arg4) = @ccall C_LIBQ.khpun(arg1::S, arg2::I, arg3::S, arg4::I)::I
khpu(arg1, arg2, arg3) = @ccall C_LIBQ.khpu(arg1::S, arg2::I, arg3::S)::I
khp(arg1, arg2) = @ccall C_LIBQ.khp(arg1::S, arg2::I)::I
kclose(arg1) = @ccall C_LIBQ.kclose(arg1::I)::V

# Atom constructors
"Create an atom of type and value"
ktj(arg1, arg2) = @ccall C_LIBQ.ktj(arg1::I, arg2::J)::K
"Create an atom of type"
ka(arg1) = @ccall C_LIBQ.ka(arg1::I)::K
"Create a boolean"
kb(arg1) = @ccall C_LIBQ.kb(arg1::I)::K
"Create a byte"
kg(arg1) = @ccall C_LIBQ.kg(arg1::I)::K
"Create a short"
kh(arg1) = @ccall C_LIBQ.kh(arg1::I)::K
"Create an int"
ki(arg1) = @ccall C_LIBQ.ki(arg1::I)::K
"Create a long"
kj(arg1) = @ccall C_LIBQ.kj(arg1::J)::K
"Create a real"
ke(arg1) = @ccall C_LIBQ.ke(arg1::F)::K
"Create a float"
kf(arg1) = @ccall C_LIBQ.kf(arg1::F)::K
"Create a char"
kc(arg1) = @ccall C_LIBQ.kc(arg1::I)::K
"Create a symbol"
ks(arg1) = @ccall C_LIBQ.ks(arg1::S)::K
"Create a date"
kd(arg1) = @ccall C_LIBQ.kd(arg1::I)::K
"Create a datetime (deprecated)"
kz(arg1) = @ccall C_LIBQ.kz(arg1::F)::K
"Create a time"
kt(arg1) = @ccall C_LIBQ.kt(arg1::I)::K
"Create a guid"
ku(arg1) = @ccall C_LIBQ.ku(arg1::U)::K
# Vector Constructors
"Create a char array from string"
kp(arg1) = @ccall C_LIBQ.kp(arg1::S)::K

knk(args::K...) = knk(length(args), args...)
function knk(n::Integer, args::K...)
    @eval ccall((:knk, K_lib.C_LIBQ), K_lib.K, (K_lib.I, K_lib.K...), $n, $(args...))
end

# const _AnyString = Union{String,Symbol,Cstring}
# "Intern n chars from a string"
# sn(x::_AnyString, n::Integer) = ccall((@k_sym :sn), S_, (S_, I_), x, n)


"Join an atom to a list"
ja(arg1, arg2) = @ccall C_LIBQ.ja(arg1::Ptr{K}, arg2::Ptr{V})::K
"Join a symbol to a list"
js(arg1, arg2) = @ccall C_LIBQ.js(arg1::Ptr{K}, arg2::S)::K
"Join a K object to a list"
jk(arg1, arg2) = @ccall C_LIBQ.jk(arg1::Ptr{K}, arg2::K)::K
"Join another K list to a list"
jv(k_, arg2) = @ccall C_LIBQ.jv(k_::Ptr{K}, arg2::K)::K

"Encode a year/month/day as q date"
ymd(arg1, arg2, arg3) = @ccall C_LIBQ.ymd(arg1::I, arg2::I, arg3::I)::I
"Convert q date to yyyymmdd integer"
dj(arg1) = @ccall C_LIBQ.dj(arg1::I)::I


"decrement reference count"
r0(arg1) = @ccall C_LIBQ.r0(arg1::K)::V
"increment reference count"
r1(arg1) = @ccall C_LIBQ.r1(arg1::K)::K

"execute string query on handle h, with up to 8 arguments"
k(h::Integer, m::String) = @ccall C_LIBQ.k(h::I, m::S, K_NULL::K)::K
k(h::Integer, m::String, args::K...) = _k(h, m, args..., K_NULL)
function _k(h::Integer, m::String, args::K...)
    n = length(args)
    (n > 9) && error("Q.jl: function k can take at most 8 arguments. $(length(args)-1) were provided.")
    return ccall((:k, C_LIBQ), K, (I, S, K...,), h, m, args...)
end



m9() = @ccall C_LIBQ.m9()::V
b9(arg1, arg2) = @ccall C_LIBQ.b9(arg1::I, arg2::K)::K
d9(arg1) = @ccall C_LIBQ.d9(arg1::K)::K
okx(arg1) = @ccall C_LIBQ.okx(arg1::K)::I

sd0(arg1) = @ccall C_LIBQ.sd0(arg1::I)::V
sd0x(d, f) = @ccall C_LIBQ.sd0x(d::I, f::I)::V
sn(arg1, arg2) = @ccall C_LIBQ.sn(arg1::S, arg2::I)::S
ss(arg1) = @ccall C_LIBQ.ss(arg1::S)::S
ee(arg1) = @ccall C_LIBQ.ee(arg1::K)::K
sd1(arg1, arg2) = @ccall C_LIBQ.sd1(arg1::I, arg2::Ptr{Cvoid})::K
dl(f, arg2) = @ccall C_LIBQ.dl(f::Ptr{V}, arg2::J)::K
xT(arg1) = @ccall C_LIBQ.xT(arg1::K)::K
xD(arg1, arg2) = @ccall C_LIBQ.xD(arg1::K, arg2::K)::K
orr(arg1) = @ccall C_LIBQ.orr(arg1::S)::K
dot(arg1, arg2) = @ccall C_LIBQ.dot(arg1::K, arg2::K)::K
sslInfo(x) = @ccall C_LIBQ.sslInfo(x::K)::K

# === Define k function for up to 8 arguments
for i in 1:8
    fn_args = [Symbol("x", j) for j in 1:i]
    typed_args = collect(Expr(:(::), x, :(K)) for x in fn_args)
    @eval k(h::Integer, m::String, $(typed_args...)) = ccall((:k, C_LIBQ), K, (I, S, K...), h, m, $(fn_args...), K_NULL)
end

# === Define Nulls and Infinities
const nh = typemin(H)
const wh = typemax(H)
const ni = typemin(I)
const wi = typemax(I)
const nj = typemin(J)
const wj = typemax(J)
const ne = E(NaN32)
const we = E(Inf32)
const nf = F(NaN64)
const wf = F(Inf64)




end