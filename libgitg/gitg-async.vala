/*
 * This file is part of gitg
 *
 * Copyright (C) 2013 - Jesse van den Kieboom
 *
 * gitg is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * gitg is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with gitg. If not, see <http://www.gnu.org/licenses/>.
 */

namespace Gitg
{

internal class Async
{
	public delegate void ThreadFunc();

	public static async void thread(ThreadFunc func)
	{
		SourceFunc callback = thread.callback;

		try
		{
			var t = new Thread<void *>.try("gitg-status-enumerator", () => {
				func();
				Idle.add((owned)callback);

				return null;
			});

			yield;

			t.join();
		}
		catch {}
	}
}

}

// ex:set ts=4 noet