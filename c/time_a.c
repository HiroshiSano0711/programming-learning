#include <stdio.h>
#include <time.h>
int main(int argc, char **argv) {
  struct timespec ts;
  printf("time():  %10ld\n", time(NULL));
  clock_getres(CLOCK_REALTIME, &ts);
  printf("res :    %10ld.%09ld CLOCK_REALTIME\n", ts.tv_sec, ts.tv_nsec);
  clock_gettime(CLOCK_REALTIME, &ts);
  printf("time:    %10ld.%09ld CLOCK_REALTIME\n", ts.tv_sec, ts.tv_nsec);
#ifdef CLOCK_REALTIME_COARSE
  clock_getres(CLOCK_REALTIME_COARSE, &ts);
  printf("res :    %10ld.%09ld CLOCK_REALTIME_COARSE\n", ts.tv_sec, ts.tv_nsec);
  clock_gettime(CLOCK_REALTIME_COARSE, &ts);
  printf("time:    %10ld.%09ld CLOCK_REALTIME_COARSE\n", ts.tv_sec, ts.tv_nsec);
#endif
  clock_getres(CLOCK_MONOTONIC, &ts);
  printf("res :    %10ld.%09ld CLOCK_MONOTONIC\n", ts.tv_sec, ts.tv_nsec);
  clock_gettime(CLOCK_MONOTONIC, &ts);
  printf("time:    %10ld.%09ld CLOCK_MONOTONIC\n", ts.tv_sec, ts.tv_nsec);
#ifdef CLOCK_MONOTONIC_COARSE
  clock_getres(CLOCK_MONOTONIC_COARSE, &ts);
  printf("res :    %10ld.%09ld CLOCK_MONOTONIC_COARSE\n", ts.tv_sec, ts.tv_nsec);
  clock_gettime(CLOCK_MONOTONIC_COARSE, &ts);
  printf("time:    %10ld.%09ld CLOCK_MONOTONIC_COARSE\n", ts.tv_sec, ts.tv_nsec);
#endif
#ifdef CLOCK_MONOTONIC_RAW
  clock_getres(CLOCK_MONOTONIC_RAW, &ts);
  printf("res :    %10ld.%09ld CLOCK_MONOTONIC_RAW\n", ts.tv_sec, ts.tv_nsec);
  clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
  printf("time:    %10ld.%09ld CLOCK_MONOTONIC_RAW\n", ts.tv_sec, ts.tv_nsec);
#endif
#ifdef CLOCK_BOOTTIME
  clock_getres(CLOCK_BOOTTIME, &ts);
  printf("res :    %10ld.%09ld CLOCK_BOOTTIME\n", ts.tv_sec, ts.tv_nsec);
  clock_gettime(CLOCK_BOOTTIME, &ts);
  printf("time:    %10ld.%09ld CLOCK_BOOTTIME\n", ts.tv_sec, ts.tv_nsec);
#endif
  clock_getres(CLOCK_PROCESS_CPUTIME_ID, &ts);
  printf("res :    %10ld.%09ld CLOCK_PROCESS_CPUTIME_ID\n", ts.tv_sec, ts.tv_nsec);
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts);
  printf("time:    %10ld.%09ld CLOCK_PROCESS_CPUTIME_ID\n", ts.tv_sec, ts.tv_nsec);
  clock_getres(CLOCK_THREAD_CPUTIME_ID, &ts);
  printf("res :    %10ld.%09ld CLOCK_THREAD_CPUTIME_ID\n", ts.tv_sec, ts.tv_nsec);
  clock_gettime(CLOCK_THREAD_CPUTIME_ID, &ts);
  printf("time:    %10ld.%09ld CLOCK_THREAD_CPUTIME_ID\n", ts.tv_sec, ts.tv_nsec);
  printf("clock(): %20.9f\n", (double)(clock()) / CLOCKS_PER_SEC);
  return 0;
}
