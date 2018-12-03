#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <sys/stat.h>
#include <stdbool.h>

#define DIRECTORY ./Meach3E-8_Mtot3E-5_Mmax5E-15_t1E9_dtlog_ecc5E-2_nofrag_dt/  //ディレクトリ.
//#define DIRECTORY ./Meach3E-9_Mtot3E-7_Mmax5E-15_t1E9_dtlog_ecc1E-1_nofrag_dt/  //ディレクトリ.
//#define DIRECTORY ./test/  //ディレクトリ.

#define STR_(str) #str
#define STR(str) STR_(str)

#define N_DIVIDE_I 64
#define N_DIVIDE_S 256

#define ECC_RMS 5.0E-2
#define INC_RMS (BETA*ECC_RMS)

#define DIFFERENTTYPE true  //DIFFERENTTYPE = true のとき : 惑星-微惑星のみ.
#define BACKREACTION false
//DIFFERENTTYPE = false かつ BACKREACTION = true のとき : 惑星-惑星, 惑星-微惑星.
//DIFFERENTTYPE = false かつ BACKREACTION = false のとき : 惑星-惑星, 惑星-微惑星, 微惑星-微惑星.

#define FRAGMENTATION false

#define ACCURACY_CHECK true
#define EPS_KE 1.0E-10
#define EPS_I 1.0E-10
#define EPS_S 1.0E-10

#define T_MAX (2.0*M_PI*1.0E9)

#define PLANET_EACHMASS 3.0E-6
#define PLANET_TOTALMASS 3.0E-6

#define PLANETESIMAL_EACHMASS 3.0E-8
#define PLANETESIMAL_TOTALMASS 3.0E-5


#define AXIS 1.0
#define BETA 0.5
#define ETA 0.01



#if FRAGMENTATION
#define RHO 3.0  // [g/cc]  微惑星の物質密度.
#define EPSILON_FRAG 0.2
#define B_FRAG (5.0/3.0)
#define Q_0_FRAG 9.5E8 // [erg/g]  Q_D = Q_0*(rho/3[g/cc])^0.55*(m/10^21[g])^p
#define P_FRAG 0.453
#define XI 0.01 //統計的計算のタイムステップがタイムスケールの"XI"倍.
#define M_MAX 5.00E-15  //最大微惑星質量. 1E19 g = 10kmサイズ.
//#define M_MAX 5.00E-18  //最大微惑星質量. 1E16 g = 1kmサイズ.
#endif

#if __GNUC__ == 7
#define CONST const
#define ALWAYS_INLINE __attribute__((always_inline))
#elif __GNUC__ == 4
#define CONST
#define ALWAYS_INLINE
#else
#define CONST
#define ALWAYS_INLINE
#endif

struct elements{
  char name[50];
  double ecc2;
  double inc2;
  double ecc2_next;
  double inc2_next;
  double eachmass;
  double totalmass;
  double eachmass_next;
  double totalmass_next;
};

#if FRAGMENTATION
struct fragmentation{
  double sigma;
  double v_ave;
  double flux;
  double dt_frag;
  double t_frag;
};

struct parameter{
  double s_1;
  double s_2;
  double s_3;
  double alpha;
  double h_0;
  double Q_D;
};
#endif

static inline ALWAYS_INLINE double MutualHill_Ratio(double ratio){
  return (1.0/ratio + 0.5*cbrt(2.0*PLANET_EACHMASS/3.0))/(1.0/ratio - 0.5*cbrt(2.0*PLANET_EACHMASS/3.0));
}

static inline ALWAYS_INLINE double Reduced_Hill(int i, int j,CONST struct elements ele[]){
  return cbrt((ele[i].eachmass + ele[j].eachmass) / 3.0);
}

double K_lambda(double lambda){

  int n=0,m=0;
  double k[20]={};
  double tmp_K=0.5*M_PI;

  /*Landen変換*/
  k[0] = 0.5*sqrt(3.0*(1.0-lambda*lambda));
  do{
    n++;
    k[n] = (1.0 - sqrt(1.0 - k[n-1]*k[n-1])) / (1.0 + sqrt(1.0 - k[n-1]*k[n-1]));
  }while(k[n]>EPS_KE);

  for(m=n;m>=1;m--){
    tmp_K *= (1.0 + k[m]);
  }
  return tmp_K;
}


