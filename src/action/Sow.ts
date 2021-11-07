import HttpControl from "../core/HttpControl";
import { Response } from "express";
import SQLControl from "../core/SQLControl";
import StaticDateControl from "../core/StaticDateControl";
import moment from "moment";

/**
 * 收菜逻辑
 */
export default class SowAction {
    uri = "/sow";

    constructor() {
        HttpControl.get(this.uri).subscribe(async (d) => {
            if (this.missingKey(["landId", "uid", "plantId"], d.req.query, d.res)) {
                let uid = d.req.query.uid,
                    landId = d.req.query.landId,
                    plantId = Number(d.req.query.plantId),
                    plantData = StaticDateControl.plantList.get(plantId);

                if (!plantData) {
                    d.res.send({
                        code: 0,
                        data: { msg: `静态 种子id => ${plantId} 不存在` },
                        uri: this.uri,
                    });
                    return;
                }

                //查询用户身上解锁种子
                let userSeed = await SQLControl.getData(
                    "UserSeeds",
                    [
                        ["uid", uid],
                        ["plantId", plantId],
                    ],
                    { response: d.res }
                );

                if (!userSeed.length) {
                    d.res.send({
                        code: 0,
                        data: { msg: `用户未解锁种子id => ${plantId} ` },
                        uri: this.uri,
                    });
                    return;
                }

                //查询用户身上已经解锁的土地
                let land = await SQLControl.getData(
                    "UserLand",
                    [
                        ["uid", uid],
                        ["landId", landId],
                    ],
                    { response: d.res }
                );

                if (!land?.length) {
                    d.res.send({
                        code: 0,
                        data: { msg: `土地id => ${landId} 不存在` },
                        uri: this.uri,
                    });
                    return;
                }

                SQLControl.updateData(
                    "UserLand",
                    [
                        ["productId", 99],
                        [
                            "matureTime",
                            `"${moment(Date.now() + 100 * 1000).format("YYYY-MM-DD HH:mm:ss")}"`,
                        ],
                    ],
                    [
                        ["uid", uid],
                        ["landId", landId],
                    ]
                ).then((e) => {
                    if (!e) return console.log("种菜失败");
                    d.res.send({
                        code: 0,
                        data: { status: true },
                        uri: this.uri,
                    });
                });

                // console.log(land, 111);
            }
        });
    }

    missingKey(keys: string[], query: any, res: Response) {
        for (let x = 0; x < keys.length; x++) {
            const key = keys[x];
            if (query[key] === undefined || !query[key].length) {
                res.send({
                    code: 999,
                    data: { mes: `参数${key}丢失` },
                    uri: this.uri,
                });
                return false;
            }
        }
        return true;
    }
}
