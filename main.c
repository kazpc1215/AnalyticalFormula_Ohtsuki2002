#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <sys/stat.h>
#include <stdbool.h>

#define DIRECTORY ./Meach3E-8_Mtot3E-5_t1E3_dt1E-2_ecc5E-2_nofrag_br/  //ディレクトリ.

#define STR_(str) #str
#define STR(str) STR_(str)

//#define N_DIVIDE_KE 64
#define N_DIVIDE_I 64

#define BACKREACTION true
#define FRAGMENTATION true

#define ACCURACY_CHECK true
#define EPS_KE 1.0E-10
#define EPS_I 1.0E-10
//#define EPS 1.0E-6

#define T_MAX (2.0*M_PI*1.0E3)
#define DT (2.0*M_PI*1.0E-2)
//#define DT_CHECK (2.0*M_PI*1.0E-1)

#define PLANET_EACHMASS 3.0E-6
#define PLANET_TOTALMASS 3.0E-6

#define PLANETESIMAL_EACHMASS 3.0E-8
#define PLANETESIMAL_TOTALMASS 3.0E-5

#define AXIS 1.0
#define BETA 0.5

#define ECC_RMS 5.0E-2
#define INC_RMS (BETA*ECC_RMS)


#if FRAGMENTATION
#define RHO 3.0  // [g/cc]  微惑星の物質密度.
#define EPSILON_FRAG 0.2
#define B_FRAG (5.0/3.0)
#define Q_0_FRAG 9.5E8 // [erg/g]  Q_D = Q_0*(rho/3[g/cc])^0.55*(m/10^21[g])^p
#define P_FRAG 0.453
#define XI 0.01 //統計的計算のタイムステップがタイムスケールの"XI"倍.
#define M_MAX 5.00E-15  //最大微惑星質量. 1E19 g = 10kmサイズ.
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
    nmax *= 2;
    dt = (fin-ini)/2.0/((double)nmax);

    /* simpson : dx(f(ndx)+ 4f((n+1)dx)+ f((n+2)dx))/6 = dx'(f(2ndx')+ 4f((2n+1)dx')+ f((2n+2)dx'))/3 , dx' = dx/2 */
    for(n=0;n<nmax;n++){
      sum_next += dt * (I_PVS_integrand(beta, ini+2.0*n*dt) + 4.0*I_PVS_integrand(beta, ini+(2.0*n+1)*dt) + I_PVS_integrand(beta, ini+(2.0*n+2)*dt)) / 3.0;
    }
#if ACCURACY_CHECK
    //printf("I_PVS\tnmax=%d\t%e\n",nmax,fabs((sum-sum_next)/sum_next));
#endif
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
    nmax *= 2;
    dt = (fin-ini)/2.0/((double)nmax);

     /* simpson : dx(f(ndx)+ 4f((n+1)dx)+ f((n+2)dx))/6 = dx'(f(2ndx')+ 4f((2n+1)dx')+ f((2n+2)dx'))/3 , dx' = dx/2 */
    for(n=0;n<nmax;n++){
      sum_next += dt * (I_QVS_integrand(beta, ini+2.0*n*dt) + 4.0*I_QVS_integrand(beta, ini+(2.0*n+1)*dt) + I_QVS_integrand(beta, ini+(2.0*n+2)*dt)) / 3.0;
    }
#if ACCURACY_CHECK
    //printf("I_QVS\tnmax=%d\t%e\n",nmax,fabs((sum-sum_next)/sum_next));
#endif
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
    nmax *= 2;
    dt = (fin-ini)/2.0/((double)nmax);

    /* simpson : dx(f(ndx)+ 4f((n+1)dx)+ f((n+2)dx))/6 = dx'(f(2ndx')+ 4f((2n+1)dx')+ f((2n+2)dx'))/3 , dx' = dx/2 */
    for(n=0;n<nmax;n++){
      sum_next += dt * (I_PDF_integrand(beta, ini+2.0*n*dt) + 4.0*I_PDF_integrand(beta, ini+(2.0*n+1)*dt) + I_PDF_integrand(beta, ini+(2.0*n+2)*dt)) / 3.0;
    }
#if ACCURACY_CHECK
    //printf("I_PDF\tnmax=%d\t%e\n",nmax,fabs((sum-sum_next)/sum_next));
#endif
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
    nmax *= 2;
    dt = (fin-ini)/2.0/((double)nmax);

     /* simpson : dx(f(ndx)+ 4f((n+1)dx)+ f((n+2)dx))/6 = dx'(f(2ndx')+ 4f((2n+1)dx')+ f((2n+2)dx'))/3 , dx' = dx/2 */
    for(n=0;n<nmax;n++){
      sum_next += dt * (I_QDF_integrand(beta, ini+2.0*n*dt) + 4.0*I_QDF_integrand(beta, ini+(2.0*n+1)*dt) + I_QDF_integrand(beta, ini+(2.0*n+2)*dt)) / 3.0;
    }
#if ACCURACY_CHECK
    //printf("I_QDF\tnmax=%d\t%e\n",nmax,fabs((sum-sum_next)/sum_next));
#endif
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

int BR_judge(int i){
#if BACKREACTION
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

  for(j=1;j<=BR_judge(i);j++){

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

  for(j=1;j<=BR_judge(i);j++){

    ecc2 = (ele[i].ecc2 + ele[j].ecc2)/(Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele));
    inc2 = (ele[i].inc2 + ele[j].inc2)/(Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele));

    tmp += N_s(j,ele) * Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele)*ele[j].eachmass/(ele[i].eachmass + ele[j].eachmass)/(ele[i].eachmass + ele[j].eachmass) * (ele[j].eachmass * Q_VS(ecc2,inc2) + (ele[j].eachmass * ele[j].inc2 - ele[i].eachmass * ele[i].inc2) / (ele[i].inc2 + ele[j].inc2) * Q_DF(ecc2,inc2));

  }
  tmp *= sqrt(AXIS);

  return tmp;
}

