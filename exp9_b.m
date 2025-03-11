%Monte-Carlo Simulation
Eb=1;
EbN0_db=0:5:35;
No_over_2=Eb*10.^(-EbN0_db/10);
sigma=1;
var=sigma^2;
BER=zeros(1,length(EbN0_db));
for i=1:length(EbN0_db)
    no_error=0;
    no_bits=0;
    while no_error<=10
        u=rand;
        alpha=sigma*sqrt(-2*log(u));
        noise=sqrt(No_over_2(i))*randn;
        y=alpha*sqrt(Eb)+noise;
        if y<=0
            y_d=1;
        else
            y_d=0;
        end
        no_bits=no_bits+1;
        no_error=no_error+y_d;
    end
    BER(i)=no_error/no_bits;
end
rho_b=Eb./No_over_2*var;
P2=(1/2)*(1-sqrt(rho_b./(rho_b+1)));
semilogy(EbN0_db,BER,'-*',EbN0_db,P2,'-o');
title("Monte Carlo simulation for performance of BPSK signal");
xlabel("Average SNR/bit(dB)");
ylabel("Error Probability");
legend('Monte Carlo Simulation','Theoretical Value');
grid on;