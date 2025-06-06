import BaseModel from "./base_model.ts";
import type { QueryResult } from "../deps.ts";

export type UserEntity = {
  bio?: string;
  email: string;
  id?: number;
  image?: string;
  password?: string;
  username: string;
  token?: null | string;
};

/**
 * @description
 * Creates a instance of the user model with the properties populated
 *
 * @param object user
 * @param string user.username
 * @param string user.password
 * @param string user.email
 * @param string user.bio
 * @param string user.image
 * @param number user.id
 *
 * @return UserModel
 */
export function createUserModelObject(user: {
  username: string;
  password: string;
  email: string;
  bio: string;
  image: string;
  id: number;
}): UserModel {
  return new UserModel(
    user.username,
    user.password,
    user.email,
    user.bio,
    user.image,
    user.id,
  );
}

//@ts-ignore UserModel defines a where method that has different params than base models
// where method. Might need to investigate the naming usage
export class UserModel extends BaseModel {
  //////////////////////////////////////////////////////////////////////////////
  // FILE MARKER - PROPERTIES //////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  /**
   * @var string
   *
   * Bio associated with the given user
   */
  public bio: string;

  /**
   * @var string
   *
   * Email address for the given user
   */
  public email: string;

  /**
   * @var number
   *
   * Associated row id for the database entry
   */
  public id: number;

  /**
   * @var string
   *
   * Path to where the profile picture resides for the user
   */
  public image: string;

  /**
   * @var string
   *
   * Password for the given user. Hashed if pulled from the database
   */
  public password: string;

  /**
   * @var string
   *
   * Username for the user
   */
  public username: string;

  /**
 * @var string | null
 * Токен для скидання паролю
 */
  public resetPasswordToken: string | null = null;

  /**
  * @var Date | null
  * Дата і час завершення дії токена
  */
  public resetPasswordExpires: Date | null = null;

  //////////////////////////////////////////////////////////////////////////////
  // FILE MARKER - CONSTRCUTOR /////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  /**
   * @param string username
   * @param string password
   * @param string email
   * @param string bio=""
   * @param string image="https://static.productionready.io/images/smiley-cyrus.jpg"
   * @param number id=-1
   */
  constructor(
  username: string,
  password: string,
  email: string,
  bio: string = "",
  image: string = "https://static.productionready.io/images/smiley-cyrus.jpg",
  id: number = -1,
  resetPasswordToken: string | null = null,
  resetPasswordExpires: Date | null = null,
) {
  super();
  this.id = id;
  this.username = username;
  this.password = password;
  this.email = email;
  this.bio = bio;
  this.image = image;
  this.resetPasswordToken = resetPasswordToken;
  this.resetPasswordExpires = resetPasswordExpires;
}


  //////////////////////////////////////////////////////////////////////////////
  // FILE MARKER - METHODS - CRUD //////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  /**
   * Delete this model.
   *
   * @return Promise<boolean> False if the query failed to delete
   */
  public async delete(): Promise<boolean> {
    let query = `DELETE FROM users WHERE id = ?`;
    query = this.prepareQuery(
      query,
      [
        String(this.id),
      ],
    );

    try {
      const client = await BaseModel.connect();
      const dbResult: QueryResult = await client.query(query);
      client.release();
      if (dbResult.rowCount! < 1) {
        return false;
      }
    } catch (error) {
      console.log(error);
      return false;
    }
    return true;
  }

  /**
   * Save this model.
   *
   * @return Promise<UserModel|null> Empty array if no data was found
   */
  public async save(): Promise<UserModel | null> {
    // If this model already has an ID, then that means we're updating the model
    if (this.id != -1) {
      return this.update();
    }

    let query = "INSERT INTO users " +
      " (username, email, password, bio, image)" +
      " VALUES (?, ?, ?, ?, ?);";
    query = this.prepareQuery(
      query,
      [
        this.username,
        this.email,
        this.password,
        this.bio,
        this.image,
      ],
    );

    const client = await BaseModel.connect();
    const dbResult: QueryResult = await client.query(query);
    client.release();
    if (dbResult.rowCount! < 1) {
      return null;
    }

    // (crookse) We ignore this because this will never return null.
    const savedResult = await UserModel.where({ email: this.email });
    if (savedResult.length === 0) {
      return null;
    }
    return savedResult[0];
  }

