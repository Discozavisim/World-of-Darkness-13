import chess from '../../../assets/WindowsXP/user.png';
import icq from '../../../assets/WindowsXP/icq.png';
import { TextArea, Input } from 'tgui-core/components';
import { useLocalState } from '../../../backend';

export const Shreknet = (props) => {
  const { app, act } = props;
  const [username, setUsername] = useLocalState('shreknet_username', '');
  const {password, setPassword} = userLocalState('shreknet_password', '')
  const [message, setMessage] = useLocalState('shreknet_message', '');
  return app.username === '' ? (
    <div className="visitor">
      <div>
        {/* Заменить АЙСИКЬЮ картинку */}
        <img width="250px" src={icq} />
        <div className="visitor-text">Enter username:</div>
        <Input
          className="user-input"
          onChange={(e, value) => setUsername(value)}
        />
        <button
          type="button"
          onClick={() => {
            act('shreknet_login_user', { username: username, password: password, ref: app.reference });
            setUsername('');
          }}
          className="login-button"
        >
          <div className="visitor-text">Login</div>
        </button>
      </div>
    </div>
  ) : (
    <div className="shreknet">
      <div className="chat-header">
        <img src={chess} className="picture" />
        <div className="user-info">
          <div className="header-container">
            <div className="username">{app.username}</div>
            <div>{'Version 1.0 (Beta)'}</div>
          </div>
          <TextArea
            value={message}
            placeholder={'Enter some text...'}
            className="userinfo"
          />
        </div>
      </div>
      <div className="chat">
        <div className="chat-footer">
          <div class="messages">
            {app.messages.map((message) => {
              return (
                <>
                  <b>{message.author}</b>
                  <div>{message.message}</div>
                </>
              );
            })}
          </div>
          <TextArea
            placeholder={'Enter message...'}
            onChange={(e, value) => {
              setMessage(value);
            }}
            className="chat-input"
          />
          <div
            onClick={() => {
              act('send_message', { ref: app.reference, message: message });
              setMessage('');
            }}
            className="send-button"
          >
            <b style={{ color: 'black' }}>Send</b>
          </div>
        </div>
      </div>
    </div>
  );
};