double E_lambda(double lambda){

  int n=0,m=0;
  double k[20]={};
  double tmp_K=0.5*M_PI,tmp_E=0.5*M_PI;

  /*Landen変換*/
  k[0] = 0.5*sqrt(3.0*(1.0-lambda*lambda));
  do{
    n++;
    k[n] = (1.0 - sqrt(1.0 - k[n-1]*k[n-1])) / (1.0 + sqrt(1.0 - k[n-1]*k[n-1]));
  }while(k[n]>EPS_KE);

  for(m=n;m>=0;m--){
    tmp_K *= (1.0 + k[m+1]);
    tmp_E = (1.0 + sqrt(1.0 - k[m]*k[m])) * tmp_E - sqrt(1.0 - k[m]*k[m]) * tmp_K;
  }
  return tmp_E;
}


static inline ALWAYS_INLINE double I_PVS_integrand(double beta, double t){
  return (5.0 * K_lambda(sin(t)) - 12.0*cos(t)*cos(t)/(1.0+3.0*sin(t)*sin(t)) * E_lambda(sin(t))) / (beta + (1.0/beta - beta) * sin(t)*sin(t)) * cos(t);
}


double I_PVS(double beta){

  int n,nmax=N_DIVIDE_I;
  double ini=0.0,fin=0.5*M_PI;
  double dt=0.0;
  double sum=0.0,sum_next=0.0;

  do{
    sum = sum_next;
    sum_next = 0.0;
    dt = (fin-ini)/2.0/((double)nmax);

    /* simpson : dx(f(ndx)+ 4f((n+1)dx)+ f((n+2)dx))/6 = dx'(f(2ndx')+ 4f((2n+1)dx')+ f((2n+2)dx'))/3 , dx' = dx/2 */
    for(n=0;n<nmax;n++){
      sum_next += dt * (I_PVS_integrand(beta, ini+2.0*n*dt) + 4.0*I_PVS_integrand(beta, ini+(2.0*n+1)*dt) + I_PVS_integrand(beta, ini+(2.0*n+2)*dt)) / 3.0;
    }
#if ACCURACY_CHECK
    //printf("I_PVS\tnmax=%d\t%e\n",nmax,fabs((sum-sum_next)/sum_next));
#endif
    nmax *= 2;
  }while(
#if ACCURACY_CHECK
	 fabs((sum-sum_next)/sum_next)>EPS_I && nmax<=16384
#else
	 false
#endif
	 );

  return sum_next;
}

static inline ALWAYS_INLINE double I_QVS_integrand(double beta, double t){
  return (K_lambda(sin(t)) - 12.0*sin(t)*sin(t)/(1.0+3.0*sin(t)*sin(t)) * E_lambda(sin(t))) / (beta + (1.0/beta - beta) * sin(t)*sin(t)) * cos(t);
}

double I_QVS(double beta){

  int n,nmax=N_DIVIDE_I;
  double ini=0.0,fin=0.5*M_PI;
  double dt=0.0;
  double sum=0.0,sum_next=0.0;

  do{
    sum = sum_next;
    sum_next = 0.0;
    dt = (fin-ini)/2.0/((double)nmax);

     /* simpson : dx(f(ndx)+ 4f((n+1)dx)+ f((n+2)dx))/6 = dx'(f(2ndx')+ 4f((2n+1)dx')+ f((2n+2)dx'))/3 , dx' = dx/2 */
    for(n=0;n<nmax;n++){
      sum_next += dt * (I_QVS_integrand(beta, ini+2.0*n*dt) + 4.0*I_QVS_integrand(beta, ini+(2.0*n+1)*dt) + I_QVS_integrand(beta, ini+(2.0*n+2)*dt)) / 3.0;
    }
#if ACCURACY_CHECK
    //printf("I_QVS\tnmax=%d\t%e\n",nmax,fabs((sum-sum_next)/sum_next));
#endif
    nmax *= 2;
  }while(
#if ACCURACY_CHECK
	 fabs((sum-sum_next)/sum_next)>EPS_I && nmax<=16384
#else
	 false
#endif
	 );

  return sum_next;
}

