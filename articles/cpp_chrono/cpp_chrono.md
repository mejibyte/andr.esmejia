# Printing

## How to print a time_point

```cpp
  std::chrono::time_point now = std::chrono::system_clock::now();
  std::time_t now2 = std::chrono::system_clock::to_time_t(now);
  std::tm tmLocal = *std::localtime(&now2);
  std::tm tmUTC = *std::gmtime(&now2);
  cout << std::put_time(&tmLocal, "%c %Z") << endl;
  cout << std::put_time(&tmUTC, "%c %Z") << endl;
```

This prints:

```
Sun Nov 24 18:10:53 2019 PST
Mon Nov 25 02:10:53 2019 UTC
```

See `time_point_print.cpp`.

## How to print a duration
TODO

# Arithmetic

## How to compare two time_points
TODO

## How to compare two durations
TODO

## How to substract two time_points, resulting in a duration
TODO

## How to add a duration to a time_point, resulting in a new time_point in the future
TODO

## How to subtract a duration from a time_point, resulting in a new time_point in the past
TODO

# Conversion

## How to convert a time_point to a duration representing the time elapsed since the epoch until this time_point

```cpp
  std::chrono::duration durationSinceEpoch = now.time_since_epoch();
  std::chrono::nanoseconds nanos = durationSinceEpoch;
  std::chrono::seconds secs = std::chrono::floor<std::chrono::seconds>(durationSinceEpoch);

  cout << "Time since epoch in nanos: " << nanos.count() << endl;
  cout << "Time since epoch in seconds: " << secs.count() << endl;
```

See also `time_point_time_since_epoch.cpp`.

## How to convert a duration in some units to a duration in different units

* When there's no risk of data loss (i.e. multiplying), just assignment (default constructor):

```cpp
  std::chrono::milliseconds ms(123456);
  std::chrono::microseconds us = ms;
```

* When there's risk of data loss (i.e. dividing), use one of these conversion functions:

```cpp
  std::chrono::milliseconds ms(123456);
  std::chrono::seconds s_floor = std::chrono::floor<std::chrono::seconds>(ms);
  std::chrono::seconds s_ceil = std::chrono::ceil<std::chrono::seconds>(ms);
  std::chrono::seconds s_round = std::chrono::round<std::chrono::seconds>(ms);
```

More details: see `duration_conversion.cpp` and https://en.cppreference.com/w/cpp/chrono/duration.


## How to convert a duration to an integer

Use the `count()` method:

```cpp
  std::chrono::milliseconds ms(123456);
  std::cout << ms.count() << std::endl;
```

