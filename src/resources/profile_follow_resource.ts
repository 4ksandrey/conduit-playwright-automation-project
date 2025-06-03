import { Drash } from "../deps.ts";
import BaseResource from "./base_resource.ts";
import UserModel from "../models/user_model.ts";

class ProfileFollowResource extends BaseResource {
  static paths = ["/profiles/:username/follow"];

  public async POST() {
  try {
    const username = this.request?.path_params?.username;

    if (!username || username === "null") {
      return this.errorResponse(422, "Username path param is required.");
    }

    const currentUser = await this.getCurrentUser();
    if (!currentUser) {
      return this.errorResponse(401, "Current user not authenticated.");
    }

    const targetUser = await UserModel.findByUsername(username);
    if (!targetUser) {
      return this.errorResponse(404, "User not found.");
    }

    await currentUser.follow(targetUser);

    this.response.status_code = 200;
    this.response.body = {
      profile: targetUser.toProfile(currentUser),
    };

    return this.response;
  } catch (error) {
    console.error("Error in POST /profiles/:username/follow:", error);
    return this.errorResponse(500, "Internal server error.");
  }
}

public async DELETE() {
  try {
    const username = this.request?.path_params?.username;

    if (!username || username === "null") {
      return this.errorResponse(422, "Username path param is required.");
    }

    const currentUser = await this.getCurrentUser();
    if (!currentUser) {
      return this.errorResponse(401, "Current user not authenticated.");
    }

    const targetUser = await UserModel.findByUsername(username);
    if (!targetUser) {
      return this.errorResponse(404, "User not found.");
    }

    await currentUser.unfollow(targetUser);

    this.response.status_code = 200;
    this.response.body = {
      profile: targetUser.toProfile(currentUser),
    };

    return this.response;
  } catch (error) {
    console.error("Error in DELETE /profiles/:username/follow:", error);
    return this.errorResponse(500, "Internal server error.");
  }
}

}

export default ProfileFollowResource;
