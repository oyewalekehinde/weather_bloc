String weatherIcon(String condition) {
  print(condition);
  switch (condition) {
    case "overcast clouds":
      return "overcast_cloud.jpg";
      break;
    case "clear sky":
      return "clearsky.jpg";
      break;
    case "few clouds":
    case "broken clouds":
      return "broken_clouds.jpg";
      break;
    case "scattered_clouds":
      return "scattered_cloud.jpg";
      break;
    case "shower rain":
      return "shower_rain.jpg";
      break;
    case "rain":
      return "rain.jpg";
      break;
    case "thunderstorm":
      return "thunderstorm.jpg";
      break;
    case "snow":
      return "snow.jpg";
      break;
    case "mist":
      return "mist.jpg";
      break;
    default:
      return "clearsky.jpg";
      break;
  }
}
