import { Connection, createConnection } from "mysql2";
import TableData from "../data/TableData";
import { Response } from "express";

/**
 * 数据库处理控制器
 */
class SQLControl {
    connection: Connection | undefined;

    constructor() {}

    init() {
        return new Promise((resolve) => {
            this.connection = createConnection({
                host: "localhost",
                user: "root",
                port: 3306,
                password: "123456",
                // insecureAuth: true,
                database: "farm",
            });

            this.connection.connect((e) => {
                if (e) throw e;
                console.log("数据库连接成功");
                resolve(true);
            });
        });
    }

    createRow(
        table: keyof typeof TableData,
        options?: {
            /** 短连接  Response */
            response?: Response;
        }
    ) {
        let sql = `INSERT INTO ${table} (${Object.keys(TableData[table])}) VALUES (${Object.values(
            TableData[table]
        ).map((d) => `"${d}"`)});`;
        console.log(sql, "createRow");
        return this.queryData(sql, options?.response);
    }

    getData(
        table: keyof typeof TableData,
        data: any[][] = [],
        options?: {
            /** 查询的数量 默认1000 */
            limit?: number;
            /** 短连接  Response */
            response?: Response;
        }
    ): Promise<any[]> {
        console.log("getDate => data", data);

        let searchData: string[] = [];
        data.forEach((d) => {
            searchData.push(`${d[0]} = ${d[1]}`);
        });

        let sql = `SELECT * FROM ${table} ${searchData.length ? "WHERE" : ""} ${searchData.join(
            " and "
        )} LIMIT ${options?.limit || 1000};`;

        return this.queryData(sql, options?.response);
    }

    /**
     * 更新对应表里数据
     * @param table 表
     * @param data 数据
     */
    updateData(
        table: keyof typeof TableData,
        data: any[][],
        where: any[][],
        options?: {
            /** 短连接  Response */
            response?: Response;
        }
    ) {
        let sql = `update ${table} set ${data
            .map((d) => `${d[0]} = ${d[1]}`)
            .join(",")} where ${where.map((d) => `${d[0]} = ${d[1]}`).join(" and ")};`;

        // sql = `UPDATE UserLand SET productId=22 , matureTime='2021-11-07 20:51:26' WHERE uid=1013 and landId=4;`;

        return this.queryData(sql, options?.response);
    }

    /**
     * 数据库操作
     * @param sql sql语句
     */
    private queryData(sql: string, response?: Response): Promise<any[]> {
        return new Promise((resolve) => {
            console.log("sql => " + sql);

            this.connection?.query(sql, (err, result: any[]) => {
                if (err) {
                    console.log("[ queryData ERROR] - ", err.message);
                    response?.send({
                        code: 0,
                        data: { msg: `数据库错误 => ${err.message}` },
                        uri: "",
                    });
                    return;
                }
                resolve(result);
            });
        });
    }
}

export default new SQLControl();
