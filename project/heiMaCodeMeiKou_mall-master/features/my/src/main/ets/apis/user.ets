import { HDMUser, RequestRcp } from "basic";
import { HuaweiLoginParams, LoginFormModel } from "../viewmodels";

export const loginAPI = (data: LoginFormModel) =>
RequestRcp.post<HDMUser>("/login", data)


export const huaweiLoginAPI = (data: HuaweiLoginParams) => RequestRcp.post<HDMUser>("/login/huawei", data)