static inline ALWAYS_INLINE double I_PDF_integrand(double beta, double t){
  return (cos(t)*cos(t)/(1.0+3.0*sin(t)*sin(t)) * E_lambda(sin(t))) / (beta + (1.0/beta - beta) * sin(t)*sin(t)) * cos(t);
}

double I_PDF(double beta){

  int n,nmax=N_DIVIDE_I;
  double ini=0.0,fin=0.5*M_PI;
  double dt=0.0;
  double sum=0.0,sum_next=0.0;

  do{
    sum = sum_next;
    sum_next = 0.0;
    dt = (fin-ini)/2.0/((double)nmax);

    /* simpson : dx(f(ndx)+ 4f((n+1)dx)+ f((n+2)dx))/6 = dx'(f(2ndx')+ 4f((2n+1)dx')+ f((2n+2)dx'))/3 , dx' = dx/2 */
    for(n=0;n<nmax;n++){
      sum_next += dt * (I_PDF_integrand(beta, ini+2.0*n*dt) + 4.0*I_PDF_integrand(beta, ini+(2.0*n+1)*dt) + I_PDF_integrand(beta, ini+(2.0*n+2)*dt)) / 3.0;
    }
#if ACCURACY_CHECK
    //printf("I_PDF\tnmax=%d\t%e\n",nmax,fabs((sum-sum_next)/sum_next));
#endif
    nmax *= 2;
  }while(
#if ACCURACY_CHECK
	 fabs((sum-sum_next)/sum_next)>EPS_I && nmax<=16384
#else
	 false
#endif
	 );

  return sum_next;
}

static inline ALWAYS_INLINE double I_QDF_integrand(double beta, double t){
  return (sin(t)*sin(t)/(1.0+3.0*sin(t)*sin(t)) * E_lambda(sin(t))) / (beta + (1.0/beta - beta) * sin(t)*sin(t)) * cos(t);
}

double I_QDF(double beta){

  int n,nmax=N_DIVIDE_I;
  double ini=0.0,fin=0.5*M_PI;
  double dt=0.0;
  double sum=0.0,sum_next=0.0;

  do{
    sum = sum_next;
    sum_next = 0.0;
    dt = (fin-ini)/2.0/((double)nmax);

     /* simpson : dx(f(ndx)+ 4f((n+1)dx)+ f((n+2)dx))/6 = dx'(f(2ndx')+ 4f((2n+1)dx')+ f((2n+2)dx'))/3 , dx' = dx/2 */
    for(n=0;n<nmax;n++){
      sum_next += dt * (I_QDF_integrand(beta, ini+2.0*n*dt) + 4.0*I_QDF_integrand(beta, ini+(2.0*n+1)*dt) + I_QDF_integrand(beta, ini+(2.0*n+2)*dt)) / 3.0;
    }
#if ACCURACY_CHECK
    //printf("I_QDF\tnmax=%d\t%e\n",nmax,fabs((sum-sum_next)/sum_next));
#endif
    nmax *= 2;
  }while(
#if ACCURACY_CHECK
	 fabs((sum-sum_next)/sum_next)>EPS_I && nmax<=16384
#else
	 false
#endif
	 );

  return sum_next;
}

double P_VS(double ecc2, double inc2){

  double Lambda = 1.0/12.0 * (ecc2 + inc2) * sqrt(inc2);
  double beta = sqrt(inc2/ecc2);

  return log(10.0 * Lambda*Lambda/ecc2 + 1.0) / (10.0 * Lambda*Lambda/ecc2) * 73.0 + 72.0 * I_PVS(beta) / (M_PI * sqrt(ecc2) * sqrt(inc2)) * log(Lambda*Lambda + 1.0);
}

double Q_VS(double ecc2, double inc2){

  double Lambda = 1.0/12.0 * (ecc2 + inc2) * sqrt(inc2);
  double beta = sqrt(inc2/ecc2);

  return log(10.0 * Lambda*Lambda*sqrt(ecc2) + 1.0) / (10.0 * Lambda*Lambda*sqrt(ecc2)) * (4.0*inc2 + 0.2*ecc2*sqrt(ecc2)*sqrt(inc2)) + 72.0 * I_QVS(beta) / (M_PI * sqrt(ecc2) * sqrt(inc2)) * log(Lambda*Lambda + 1.0);
}

