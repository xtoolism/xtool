```js
// 获取当前文件中推断的年份与月份
function getYearAndMonth() {
  const currentFileName = dv.current().file.name;
  const match = currentFileName.match(/(\d{4})-(\d{2})/);
  if (match) {
    return { year: match[1], month: match[2] };
  } else {
    const now = new Date();
    return {
      year: now.getFullYear().toString(),
      month: (now.getMonth() + 1).toString().padStart(2, "0")
    };
  }
}

// 根据日期计算ISO标准的周数
function getISOWeekNumber(date) {
  const startOfYear = new Date(date.getFullYear(), 0, 1);
  const daysOffset = date.getDay() - startOfYear.getDay();
  const dayOfYear = Math.floor((date - startOfYear) / (24 * 60 * 60 * 1000));
  const adjustedDayOfYear = dayOfYear + ((daysOffset >= 0 ? daysOffset : daysOffset + 7) % 7);
  return Math.ceil(adjustedDayOfYear / 7);
}

// 查找符合条件的 Weekly 文件
function getWeeklyFilesForMonth(year, month) {
  const weeklyFolder = `Diary/${year}/Weekly`;
  const startDate = new Date(year, month - 1, 1);
  const endDate = new Date(year, month, 0); // 这个月的最后一天
  const startWeek = getISOWeekNumber(startDate);
  const endWeek = getISOWeekNumber(endDate);
  const weeklyFiles = [];

  for (let weekNum = startWeek; weekNum <= endWeek; weekNum++) {
    const fileName = `${year}-W${String(weekNum).padStart(2, '0')}`;
    const file = dv.page(`${weeklyFolder}/${fileName}`);
    
    if (file) {
      weeklyFiles.push({
        file: file,
        weekNum: weekNum
      });
    }
  }

  // 按周号排序
  weeklyFiles.sort((a, b) => a.weekNum - b.weekNum);
  return weeklyFiles;
}

// 获取年月
const { year, month } = getYearAndMonth();
console.log(`${year}-${month}`);

// 获取相关的周总结文件
const weeklyFiles = getWeeklyFilesForMonth(year, month);
console.log(weeklyFiles);
```
