//获取月份数组, 当前月份及前 2 个月和后 3 个月
export function getMonths(): string[] {
  let date = new Date()
  let currentMonth = date.getMonth() + 1

  return [
    getLastMonth(currentMonth, 2),
    getLastMonth(currentMonth, 1),
    currentMonth,
    getNextMonth(currentMonth, 1),
    getNextMonth(currentMonth, 2),
    getNextMonth(currentMonth, 3),
  ].map((val) => addZero(val))
}

export function getCurrentMonth() : string {
  let date = new Date()
  let currentMonth = date.getMonth() + 1
  return addZero(currentMonth)
}

//前 x 个月
function getLastMonth(curMonth:number, num:number) {
  let val = curMonth - num
  return val < 1 ? 12 + val : val
}

//后 x 个月
function getNextMonth(curMonth:number, num:number) {
  let val = curMonth + num
  return val > 12 ? val - 12 : val
}

//月份补 0 处理
function addZero(month:number) : string {
  return month < 10 ? '0' + month : month + ''
}