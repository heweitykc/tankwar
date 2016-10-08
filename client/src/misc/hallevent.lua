local HallEvent = class("HallEvent")

function HallEvent:ctor()    
    self.REGISTER_RETURN = "register_return"    
    self.LOGIN_RETURN = "login_return"
    self.OPENBANK_RETURN = "openbank_return"
    self.DEPOSIT_RETURN = "deposit_return"
    self.CASH_RETURN = "cash_return"
    self.GIVEGOLD_RETURN = "givegold_return"
    self.RECORD_RETURN = "getrecord_return"
    self.GETRANK_RETURN = "getrank_return"  --��ȡ�����б�
    self.GETSELFRANK_RETURN = "getselfrank_return"  --��ȡ��������

    self.TASK_COMPLETE_RETURN = "task_complete_return"
    self.TASK_ADD_RETURN = "task_add_return"
    self.TASK_DONE_RETURN = "task_done_return"

    self.MONEY_CHANGE = "money_change"  --��ҲƸ����ݷ����仯
    self.PURCHASE = "purchase"  --������Ʒ

    self.RECEIVE_EMAIL = "receive_email" --��ȡ�ʼ�
    self.DISCARD_EMAIL = "discard_email" --�����ʼ�
    self.NEW_EMAIL_RETURN = "new_email_return" --�յ����ʼ�
    self.EMAIL_LIST = "email_list"  --��ȡ�ʼ��б�

    self.FRIEND_REQUEST = "friend_request" --��������
    self.DELETE_FRIEND = "delete_friend" --ɾ������
    self.NEW_FRIEND = "new_friend"  --��������
    self.FRIEND_LIMIT_CHANGE = "friend_limit_change" --�������ޱ仯
    self.FRIEND_GIFT = "friend_gift" --��������

    self.SIGN_RETURN = "signin_return" -- ǩ������

    self.NICKNAME_RETURN = "nickname_return" -- �޸��ǳ�
    self.HEAD_RETURN = "head_return" -- �޸�ͷ��
    self.BIND_ACCOUNT_RETURN = "bind_account_return" -- ���˻�
    self.MODIFY_SEX = "modify_sex" -- �����Ա�
    self.MODIFY_PWD = "modify_pwd" -- �޸�����
    self.MODIFY_BANK_PWD = "modify_bank_pwd" -- �޸���������
    self.EXP_ADD = "exp_add" -- ����ֵ����
    self.GOLD_CHANGE = "gold_change" -- ��ұ仯

    self.USER_INFO = "user_info" -- ��ȡ�û���Ϣ
    self.USER_LIST = "user_list" -- ��ȡ�û��б�

    self.SECRETARY_LIST = "secretary_list" --�����б�
    self.SECRETARY_SET = "secretary_set" -- ��������
    self.SECRETARY_BUY = "secretary_buy" --���鹺��
    self.SECRETARY_NEW = "secretary_new" -- ������

    self.HORN_RECEIVE = "horn_receive" --����������Ϣ

    self.GAME_ROOM_LIST = "game_room_list" --��Ϸroom�б�
    self.GAME_TABLE_LIST = "game_table_list" --��Ϸtable�б�
    self.ENTER_GAME = "enter_room" --������Ϸ
    self.QUIT_GAME = "quit_game" --�˳���Ϸ

    self.ONLINE_NUMBER = "online_number" --��������
end

return HallEvent
