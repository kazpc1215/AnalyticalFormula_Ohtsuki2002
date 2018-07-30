#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <sys/stat.h>
#include <stdbool.h>

#define DIRECTORY ./Meach3E-8_Mtot3E-5_t1E3_dt1E-2_ecc1E-2_nofrag/  //ディレクトリ.

#define STR_(str) #str
#define STR(str) STR_(str)

//#define N_DIVIDE_KE 64
#define N_DIVIDE_I 65536

#define ACCURACY_CHECK true
#define EPS_KE 1.0E-10
#define EPS_I 1.0E-5

#define T_MAX (2.0*M_PI*1.0E3)
#define DT (2.0*M_PI*1.0E-2)
#define DT_CHECK (2.0*M_PI*1.0E0)

#define PLANET_EACHMASS 3.0E-6
#define PLANET_TOTALMASS 3.0E-6

#define PLANETESIMAL_EACHMASS 3.0E-8
#define PLANETESIMAL_TOTALMASS 3.0E-5

#define ECC_RMS 5.0E-2
#define INC_RMS (0.5*ECC_RMS)

#define AXIS 1.0
#define BETA 0.1

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

static inline ALWAYS_INLINE double MutualHill_Ratio(double ratio){
  return (1.0/ratio + 0.5*cbrt(2.0*PLANET_EACHMASS/3.0))/(1.0/ratio - 0.5*cbrt(2.0*PLANET_EACHMASS/3.0));
}

static inline ALWAYS_INLINE double Reduced_Hill(int i, int j,CONST struct elements ele[]){
  return cbrt((ele[i].eachmass + ele[j].eachmass) / 3.0);
}