double P_DF(double ecc2, double inc2){

  double Lambda = 1.0/12.0 * (ecc2 + inc2) * sqrt(inc2);
  double beta = sqrt(inc2/ecc2);

  return log(10.0 * Lambda*Lambda + 1.0) / (Lambda*Lambda) * ecc2 + 576.0 * I_PDF(beta) / (M_PI * sqrt(ecc2) * sqrt(inc2)) * log(Lambda*Lambda + 1.0);
}

double Q_DF(double ecc2, double inc2){

  double Lambda = 1.0/12.0 * (ecc2 + inc2) * sqrt(inc2);
  double beta = sqrt(inc2/ecc2);

  return log(10.0 * Lambda*Lambda + 1.0) / (Lambda*Lambda) * inc2 + 576.0 * I_QDF(beta) / (M_PI * sqrt(ecc2) * sqrt(inc2)) * log(Lambda*Lambda + 1.0);
}

double N_s(int j,CONST struct elements ele[]){

  double S = M_PI * (AXIS*MutualHill_Ratio(5.0)*AXIS*MutualHill_Ratio(5.0) - AXIS/MutualHill_Ratio(5.0)*AXIS/MutualHill_Ratio(5.0));

  return ele[j].totalmass / ele[j].eachmass / S;
}


int judge_ini(int i){
#if DIFFERENTTYPE
  if(i==1){
    return 2;
  }else if(i==2){
    return 1;
  }else{
    printf("judge error\n");
    exit(-1);
  }
#else
  return 1;
#endif
}

int judge_fin(int i){
#if BACKREACTION || DIFFERENTTYPE
  if(i==1){
    return 2;
  }else if(i==2){
    return 1;
  }else{
    printf("judge error\n");
    exit(-1);
  }
#else
  return 2;
#endif
}


double decc2dt(int i,CONST struct elements ele[]){
  int j;
  double tmp=0.0;
  double ecc2=0.0,inc2=0.0;

  for(j=judge_ini(i);j<=judge_fin(i);j++){

    ecc2 = (ele[i].ecc2 + ele[j].ecc2)/(Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele));
    inc2 = (ele[i].inc2 + ele[j].inc2)/(Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele));

    tmp += N_s(j,ele) * Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele)*ele[j].eachmass/(ele[i].eachmass + ele[j].eachmass)/(ele[i].eachmass + ele[j].eachmass) * (ele[j].eachmass * P_VS(ecc2,inc2) + (ele[j].eachmass * ele[j].ecc2 - ele[i].eachmass * ele[i].ecc2) / (ele[i].ecc2 + ele[j].ecc2) * P_DF(ecc2,inc2));

  }

  tmp *= sqrt(AXIS);

  return tmp;
}

double dinc2dt(int i,CONST struct elements ele[]){
  int j;
  double tmp=0.0;
  double ecc2=0.0,inc2=0.0;

  for(j=judge_ini(i);j<=judge_fin(i);j++){

    ecc2 = (ele[i].ecc2 + ele[j].ecc2)/(Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele));
    inc2 = (ele[i].inc2 + ele[j].inc2)/(Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele));

    tmp += N_s(j,ele) * Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele)*ele[j].eachmass/(ele[i].eachmass + ele[j].eachmass)/(ele[i].eachmass + ele[j].eachmass) * (ele[j].eachmass * Q_VS(ecc2,inc2) + (ele[j].eachmass * ele[j].inc2 - ele[i].eachmass * ele[i].inc2) / (ele[i].inc2 + ele[j].inc2) * Q_DF(ecc2,inc2));

  }
  tmp *= sqrt(AXIS);

  return tmp;
}

#if FRAGMENTATION
double s_1_FRAG_integrand(double x,CONST struct parameter *para_p){
  return exp((2.0 - (para_p->alpha))*x)/(1.0 + exp(x));
}
#endif


