#include <julia.h>
#include <dlfcn.h>
#include "k.h"

#define DLX(T,v) do{S r;v##_p=(T)dlsym(h,#v);		\
                  P(!v##_p,(r=(S)dlerror(),krr(r)));}while(0)
#define DLF(v) DLX(v##_t,v)
#define DLV(v) DLX(jl_value_t**,v)
#define DLT(v) DLX(jl_datatype_t**,v)

typedef void *DL;
typedef void (*jl_parse_opts_t)(int *argcp, char ***argvp);
typedef void (*jl_set_ARGS_t)(int argc, char **argv);
typedef void (*jl_init_with_image_t)(const char *julia_home_dir,
                                     const char *image_relative_path);
typedef char* (*jl_get_default_sysimg_path_t)(void);
typedef void (*jl_atexit_hook_t)(int);
typedef jl_value_t* (*jl_eval_string_t)(const char *);
typedef jl_value_t* (*jl_exception_occurred_t)(void);
typedef const char *(*jl_typeof_str_t)(jl_value_t *v);
typedef int8_t (*jl_unbox_bool_t)(jl_value_t *v);
typedef uint8_t (*jl_unbox_uint8_t)(jl_value_t *v);
typedef int16_t (*jl_unbox_int16_t)(jl_value_t *v);
typedef int32_t (*jl_unbox_int32_t)(jl_value_t *v);
typedef int64_t (*jl_unbox_int64_t)(jl_value_t *v);
typedef float (*jl_unbox_float32_t)(jl_value_t *v);
typedef double (*jl_unbox_float64_t)(jl_value_t *v);

Z jl_parse_opts_t jl_parse_opts_p;
Z jl_set_ARGS_t jl_set_ARGS_p;
Z jl_init_with_image_t jl_init_with_image_p;
Z jl_get_default_sysimg_path_t jl_get_default_sysimg_path_p;
Z jl_atexit_hook_t jl_atexit_hook_p;
Z jl_eval_string_t jl_eval_string_p;
Z jl_exception_occurred_t jl_exception_occurred_p;

Z jl_typeof_str_t jl_typeof_str_p;

Z jl_unbox_bool_t jl_unbox_bool_p;
Z jl_unbox_uint8_t jl_unbox_uint8_p;
Z jl_unbox_int16_t jl_unbox_int16_p;
Z jl_unbox_int32_t jl_unbox_int32_p;
Z jl_unbox_int64_t jl_unbox_int64_p;
Z jl_unbox_float32_t jl_unbox_float32_p;
Z jl_unbox_float64_t jl_unbox_float64_p;

/* singleton values */
Z jl_value_t **jl_true_p;
Z jl_value_t **jl_false_p;
Z jl_value_t **jl_nothing_p;

/* julia types */
Z jl_datatype_t **jl_int32_type_p;
Z jl_datatype_t **jl_int64_type_p;

ZK none;
ZJ eos = 0;

Z K1(J_init_simple){
  jl_init();
  R kb(1);}
Z K2(J_init){
  K argk; /* abuse KS type for extra storage */
  I argc; S* argv;
  P(y->t!=KC,krr((S)"y type"));
  y = ja(&y, &eos);
  P(xt,krr((S)"x type"));
  DO(xn,P(xK[i]->t!=KC,krr((S)"x[i] type")));
  DO(xn,ja(xK+i,&eos));
  argk = ktn(KS, xn);
  argc = xn;
  argv = kS(argk);
  DO(xn,argv[i]=(S)kC(xK[i]));
  /* Parse an argc/argv pair to extract general julia options, passing
     back out any arguments that should be passed on to the script. */
  jl_parse_opts(&argc, &argv);
  jl_init();
  // jl_init_with_image_p((S)kC(y), jl_get_default_sysimg_path_p());
  /* Set julia-level ARGS array */
  jl_set_ARGS(argc, argv);
  r0(argk);
  R ktj(101,0);}
Z K1(J_atexit_hook){jl_atexit_hook_p(xi);R ktj(101,0);}
Z K1(J_eval_string){
  K r;
  jl_value_t *v;
  P(xt!=KC,krr((S)"type"));
  ja(&x, &eos);
  v = jl_eval_string((S)xC);
  if (jl_exception_occurred()) {
    printf("Julia Error: %s \n", jl_typeof_str(jl_exception_occurred()));
    // printf("Julia Error:");
    // jl_call1(jl_eval_string("(e) -> showerror(stdout, e)"),jl_exception_occurred());
    R krr((S)jl_typeof_str(jl_exception_occurred()));
  }
  if (v == jl_nothing)
    R (K)0;
  if (v == jl_false)
    R kb(0);
  if (v == jl_true)
    R kb(1);
  if (jl_typeis(v, jl_int64_type))
    R kj(jl_unbox_int64(v));
  if (jl_typeis(v, jl_int32_type))
    R ki(jl_unbox_int32(v));
  if (jl_typeis(v, jl_int16_type))
    R kh(jl_unbox_int16(v));
  if (jl_typeis(v, jl_uint8_type))
    R kg(jl_unbox_uint8(v));
  if (jl_typeis(v, jl_float64_type))
    R kf(jl_unbox_float64(v));
  if (jl_typeis(v, jl_float32_type))
    R ke(jl_unbox_float32(v));
  jl_call1(jl_eval_string("(out) -> @show(out)"),v);

  R (K)0;
}

K1(qjl){
  x = ktn(KS, 4);
  xS[0] = ss((S)"init_simple");
  xS[1] = ss((S)"eval_simple");
  xS[2] = ss((S)"atexit");
  xS[3] = ss((S)"init");
  K vl = knk(4,dl(J_init_simple,1),dl(J_eval_string,1),dl(J_atexit_hook,1),dl(J_init,2));
  // R vl;
  R xD(x,vl);
}
