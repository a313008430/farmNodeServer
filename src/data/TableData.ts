/**
 * 已有的表结构
 * 对应的key结构
 */
export default {
    /** 用户 */
    User: {
        id: 0,
        gold: 0,
        nickname: "game",
        uid: 0,
        diamond: 0,
        addTime: `${new Date().toJSON().substring(0, 10)} ${new Date().toJSON().substring(11, 20)}`,
    },
    /** 用户土地 */
    UserLand: {
        id: 0,
        uid: 0,
        landId: 0,
        level: 1,
        // productId: 0,
    },
    /** 用户解锁种子 */
    UserSeeds: {
        uid: 0,
        plantId: 0,
    },
    /** 种子静态表 */
    PlantStatic: {},
};
