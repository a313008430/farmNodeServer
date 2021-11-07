import SowAction from "./action/Sow";
import HttpControl from "./core/HttpControl";
import SQLControl from "./core/SQLControl";
import StaticDateControl from "./core/StaticDateControl";

var sql = "SELECT * FROM UserLand";
var sqlList = "SELECT * FROM UserLand WHERE uid = 1000";
var sqlSed = "UPDATE UserLand SET productId = 这里是种子id WHERE id = 1";

(async function init() {
    await SQLControl.init();
    await StaticDateControl.init();
    await HttpControl.init();
    new SowAction();
})();