#if FRAGMENTATION
double s_1_FRAG(CONST struct parameter *para_p){
  int n,nmax=N_DIVIDE_S;
  double ini=-100.0,fin=100.0;
  double dx=0.0;
  double sum=0.0,sum_next=0.0;

  do{
    sum = sum_next;
    sum_next = 0.0;
    dx = (fin-ini)/2.0/((double)nmax);

    /* simpson : dx(f(ndx)+ 4f((n+1)dx)+ f((n+2)dx))/6 = dx'(f(2ndx')+ 4f((2n+1)dx')+ f((2n+2)dx'))/3 , dx' = dx/2 */
    for(n=0;n<nmax;n++){
      sum_next += dx * (s_1_FRAG_integrand(ini+2.0*n*dx,para_p) + 4.0*s_1_FRAG_integrand(ini+(2.0*n+1)*dx,para_p) + s_1_FRAG_integrand(ini+(2.0*n+2)*dx,para_p)) / 3.0;
    }
#if ACCURACY_CHECK
    //printf("s_1\tnmax=%d\t%e\n",nmax,fabs((sum-sum_next)/sum_next));
#endif
    nmax *= 2;
  }while(
#if ACCURACY_CHECK
	 fabs((sum-sum_next)/sum_next)>EPS_S && nmax<=16384
#else
	 false
#endif
	 );

  return sum_next;
}
#endif

#if FRAGMENTATION
double s_2_FRAG_integrand(double x,CONST struct parameter *para_p){
  return - exp((2.0 - (para_p->alpha))*x)/(1.0 + exp(x))*(x - 2.0*log(1.0 + exp(x)));
}
#endif

#if FRAGMENTATION
double s_2_FRAG(CONST struct parameter *para_p){
  int n,nmax=N_DIVIDE_S;
  double ini=-100.0,fin=100.0;
  double dx=0.0;
  double sum=0.0,sum_next=0.0;

  do{
    sum = sum_next;
    sum_next = 0.0;
    dx = (fin-ini)/2.0/((double)nmax);

    /* simpson : dx(f(ndx)+ 4f((n+1)dx)+ f((n+2)dx))/6 = dx'(f(2ndx')+ 4f((2n+1)dx')+ f((2n+2)dx'))/3 , dx' = dx/2 */
    for(n=0;n<nmax;n++){
      sum_next += dx * (s_2_FRAG_integrand(ini+2.0*n*dx,para_p) + 4.0*s_2_FRAG_integrand(ini+(2.0*n+1)*dx,para_p) + s_2_FRAG_integrand(ini+(2.0*n+2)*dx,para_p)) / 3.0;
    }
#if ACCURACY_CHECK
    //printf("s_2\tnmax=%d\t%e\n",nmax,fabs((sum-sum_next)/sum_next));
#endif
    nmax *= 2;
  }while(
#if ACCURACY_CHECK
	 fabs((sum-sum_next)/sum_next)>EPS_S && nmax<=16384
#else
	 false
#endif
	 );

  return sum_next;
}
#endif

#if FRAGMENTATION
double s_3_FRAG_integrand(double x,CONST struct parameter *para_p){
  return exp((1.0 - (para_p->alpha))*x)/(1.0 + exp(x))*log(1.0 + exp(x));
}
#endif

#if FRAGMENTATION
double s_3_FRAG(CONST struct parameter *para_p){
  int n,nmax=N_DIVIDE_S;
  double ini=-36.0,fin=100.0;
  double dx=0.0;
  double sum=0.0,sum_next=0.0;

  do{
    sum = sum_next;
    sum_next = 0.0;
    dx = (fin-ini)/2.0/((double)nmax);

    /* simpson : dx(f(ndx)+ 4f((n+1)dx)+ f((n+2)dx))/6 = dx'(f(2ndx')+ 4f((2n+1)dx')+ f((2n+2)dx'))/3 , dx' = dx/2 */
    for(n=0;n<nmax;n++){
      sum_next += dx * (s_3_FRAG_integrand(ini+2.0*n*dx,para_p) + 4.0*s_3_FRAG_integrand(ini+(2.0*n+1)*dx,para_p) + s_3_FRAG_integrand(ini+(2.0*n+2)*dx,para_p)) / 3.0;
    }
#if ACCURACY_CHECK
    //printf("s_3\tnmax=%d\t%e\n",nmax,fabs((sum-sum_next)/sum_next));
#endif
    nmax *= 2;
  }while(
#if ACCURACY_CHECK
	 fabs((sum-sum_next)/sum_next)>EPS_S && nmax<=16384
#else
	 false
#endif
	 );

  return sum_next;
}
#endif

