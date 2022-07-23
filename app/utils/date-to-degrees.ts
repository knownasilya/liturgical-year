/* eslint-disable no-magic-numbers */
function isLeapYear(year: number) {
  // eslint-disable-next-line no-magic-numbers
  return year % 400 === 0 || (year % 100 !== 0 && year % 4 === 0);
}

export default function dateToDegrees(date: Date) {
  const year = date.getFullYear();
  const startOfYear = new Date(`jan 1 ${year}`);
  const daysInYear = isLeapYear(startOfYear.getFullYear()) ? 366 : 365;
  const startOfYearTime = startOfYear.getTime();
  const time = date.getTime();
  const diff = time - startOfYearTime;
  const days = diff / (1000 * 3600 * 24);

  return (days / daysInYear) * 360;
}
