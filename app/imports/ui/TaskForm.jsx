import React, { useState } from 'react';
import Tasks from '/imports/api/tasks';

export const TaskForm = () => {
	const [text, setText] = useState("");

	const handleSubmit = () => {
		// console.log("handleSubmit with text: " + text)
		if (!text) return;
		Tasks.insert({
			text: text.trim(),
			createdAt: new Date()
		});
		setText("");
	};

	return(
		<form className="task-form" onSubmit={handleSubmit}>
		  <input 
		    type="text" 
		    placeholder="Type to add new tasks" 
		    value={text} 
		    onChange={(e) => setText(e.target.value)}
		  />
		  <button type="submit">Add Task</button>
		</form>
	);
};