#if FRAGMENTATION
void Fragmentation(struct fragmentation *frag_p,CONST struct parameter *para_p, CONST struct elements ele[]){

  (frag_p->sigma) = ele[2].eachmass * N_s(2,ele);
  (frag_p->v_ave) = sqrt(2.0*(ele[2].ecc2 + ele[2].inc2)) / AXIS;
  (frag_p->flux) = - (2.0 - (para_p->alpha))*(2.0 - (para_p->alpha)) / cbrt(M_MAX) * (frag_p->sigma)*(frag_p->sigma) * sqrt(1.0/AXIS/AXIS/AXIS) * (para_p->h_0) * pow((frag_p->v_ave)*(frag_p->v_ave)*0.5/(para_p->Q_D),(para_p->alpha)-1.0) * ((- log(EPSILON_FRAG) + 1.0/(2.0-B_FRAG))*(para_p->s_1) + (para_p->s_2) + (para_p->s_3));
  (frag_p->dt_frag) = - XI * (frag_p->sigma) / (frag_p->flux);

  //printf("t_frag = %e[yr]\tdt_frag = %e[yr]\tsigma = %e\tv_ave = %e\tflux = %e\n",(frag_p->t_frag)/2.0/M_PI,(frag_p->dt_frag)/2.0/M_PI,(frag_p->sigma),(frag_p->v_ave),(frag_p->flux));

  return;
}
#endif


static inline double Min(double a, double b){
  if(a < b){
    return a;
  }else{
    return b;
  }
}


void Evolution(double *dt,
#if FRAGMENTATION
	       struct fragmentation *frag_p,
	       struct parameter *para_p,
#endif
	       struct elements *ele_p){

  int i;

  for(i=1;i<=2;i++){
    (ele_p+i)->ecc2_next = (ele_p+i)->ecc2 + decc2dt(i,ele_p) * (*dt);
    (ele_p+i)->inc2_next = (ele_p+i)->inc2 + dinc2dt(i,ele_p) * (*dt);
  }

#if FRAGMENTATION
  (ele_p+2)->eachmass_next = (ele_p+2)->eachmass / (1.0 + (*dt)/(- frag_p->sigma / frag_p->flux));
  (ele_p+2)->totalmass_next = (ele_p+2)->totalmass / (1.0 + (*dt)/(- frag_p->sigma / frag_p->flux));
#endif

  (*dt) = ETA * Min(fabs((ele_p+1)->ecc2 / decc2dt(1,ele_p)),fabs((ele_p+2)->ecc2 / decc2dt(2,ele_p)));  //離心率進化のタイムスケールのETA倍.

#if FRAGMENTATION
  Fragmentation(frag_p,para_p,ele_p);

  (*dt) = Min(*dt,frag_p->dt_frag);

  (ele_p+2)->eachmass = (ele_p+2)->eachmass_next;
  (ele_p+2)->totalmass = (ele_p+2)->totalmass_next;
#endif


  for(i=1;i<=2;i++){
    (ele_p+i)->ecc2 = (ele_p+i)->ecc2_next;
    (ele_p+i)->inc2 = (ele_p+i)->inc2_next;
  }

  return;
}


