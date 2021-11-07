import express, { Application, Request, Response } from "express";
import TableData from "../data/TableData";
import SQLControl from "./SQLControl";
import { Observable } from "rxjs";
import StaticDateControl from "./StaticDateControl";
import moment from "moment";
const app: Application = express();
const PORT = process.env.PORT || 8000;

class HttpControl {
    app: Application | null = null;

    init() {
        return new Promise((resolve) => {
            let getData = {
                code: 0,
                data: {},
                uri: "",
            };
            app.listen(PORT, (): void => {
                console.log(`Server Running here 👉 http://localhost:${PORT}`);

                resolve(null);
            });

            this.app = app;
        });
    }

    get(name: string): Observable<{ req: Request; res: Response }> {
        return new Observable((subscriber) => {
            this.app?.get(name, (req: Request, res: Response) => {
                console.log(`api => ${name} query => ${JSON.stringify(req.query)}`);
                subscriber.next({ req, res });
            });
        });
    }
}

export default new HttpControl();

/**
 * 初始化土地
 */
app.get("/init", (req: Request, res: Response): void => {
    console.log(req.query);
    if (req.query.game === undefined) {
        res.send({
            code: 999,
            data: { mes: "参数game丢失" },
            uri: "",
        });
        return;
    }

    let uid: number = req.query.game as any;

    SQLControl.getData("User", [["uid", uid]], { response: res }).then(async (d: any) => {
        console.log(d, "get User");

        if (d.length) {
            res.send(await mergeUserDate(d[0]));
        } else {
            TableData.User.uid = uid;
            TableData.User.gold = 999;
            TableData.User.diamond = 999;
            let userData = await SQLControl.createRow("User", { response: res });
            if (!userData) {
                res.send(await mergeUserDate(userData));
                return;
            }
            let data: any = await SQLControl.getData("User", [["uid", uid]], { response: res });

            res.send({
                code: 0,
                data: data[0],
                uri: "/init",
            });
        }
    });
});

/**
 * 解锁土地
 */
app.get("/unlockLand", async (req: Request, res: Response) => {
    let uid: any = req.query.uid,
        landId: any = req.query.landId,
        //解锁类型 1金币 2广告
        type: any = req.query.type;
    if (uid === undefined) {
        res.send({
            code: 999,
            data: { mes: "参数uid丢失" },
            uri: "",
        });
        return;
    }
    if (type === undefined) {
        res.send({
            code: 999,
            data: { mes: "参数type丢失" },
            uri: "",
        });
        return;
    }
    if (landId === undefined) {
        res.send({
            code: 999,
            data: { mes: "参数landId丢失" },
            uri: "",
        });
        return;
    }

    //根据type验证
    // type
    console.log(type, "unlockLandType");

    if (type == 1) {
        //验证金币
        SQLControl.getData("User", [["uid", uid]], { response: res }).then((e: any) => {
            console.log(e[0]["gold"], "userDataGold");
        });
    } else if (type == 2) {
        //验证广告
    }

    console.log(uid, landId);
    let date = await unlockLand(uid, landId, res);
    if (date) {
        res.send({
            code: 999,
            data: { status: true },
            uri: "",
        });
    } else {
        res.send({
            code: 999,
            data: { mes: "解锁失败" },
            uri: "",
        });
    }
});

/**
 * 合并init数据
 * @param d
 * @returns
 */
async function mergeUserDate(d: any) {
    let landList = await getUserLand(d.uid);

    return {
        code: 0,
        data: {
            gold: d.gold,
            diamond: d.diamond,
            uid: d.uid,
            nickname: d.nickname,
            landList: landList,
            //种子列表
            seeds: [],
        },
        uri: "/init",
    };
}

/**
 * 解锁土地
 * @param uid 用户id 【后期直接解析token】
 * @param landId 土地id
 */
async function unlockLand(uid: number, landId: number, res: Response) {
    TableData.UserLand.uid = uid;
    TableData.UserLand.landId = landId as any;

    let landList: any = await SQLControl.getData("UserLand", [
        ["uid", uid],
        ["landId", landId],
    ]);
    if (landList.length) {
        return null;
    }

    let date: any = await SQLControl.createRow("UserLand", { response: res });
    if (!date) {
        console.log("解锁土地，创建失败");
        return null;
    }

    return date;
}

/**
 *  根据uid获取用户拥有的土地列表
 * @param uid
 * @returns
 */
async function getUserLand(uid: number) {
    let data: any = await SQLControl.getData("UserLand", [["uid", uid]]);
    console.log(data, "getUserLand");

    let list: any = [];

    data.forEach((d: any) => {
        let matureTime = moment(d.matureTime).valueOf() - moment(Date.now()).valueOf();
        if (matureTime < 0) matureTime = 0;

        list.push({
            landId: d.landId || null,
            level: d.level || null,
            productId: d.productId || null,
            matureTime: Math.ceil(matureTime / 1000) || null,
        });
    });

    console.log(list, "getUserLand");

    return list;
}