  /**
   * Update this model.
   *
   * @return Promise<UserModel|null> False if no results were found
   */
  public async update(): Promise<UserModel | null> {
    let query = "UPDATE users SET " +
      "username = ?, password = ?, email = ?, bio = ?, image = ? " +
      `WHERE id = '${this.id}';`;
    query = this.prepareQuery(
      query,
      [
        this.username,
        this.password,
        this.email,
        this.bio,
        this.image,
      ],
    );
    const client = await BaseModel.connect();
    const dbResult: QueryResult = await client.query(query);
    client.release();
    if (dbResult.rowCount! < 1) {
      return null;
    }

    const updatedResult = await UserModel.where({ email: this.email });
    if (updatedResult.length === 0) {
      return null;
    }
    return updatedResult[0];
  }

  public async follow(user: UserModel): Promise<void> {
    const client = await BaseModel.connect();
    await client.query(
      `INSERT INTO follows (follower_id, followee_id) VALUES (?, ?)`,
      [this.id, user.id],
    );
    client.release();
  }

  public async unfollow(user: UserModel): Promise<void> {
    const client = await BaseModel.connect();
    await client.query(
      `DELETE FROM follows WHERE follower_id = ? AND followee_id = ?`,
      [this.id, user.id],
    );
    client.release();
  }

  public toProfile(currentUser: UserModel | null): {
    username: string;
    bio: string;
    image: string;
    following: boolean;
  } {
    return {
      username: this.username,
      bio: this.bio,
      image: this.image,
      following: currentUser ? currentUser.id !== this.id : false, // временно
    };
  }

  public isFollowing(user: UserModel): boolean {
    return false; // будет SQL позже
  }

  public static async follow(followerId: number, followingId: number): Promise<void> {
    const client = await BaseModel.connect();
    await client.query(
      "INSERT INTO followers (follower_id, following_id) VALUES (?, ?);",
      [followerId, followingId],
    );
    client.release();
  }

  static async findByEmail(email: string): Promise<UserModel | null> {
    const results = await BaseModel.Where("users", { email });
    if (!results.length) return null;

    const row = results[0];
    const user = new UserModel(
      row.username as string,
      row.password as string,
      row.email as string,
    );
    user.id = row.id as number;
    return user;
  }

  public static async unfollow(followerId: number, followingId: number): Promise<void> {
    const client = await BaseModel.connect();
    await client.query(
      "DELETE FROM followers WHERE follower_id = ? AND following_id = ?;",
      [followerId, followingId],
    );
    client.release();
  }

  public static async isFollowing(followerId: number, followingId: number): Promise<boolean> {
    const client = await BaseModel.connect();
    const result = await client.query(
      "SELECT * FROM followers WHERE follower_id = ? AND following_id = ?;",
      [followerId, followingId],
    );
    client.release();
    return result.rowCount !== undefined && result.rowCount > 0;
  }
  //////////////////////////////////////////////////////////////////////////////
  // FILE MARKER - METHODS - STATIC ////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  /**
   * @description
   *     See BaseModel.Where()
   *
   * @param {[key: string]: string} fields
   *
   * @return Promise<UserModel[]|[]>
   */
  static async where(
    fields: { [key: string]: string | number },
  ): Promise<UserModel[] | []> {
    const results = await BaseModel.Where("users", fields);

    if (results.length <= 0) {
      return [];
    }

    //@ts-ignore Nothing we can do about this.. the createUserModelObject expect
    // a user object type, but there's no way to type it like that the return type of whereIn can't be user
    return results.map((result) => {
      return createUserModelObject(result);
    });
  }

  /**
   * @description
   *     See BaseModel.WhereIn()
   *
   * @param string column
   * @param any values
   *
   * @return Promise<UserModel[]> | []
   */
  static async whereIn(
    column: string,
    values: string[] | number[],
  ): Promise<UserModel[] | []> {
    const results = await BaseModel.WhereIn("users", {
      column,
      values,
    });

    if (results.length <= 0) {
      return [];
    }

    //@ts-ignore Nothing we can do about this.. the createUserModelObject expect
    // a user object type, but there's no way to type it like that the return type of whereIn can't be user
    return results.map((result) => {
      return createUserModelObject(result);
    });
  }

  static async findByUsername(username: string): Promise<UserModel | null> {
    const users = await UserModel.where({ username });
    return users.length > 0 ? users[0] : null;
  }

  //////////////////////////////////////////////////////////////////////////////
  // FILE MARKER - METHODS - PUBLIC ////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  /**
   * @return UserEntity
   */
  public toEntity(): UserEntity {
    return {
      id: this.id,
      username: this.username,
      email: this.email,
      bio: this.bio,
      image: this.image,
      token: null,
    };
  }
}

export default UserModel;
