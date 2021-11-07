import SQLControl from "./SQLControl";

/**
 * 静态表数据缓存
 */
class StaticDateControl {
    /**
     * 静态种植物列表
     */
    plantList: Map<number, { id: number }> = new Map();

    init() {
        return new Promise(async (resolve) => {
            let plantList = await SQLControl.getData("PlantStatic");
            plantList.forEach((d) => {
                this.plantList.set(d.id, d);
            });
            resolve(null);
        });
    }
}

export default new StaticDateControl();
