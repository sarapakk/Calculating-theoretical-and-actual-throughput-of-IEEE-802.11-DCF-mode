clc
clear
close all
z=1;
for n=2:2:10
window=ones(1,n)+1;%indicates the window size of users    
count=0;%indicates #zero backoff in each step
suc_tr_num=0;%# successful tx
used_time=0;
a=zeros(1,n);
bkf_t=randi(2,1,n)-1;%denotes the backoff time vector
while used_time<100000
    count=0;
for i=1:n
    if bkf_t(i)==0
        count=count+1;
        a(i)=1;
        m=i;
    end
  end
if count==0 %%% idle slot
    bkf_t=bkf_t-1;
    used_time=used_time+1;
elseif count==1  %%% successful tx
    used_time=used_time+18; 
    suc_tr_num=suc_tr_num+1;
    bkf_t=bkf_t-1;
    bkf_t(m)=randi(2,1,1)-1;
    window(m)=2; %%%reset the window
elseif count>=1 %%% collision
    for g=1:n
        if a(g)==1
        if window(g)<64
            window(g)=2*window(g);    
        end
        bkf_t(g)=randi(window(g),1,1);
        end
    end
    used_time=used_time+3;
    bkf_t=bkf_t-1;
end
end
throughput(z)=100*suc_tr_num/used_time;
z=z+1;
end
plot(2:2:10,throughput,'b')    
grid on
ylabel('Throughput')
xlabel('Number of nodes')