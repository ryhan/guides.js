guides.js
=========
Overlays a grid over your html to help you follow baselines, as well as precisely align content. Can be toggled on/off by pressing the 'g' key.

### Usage

Include jQuery and guides.js, and then call
```javascript
new GridSystem();
```

Pressing the "g" key will toggle the visibility of the grid.

### Options

#### Hiding on start
To hide the grid from the start, call 'hide' on your GridSystem object. For example,
```javascript
(new GridSystem()).hide();
```

#### Grid Spacing / Alignment
You can also pass a few parameters to adjust the grid. For example, to adjust the alignment and spacing of the grid, one might call
```javascript
new GridSystem({
  align: 'left'
  x: { major: 300, minor: 100, gutter: 20}
  y: { minor: 50 }
});
```

<table>
  <tr>
    <th class="name">Name</th>
    <th class="type">Type</th>
    <th class="default">Default</th>
    <th class="desc">Description</th>
  </tr>
  <tr>
    <td>align</td>
    <td>string</td>
    <td>'center'</td>
    <td class="desc">Decides how the grid should be aligned. Particularly important for resizing. Can be set to 'left' or 'center'.</td>
  </tr>
  <tr>
    <td>x</td>
    <td>object</td>
    <td>major: 150, minor: 0, gutter: 30</td>
    <td class="desc">Set the major and minor gridlines as well as gutters for vertical lines. All values are in pixels.</td>
  </tr>
  <tr>
    <td>y</td>
    <td>object</td>
    <td>major: 192, minor: 24, gutter: 0 </td>
    <td class="desc">Set the major and minor gridlines as well as gutters for horizontal lines. All values are in pixels.</td>
  </tr>
</table>