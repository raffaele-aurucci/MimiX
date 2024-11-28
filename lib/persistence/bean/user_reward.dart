class UserReward {
  int userId;
  int rewardId;

  UserReward({
    required this.userId,
    required this.rewardId,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'reward_id': rewardId,
    };
  }

  factory UserReward.fromJson(Map<String, dynamic> json) {
    return UserReward(
      userId: json['user_id'],
      rewardId: json['reward_id'],
    );
  }

  @override
  String toString() {
    return 'UserReward{userId: $userId, rewardId: $rewardId}';
  }
}
