# Random programming notes

#### Strange imports
```
import { Task } from './Task';
import Tasks from '/imports/api/tasks';
```

The first form imports the variable that was defined and was given the name `Task` in `/imports/ui/Task.js` that is 

```
export const Task = ( { task }) => {
	return <li>{task.text}</li>
}
```
Instead of { Task }, one could as well import a list of objects { Task, Ciccio, Pasticcio }.


The second form imports only the **default** export from `/imports/api/tasks.js`:

```
export default new Mongo.Collection('tasks');
```

and gives it the `Tasks` name within the local file.

The two forms can also be mixed in a single import as in

```
import React, { useState } from 'react';
```

where in addition to the default object then locally named `React`, another variable called `useState` is imported from the same file. 

#### Components
The strange exported functions defined in the `ui` directory are sort of new `html` tags. They return html code and can be used as html tags. Example:

```
import { TaskForm } from './TaskForm'
...
<TaskForm/>
```

The App itself is one of this redefined tags.
 