int main(){

  int i,step=0;
  double t=0.0,dt=0.0,t_check=2.0*M_PI*1E-3;
  static struct elements ele[3]={};
#if FRAGMENTATION
  static struct fragmentation frag;
  static struct parameter para;
#endif
  FILE *fpdata;
  char datafile[200]={};
  //FILE *fptest;
  //char testfile[200]={};

  mkdir(STR(DIRECTORY), 0755);  //ディレクトリを作成. 755 = rwxr-xr-x.


#if FRAGMENTATION
  para.alpha = (11.0 + 3.0*P_FRAG)/(6.0 + 3.0*P_FRAG);
  para.s_1 = s_1_FRAG(&para);
  para.s_2 = s_2_FRAG(&para);
  para.s_3 = s_3_FRAG(&para);
  para.h_0 = 0.061*17.3*pow(1.68E6*RHO,-2.0/3.0);  // g/cc = 1.68E6 M_0/AU^3, F(I) = 17.3 として.
  para.Q_D = Q_0_FRAG*1.13E-13*pow(RHO/3.0,0.55)*pow(M_MAX*1.989E12,P_FRAG);  //erg/g = 1.13E-13 AU^2/(yr/2pi)^2 として.

  printf("alpha=%g\ts_1=%g\ts_2=%g\ts_3=%g\th_0=%g\tQ_D=%g\n",
	 para.alpha,
	 para.s_1,
	 para.s_2,
	 para.s_3,
	 para.h_0,
	 para.Q_D
	 );
#endif


  sprintf(ele[1].name,"Planet");
  ele[1].eachmass = PLANET_EACHMASS;
  ele[1].totalmass = PLANET_TOTALMASS;
  ele[1].ecc2 = ECC_RMS*ECC_RMS;
  ele[1].inc2 = INC_RMS*INC_RMS;

  sprintf(ele[2].name,"Planetesimal");
  ele[2].eachmass = PLANETESIMAL_EACHMASS;
  ele[2].totalmass = PLANETESIMAL_TOTALMASS;
  ele[2].ecc2 = ECC_RMS*ECC_RMS;
  ele[2].inc2 = INC_RMS*INC_RMS;

  for(i=1;i<=2;i++){
    sprintf(datafile,"%s%s.dat",STR(DIRECTORY),ele[i].name);
    fpdata = fopen(datafile,"w");
    if(fpdata==NULL){
      printf("datafile error 0\n");
      return -1;
    }

    fprintf(fpdata,"#t[yr]\tecc\tinc\teachmass\ttotalmass\n");
    fprintf(fpdata,"%e\t%.15e\t%.15e\t%.15e\t%.15e\n",
	    t/2.0/M_PI,
	    sqrt(ele[i].ecc2),
	    sqrt(ele[i].inc2),
	    ele[i].eachmass,
	    ele[i].totalmass
	    );
    fclose(fpdata);
  }


  dt = ETA * Min(fabs(ele[1].ecc2 / decc2dt(1,ele)),fabs(ele[2].ecc2 / decc2dt(2,ele)));  //離心率進化のタイムスケールのETA倍.


#if FRAGMENTATION
  /* 初期 */
  Fragmentation(&frag,&para,ele);

  dt = Min(dt,frag.dt_frag);
  /*
  if(dt > frag.dt_frag){
    //printf("\tdt = %e [yr] > dt_frag = %e [yr]\n",dt/2.0/M_PI,frag.dt_frag/2.0/M_PI);

    dt = frag.dt_frag;

    //printf("\t=> dt = %e [yr]\n",dt/2.0/M_PI);
  }
  */
#endif

  printf("dt_0 = %e [yr]\n",dt/2.0/M_PI);

  while(t < T_MAX){

    //printf("------------------------------------\n");
    printf("t = %e [yr]\n",t/2.0/M_PI);

    if(t + dt < t_check){

      t += dt;

      Evolution(&dt,
#if FRAGMENTATION
		&frag,
		&para,
#endif
		ele);

      for(i=1;i<=2;i++){
	sprintf(datafile,"%s%s.dat",STR(DIRECTORY),ele[i].name);
	fpdata = fopen(datafile,"a");
	if(fpdata==NULL){
	  printf("datafile error\n");
	  return -1;
	}

	fprintf(fpdata,"%e\t%.15e\t%.15e\t%.15e\t%.15e\n",
		t/2.0/M_PI,
		sqrt(ele[i].ecc2),
		sqrt(ele[i].inc2),
		ele[i].eachmass,
		ele[i].totalmass
		);
	fclose(fpdata);
      }

    }else{  //t_checkに時間を揃える.

      printf("check %e [yr]\n",t_check/2.0/M_PI);

      dt = t_check - t;
      t = t_check;

      Evolution(&dt,
#if FRAGMENTATION
		&frag,
		&para,
#endif
		ele);

      for(i=1;i<=2;i++){
	sprintf(datafile,"%s%s.dat",STR(DIRECTORY),ele[i].name);
	fpdata = fopen(datafile,"a");
	if(fpdata==NULL){
	  printf("datafile error\n");
	  return -1;
	}

	fprintf(fpdata,"%e\t%.15e\t%.15e\t%.15e\t%.15e\n",
		t/2.0/M_PI,
		sqrt(ele[i].ecc2),
		sqrt(ele[i].inc2),
		ele[i].eachmass,
		ele[i].totalmass
		);
	fclose(fpdata);
      }

      //t_check *= pow(10.0,1.0/8.0);
      t_check *= 10.0;
    }

    step += 1;
  }

  printf("step = %d\n",step);


  /*
  double lambda;
  for(lambda=0.0;lambda<=1.0;lambda+=0.001){
    printf("%.15e\t%.15e\t%.15e\n",sqrt(3.0*(1.0-lambda*lambda))/2.0,K_lambda(lambda),E_lambda(lambda));
  }
  */

  /*
  sprintf(testfile,"%stest_beta%s.dat",STR(DIRECTORY),STR(BETA));
  fptest = fopen(testfile,"w");
  if(fptest==NULL){
    printf("testfile error 0\n");
    return -1;
  }

  fprintf(fptest,"#ecc\tinc\tP_VS\tQ_VS\tP_DF\tQ_DF\n");

  ecc2 = 0.0025;
  inc2 = BETA*BETA*ecc2;
  while(ecc2<=2500.0){
    printf("ecc = %e\n",sqrt(ecc2));
    fpdata = fopen(datafile,"w");
    fprintf(fptest,"%.15e\t%.15e\t%.15e\t%.15e\t%.15e\t%.15e\n",sqrt(ecc2),sqrt(inc2),P_VS(ecc2,inc2),Q_VS(ecc2,inc2),P_DF(ecc2,inc2),Q_DF(ecc2,inc2));

    ecc2 *= tmp;
    inc2 = BETA*BETA*ecc2;
  }

  fclose(fptest);
  */




  /*
  sprintf(testfile,"%stest_I.dat",STR(DIRECTORY));
  fptest = fopen(testfile,"w");
  if(fptest==NULL){
    printf("testfile error 0\n");
    return -1;
  }

  fprintf(fptest,"#beta\tI_PVS\tI_PDF\tI_QVS\tI_QDF\n");

  double beta=0.001,dbeta=pow(10.0,1.0/149.0);
  while(beta<=10.0){
    printf("beta = %e\n",beta);
    fpdata = fopen(datafile,"w");
    fprintf(fptest,"%.15e\t%.15e\t%.15e\t%.15e\t%.15e\n",beta,72.0/M_PI*I_PVS(beta)/beta,576.0/M_PI*I_PDF(beta)/beta,72.0/M_PI*I_QVS(beta)/beta,576.0/M_PI*I_QDF(beta)/beta);
    //fprintf(fptest,"%.15e\t%.15e\t%.15e\t%.15e\t%.15e\n",beta,I_PVS(beta),I_PDF(beta),I_QVS(beta),I_QDF(beta));

    beta *= dbeta;
  }

  fclose(fptest);
  */


  /*
  sprintf(testfile,"%stest_integrand.dat",STR(DIRECTORY));
  fptest = fopen(testfile,"w");
  if(fptest==NULL){
    printf("testfile error 0\n");
    return -1;
  }

  fprintf(fptest,"#beta\tI_PVS'\tI_PDF'\tI_QVS'\tI_QDF'\n");

  t=0.0;
  dt=0.0001;
  double beta = BETA;
  while(t<0.5*M_PI){
    printf("t = %e\n",t);
    fpdata = fopen(datafile,"w");
    fprintf(fptest,"%.15e\t%.15e\t%.15e\t%.15e\t%.15e\n",t,I_PVS_integrand(beta,t),I_PDF_integrand(beta,t),I_QVS_integrand(beta,t),I_QDF_integrand(beta,t));

    t += dt;
  }

  fclose(fptest);
  */

  return 0;
}
