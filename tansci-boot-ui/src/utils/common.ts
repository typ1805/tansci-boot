import { list } from "@/api/system/dict"

const common:any = {}

// 数据字典
let dictList = []
common.getDictData = async function() {
    await list({}).then((res:any) =>{
        dictList = res.result
    })
}
common.getDictGroup = (groupName:any) => {
    return dictList.filter(item => item.groupName === groupName)
}
common.getDictLabel = (groupName:any, value:any) => {
    let dicts = common.getDictGroup(groupName)
    let dict = dicts.find((item:any) =>{
        return item.dicValue == value
    })
    return dict ? dict.dicLabel : null;
}

// 生成UUID
common.uuid = () => {
    function S4() {
      return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
    }
    return (S4()+S4()+S4()+S4()+S4()+S4()+S4()+S4());
}

// 是否包含逗号
common.isComma = (value:any) => {
    return value.toString().indexOf(',') !== -1
}

// 四舍五入保留2位小数（不够位数，则用0替补） 
common.toDecimal = (value:any) => {  
  var result = parseFloat(value);  
  if (isNaN(result)) { 
      return false;  
  }  
  result = Math.round(value * 100) / 100;  
  var s_x = result.toString(); // 将数字转换为字符串
  var pos_decimal = s_x.indexOf('.'); // 小数点的索引值

  // 当整数时，pos_decimal=-1 自动补0  
  if (pos_decimal < 0) {  
      pos_decimal = s_x.length;  
      s_x += '.';  
  }

  // 当数字的长度< 小数点索引+2时，补0  
  while (s_x.length <= pos_decimal + 2) {  
      s_x += '0';  
  }  
  return s_x;  
}

export default common