static inline ALWAYS_INLINE double K_lambda_integrand(double lambda, double theta){
  return 1.0 / sqrt(1.0 - 0.75 * (1.0 - lambda*lambda) * sin(theta)*sin(theta));
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

static inline ALWAYS_INLINE double E_lambda_integrand(double lambda, double theta){
  return sqrt(1.0 - 0.75 * (1.0 - lambda*lambda) * sin(theta)*sin(theta));
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

static inline ALWAYS_INLINE double I_PVS_integrand(double beta, double lambda){
  return (5.0 * K_lambda(lambda) - 12.0*(1.0-lambda*lambda)/(1.0+3.0*lambda*lambda) * E_lambda(lambda)) / (beta + (1.0/beta - beta) * lambda*lambda);
}

double I_PVS(double beta){

  int n,nmax=N_DIVIDE_I;
  double ini=0.0,fin=1.0;
  double dlambda=0.0;
  double sum=0.0,sum_next=0.0;

  do{
    sum = sum_next;
    sum_next = 0.0;
    nmax *= 2;
    dlambda = (fin-ini)/2.0/((double)nmax);

    /* simpson : dx*(f(n*dx)+ 4*f((n+1)*dx)+ f((n+2)*dx))/3 */
    for(n=0;n<nmax;n++){
      sum_next += dlambda * (I_PVS_integrand(beta, ini+n*dlambda) + 4.0*I_PVS_integrand(beta, ini+(n+1)*dlambda) + I_PVS_integrand(beta, ini+(n+2)*dlambda)) / 3.0;
    }
#if ACCURACY_CHECK
    printf("I_PVS\tnmax=%d\t%e\n",nmax,fabs((sum-sum_next)/sum_next));
#endif
  }while(
#if ACCURACY_CHECK
	 fabs((sum-sum_next)/sum_next)>EPS_I
#else
	 false
#endif
	 );

  return sum_next;
}

static inline ALWAYS_INLINE double I_QVS_integrand(double beta, double lambda){
  return (K_lambda(lambda) - 12.0*lambda*lambda/(1.0+3.0*lambda*lambda) * E_lambda(lambda)) / (beta + (1.0/beta - beta) * lambda*lambda);
}

double I_QVS(double beta){

  int n,nmax=N_DIVIDE_I;
  double ini=0.0,fin=1.0;
  double dlambda=0.0;
  double sum=0.0,sum_next=0.0;

  do{
    sum = sum_next;
    sum_next = 0.0;
    nmax *= 2;
    dlambda = (fin-ini)/2.0/((double)nmax);

    /* simpson : dx*(f(n*dx)+ 4*f((n+1)*dx)+ f((n+2)*dx))/3 */
    for(n=0;n<nmax;n++){
      sum_next += dlambda * (I_QVS_integrand(beta, ini+n*dlambda) + 4.0*I_QVS_integrand(beta, ini+(n+1)*dlambda) + I_QVS_integrand(beta, ini+(n+2)*dlambda)) / 3.0;
    }
#if ACCURACY_CHECK
    printf("I_QVS\tnmax=%d\t%e\n",nmax,fabs((sum-sum_next)/sum_next));
#endif
  }while(
#if ACCURACY_CHECK
	 fabs((sum-sum_next)/sum_next)>EPS_I
#else
	 false
#endif
	 );

  return sum_next;
}

static inline ALWAYS_INLINE double I_PDF_integrand(double beta, double lambda){
  return ((1.0-lambda*lambda)/(1.0+3.0*lambda*lambda) * E_lambda(lambda)) / (beta + (1.0/beta - beta) * lambda*lambda);
}

double I_PDF(double beta){

  int n,nmax=N_DIVIDE_I;
  double ini=0.0,fin=1.0;
  double dlambda=0.0;
  double sum=0.0,sum_next=0.0;

  do{
    sum = sum_next;
    sum_next = 0.0;
    nmax *= 2;
    dlambda = (fin-ini)/2.0/((double)nmax);

    /* simpson : dx*(f(n*dx)+ 4*f((n+1)*dx)+ f((n+2)*dx))/3 */
    for(n=0;n<nmax;n++){
      sum_next += dlambda * (I_PDF_integrand(beta, ini+n*dlambda) + 4.0*I_PDF_integrand(beta, ini+(n+1)*dlambda) + I_PDF_integrand(beta, ini+(n+2)*dlambda)) / 3.0;
    }
#if ACCURACY_CHECK
    printf("I_PDF\tnmax=%d\t%e\n",nmax,fabs((sum-sum_next)/sum_next));
#endif
  }while(
#if ACCURACY_CHECK
	 fabs((sum-sum_next)/sum_next)>EPS_I
#else
	 false
#endif
	 );

  return sum_next;
}

static inline ALWAYS_INLINE double I_QDF_integrand(double beta, double lambda){
  return (lambda*lambda/(1.0+3.0*lambda*lambda) * E_lambda(lambda)) / (beta + (1.0/beta - beta) * lambda*lambda);
}

double I_QDF(double beta){

  int n,nmax=N_DIVIDE_I;
  double ini=0.0,fin=1.0;
  double dlambda=0.0;
  double sum=0.0,sum_next=0.0;

  do{
    sum = sum_next;
    sum_next = 0.0;
    nmax *= 2;
    dlambda = (fin-ini)/2.0/((double)nmax);

    /* simpson : dx*(f(n*dx)+ 4*f((n+1)*dx)+ f((n+2)*dx))/3 */
    for(n=0;n<nmax;n++){
      sum_next += dlambda * (I_QDF_integrand(beta, ini+n*dlambda) + 4.0*I_QDF_integrand(beta, ini+(n+1)*dlambda) + I_QDF_integrand(beta, ini+(n+2)*dlambda)) / 3.0;
    }
#if ACCURACY_CHECK
    printf("I_QDF\tnmax=%d\t%e\n",nmax,fabs((sum-sum_next)/sum_next));
#endif
  }while(
#if ACCURACY_CHECK
	 fabs((sum-sum_next)/sum_next)>EPS_I
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

double decc2dt(int i,CONST struct elements ele[]){
  int j;
  double tmp=0.0;
  double ecc2=0.0,inc2=0.0;

  for(j=1;j<=2;j++){

    ecc2 = ele[i].ecc2 + ele[j].ecc2;
    inc2 = ele[i].inc2 + ele[j].inc2;

    tmp += N_s(j,ele) * Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele)*ele[j].eachmass/(ele[i].eachmass + ele[j].eachmass)/(ele[i].eachmass + ele[j].eachmass) * (ele[j].eachmass * P_VS(ecc2,inc2) + (ele[j].eachmass * ele[j].ecc2 - ele[i].eachmass * ele[i].ecc2) / ecc2 * P_DF(ecc2,inc2));
  }

  tmp *= sqrt(AXIS);

  return tmp;
}

double dinc2dt(int i,CONST struct elements ele[]){
  int j;
  double tmp=0.0;
  double ecc2=0.0,inc2=0.0;

  for(j=1;j<=2;j++){

    ecc2 = ele[i].ecc2 + ele[j].ecc2;
    inc2 = ele[i].inc2 + ele[j].inc2;

    tmp += N_s(j,ele) * Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele)*Reduced_Hill(i,j,ele)*ele[j].eachmass/(ele[i].eachmass + ele[j].eachmass)/(ele[i].eachmass + ele[j].eachmass) * (ele[j].eachmass * Q_VS(ecc2,inc2) + (ele[j].eachmass * ele[j].inc2 - ele[i].eachmass * ele[i].inc2) / inc2 * Q_DF(ecc2,inc2));
  }

  tmp *= sqrt(AXIS);

  return tmp;
}


int main(){

  int i,step;
  double t=0.0,dt=DT,t_check=DT_CHECK;
  double ecc2=0.0,inc2=0.0,tmp=pow(10.0,0.01);
  static struct elements ele[3]={};
  FILE *fpdata;
  char datafile[200]={};
  FILE *fptest;
  char testfile[200]={};

  mkdir(STR(DIRECTORY), 0755);  //ディレクトリを作成. 755 = rwxr-xr-x.

  /*
  double lambda;
  for(lambda=0.0;lambda<=1.0;lambda+=0.001){
    printf("%.15e\t%.15e\t%.15e\n",sqrt(3.0*(1.0-lambda*lambda))/2.0,K_lambda(lambda),E_lambda(lambda));
  }
  */


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


  /*
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

    while(t<=T_MAX){

    for(i=1;i<=2;i++){
    ele[i].ecc2_next = ele[i].ecc2 + decc2dt(i,ele) * dt;
    ele[i].inc2_next = ele[i].inc2 + dinc2dt(i,ele) * dt;
    }

    ele[2].eachmass_next = ele[2].eachmass;
    ele[2].totalmass_next = ele[2].totalmass;



    for(i=1;i<=2;i++){
    ele[i].ecc2 = ele[i].ecc2_next;
    ele[i].inc2 = ele[i].inc2_next;
    }

    if(fabs(t-t_check)<EPS){
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
    t_check += DT_CHECK;
    }


    t += dt;
    printf("%f\n",t/2.0/M_PI);
    }
  */

  return 0;
}
