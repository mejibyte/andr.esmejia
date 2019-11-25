#include <chrono>
#include <iostream>
#include <limits>

using std::cout;
using std::endl;

int main() {
  std::chrono::time_point now = std::chrono::system_clock::now();

  // Note that units are not specified, so calling durationSinceEpoch.count()
  // is pretty much meaningless: they could be seconds, or nanoseconds, ticks
  // from a 3GHz CPU clock, or something else entirely!
  std::chrono::duration durationSinceEpoch = now.time_since_epoch();

  // No data loss on my system, so this compiles just fine. I guess it's not
  // portable as some other system might have a finer clock and converting to
  // nanoseconds would lose data.
  std::chrono::nanoseconds nanos = durationSinceEpoch;

  // This doesn't compile on my system because durationSinceEpoch is finer than
  // seconds, so converting to seconds would lose data. On my machine, this will
  // fail to compile with: error: no viable conversion from 'duration<[...],
  // ratio<[...], 1000000>>' to 'duration<[...], ratio<[...], 1>>'
  // std::chrono::seconds secs = durationSinceEpoch;

  // This compiles just fine because I'm using a well defined conversion fuction
  // (round) to decide what data to throw away.
  std::chrono::microseconds micros =
      std::chrono::round<std::chrono::microseconds>(durationSinceEpoch);
  std::chrono::seconds secs =
      std::chrono::round<std::chrono::seconds>(durationSinceEpoch);
  std::chrono::minutes mins =
      std::chrono::round<std::chrono::minutes>(durationSinceEpoch);
  std::chrono::hours hours =
      std::chrono::round<std::chrono::hours>(durationSinceEpoch);

  cout << "Time since epoch in nanos: " << nanos.count() << endl;
  cout << "Time since epoch in micros: " << micros.count() << endl;
  cout << "Time since epoch in seconds: " << secs.count() << endl;
  cout << "Time since epoch in minutes: " << mins.count() << endl;
  cout << "Time since epoch in hours: " << hours.count() << endl;

  return 0;
}