#if FRAGMENTATION
double Depletion_Time(int i,CONST struct fragmentation *frag_p){
  return -XI*((frag_p+i)->sigma)/((frag_p+i)->flux);
}
#endif


#if FRAGMENTATION
double s_1_FRAG_integrand(double x,CONST struct parameter *para_p){
  return exp((2.0 - (para_p->alpha))*x)/(1.0 + exp(x));
}
#endif


#if FRAGMENTATION
double s_2_FRAG_integrand(double x,CONST struct parameter *para_p){
  return - exp((2.0 - (para_p->alpha))*x)/(1.0 + exp(x))*(x - 2.0*log(1 + exp(x)));
}
#endif


#if FRAGMENTATION
double s_3_FRAG_integrand(double x,CONST struct parameter *para_p){
  return exp((1.0 - (para_p->alpha))*x)/(1.0 + exp(x))*log(1.0 + exp(x));
}
#endif

#if FRAGMENTATION
double s_1_FRAG_trapezoid(int n,double dx,double ini,CONST struct parameter *para_p){
  return 0.5*dx*(s_1_FRAG_integrand(ini+n*dx,para_p)+s_1_FRAG_integrand(ini+(n+1)*dx,para_p));
}
#endif


#if FRAGMENTATION
double s_2_FRAG_trapezoid(int n,double dx,double ini,CONST struct parameter *para_p){
  return 0.5*dx*(s_2_FRAG_integrand(ini+n*dx,para_p)+s_2_FRAG_integrand(ini+(n+1)*dx,para_p));
}
#endif


#if FRAGMENTATION
double s_3_FRAG_trapezoid(int n,double dx,double ini,CONST struct parameter *para_p){
  return 0.5*dx*(s_3_FRAG_integrand(ini+n*dx,para_p)+s_3_FRAG_integrand(ini+(n+1)*dx,para_p));
}
#endif



#if FRAGMENTATION
double s_1_FRAG(struct parameter *para_p){
  int n,n_max;
  double dx,sum=0.0,sum_pre=0.0;
  double ini=-36.0,fin=36.0;
  double eps=1.0E-7;

  n_max = 1;
  do{
    dx = (fin-ini)/(double)n_max;
    sum_pre = sum;
    sum=0;
    for(n=0;n<n_max;n++){
      sum += s_1_FRAG_trapezoid(n, dx, ini, para_p);
    }
    //fprintf(fplog,"n_max=%d\n",n_max);
    n_max *= 2;
  }while(fabs(sum_pre-sum)>eps);

  return sum;
}
#endif


#if FRAGMENTATION
double s_2_FRAG(struct parameter *para_p){
    int n,n_max;
  double dx,sum=0.0,sum_pre=0.0;
  double ini=-36.0,fin=36.0;
  double eps=1.0E-7;

  n_max = 1;
  do{
    dx = (fin-ini)/(double)n_max;
    sum_pre = sum;
    sum=0;
    for(n=0;n<n_max;n++){
      sum += s_2_FRAG_trapezoid(n, dx, ini, para_p);
    }
    //fprintf(fplog,"n_max=%d\n",n_max);
    n_max *= 2;
  }while(fabs(sum_pre-sum)>eps);

  return sum;
}
#endif


#if FRAGMENTATION
double s_3_FRAG(struct parameter *para_p){
  int n,n_max;
  double dx,sum=0.0,sum_pre=0.0;
  double ini=-36.0,fin=36.0;
  double eps=1.0E-7;

  n_max = 1;
  do{
    dx = (fin-ini)/(double)n_max;
    sum_pre = sum;
    sum=0;
    for(n=0;n<n_max;n++){
      sum += s_3_FRAG_trapezoid(n, dx, ini, para_p);
    }
    //fprintf(fplog,"n_max=%d\n",n_max);
    n_max *= 2;
  }while(fabs(sum_pre-sum)>eps);

  return sum;
}
#endif


double mass_dep(CONST struct fragmentation frag, CONST struct elements ele[]){

  frag.sigma = ele[2].eachmass * N_s(2,ele);
  frag.v_ave = sqrt(2.0*(ele[2].ecc2 + ele[2].inc2)) / AXIS;
  frag.flux = 0.0;

  return 0.0;
}

int main(){

  int i;
  double t=0.0,dt=DT,t_check=DT*10.0;
  //double ecc2=0.0,inc2=0.0,tmp=pow(10.0,0.01);
  static struct elements ele[3]={};
  static struct fragmentation frag;
  struct parameter para;
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

  do{

    t += dt;

    for(i=1;i<=2;i++){
      ele[i].ecc2_next = ele[i].ecc2 + decc2dt(i,ele) * dt;
      ele[i].inc2_next = ele[i].inc2 + dinc2dt(i,ele) * dt;
    }

#if FRAGMENTATION

#else
    ele[2].eachmass_next = ele[2].eachmass;
    ele[2].totalmass_next = ele[2].totalmass;
#endif


    for(i=1;i<=2;i++){
      ele[i].ecc2 = ele[i].ecc2_next;
      ele[i].inc2 = ele[i].inc2_next;
    }

    if(t-t_check>=0.0){
      printf("%f\n",t/2.0/M_PI);
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
      t_check *= pow(10.0,0.05);
    }


  }while(t<=T_MAX);


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
