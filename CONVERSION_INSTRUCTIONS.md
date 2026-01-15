# Converting Lab Materials to DOCX Format

This guide explains how to convert the lab materials from Markdown (.md) to Microsoft Word (.docx) format for distribution to students.

## Method 1: Using Pandoc (Recommended)

Pandoc is a universal document converter that produces high-quality Word documents.

### Install Pandoc

**Windows:**
```powershell
# Using Chocolatey
choco install pandoc

# Or download installer from https://pandoc.org/installing.html
```

**Linux:**
```bash
sudo apt-get install pandoc  # Ubuntu/Debian
sudo yum install pandoc      # CentOS/RHEL
```

**Mac:**
```bash
brew install pandoc
```

### Convert LAB_MANUAL_PRINTABLE.md to DOCX

```bash
# Basic conversion
pandoc LAB_MANUAL_PRINTABLE.md -o LAB_MANUAL.docx

# With table of contents
pandoc LAB_MANUAL_PRINTABLE.md -o LAB_MANUAL.docx --toc

# With custom styling
pandoc LAB_MANUAL_PRINTABLE.md -o LAB_MANUAL.docx --reference-doc=template.docx --toc
```

### Convert LAB_GUIDE.md to DOCX

```bash
pandoc LAB_GUIDE.md -o LAB_GUIDE.docx --toc
```

### Convert INSTRUCTOR_GUIDE.md to DOCX

```bash
pandoc INSTRUCTOR_GUIDE.md -o INSTRUCTOR_GUIDE.docx --toc
```

### Convert CHEAT_SHEET.md to DOCX

```bash
pandoc CHEAT_SHEET.md -o CHEAT_SHEET.docx
```

## Method 2: Using Online Converters

If you don't want to install software, use online converters:

1. **CloudConvert**: https://cloudconvert.com/md-to-docx
2. **Convertio**: https://convertio.co/md-docx/
3. **OnlineConvert**: https://www.online-convert.com/

**Steps:**
1. Upload the .md file
2. Select DOCX as output format
3. Convert and download

## Method 3: Using Visual Studio Code

If you have VS Code with extensions:

1. Install "Markdown PDF" extension
2. Open the .md file
3. Right-click → "Markdown PDF: Export (docx)"

## Method 4: Copy-Paste to Word

Simple but less formatted:

1. Open the .md file in a text editor
2. Preview in a Markdown viewer (GitHub, VS Code preview, etc.)
3. Copy the rendered content
4. Paste into Microsoft Word
5. Adjust formatting as needed

## Recommended Conversion Settings

### For Student Lab Manual

```bash
pandoc LAB_MANUAL_PRINTABLE.md \
  -o LAB_MANUAL.docx \
  --toc \
  --toc-depth=2 \
  --number-sections \
  -V geometry:margin=1in \
  -V fontsize=11pt
```

### For Instructor Guide

```bash
pandoc INSTRUCTOR_GUIDE.md \
  -o INSTRUCTOR_GUIDE.docx \
  --toc \
  --toc-depth=3 \
  --number-sections
```

## Post-Conversion Formatting Tips

After converting to DOCX, you may want to:

1. **Add Page Numbers**
   - Insert → Page Number → Bottom of Page

2. **Apply Heading Styles**
   - Ensure headings use Word's built-in styles
   - This enables automatic table of contents

3. **Format Code Blocks**
   - Apply "Code" or "Verbatim" style
   - Use Courier New or Consolas font
   - Add light gray background

4. **Add Page Breaks**
   - Between major sections
   - Before "Completion Certificate"

5. **Adjust Spacing**
   - Line spacing: 1.15 or 1.5
   - Paragraph spacing: 6pt after

6. **Add Header/Footer**
   - Header: "Kubernetes 101 Lab Manual"
   - Footer: Page numbers

7. **Print-Friendly Formatting**
   - Ensure checkboxes (□) are visible
   - Check that code blocks don't break across pages
   - Add extra space for handwritten answers

## Creating a Custom Template

To create a consistent style across all documents:

1. Convert one document:
   ```bash
   pandoc LAB_MANUAL_PRINTABLE.md -o template-base.docx
   ```

2. Open template-base.docx in Word

3. Modify styles:
   - Heading 1, 2, 3
   - Code style
   - Normal text
   - Page setup (margins, orientation)

4. Save as `template.docx`

5. Use template for all conversions:
   ```bash
   pandoc LAB_MANUAL_PRINTABLE.md -o LAB_MANUAL.docx --reference-doc=template.docx
   pandoc LAB_GUIDE.md -o LAB_GUIDE.docx --reference-doc=template.docx
   pandoc INSTRUCTOR_GUIDE.md -o INSTRUCTOR_GUIDE.docx --reference-doc=template.docx
   ```

## Batch Conversion Script

### Windows PowerShell

```powershell
# Convert all lab documents
$files = @(
    "LAB_MANUAL_PRINTABLE",
    "LAB_GUIDE",
    "INSTRUCTOR_GUIDE",
    "CHEAT_SHEET"
)

foreach ($file in $files) {
    Write-Host "Converting $file.md to $file.docx..."
    pandoc "$file.md" -o "$file.docx" --toc
}

Write-Host "All conversions complete!"
```

Save as `convert-all.ps1` and run:
```powershell
.\convert-all.ps1
```

### Linux/Mac Bash

```bash
#!/bin/bash

files=(
    "LAB_MANUAL_PRINTABLE"
    "LAB_GUIDE"
    "INSTRUCTOR_GUIDE"
    "CHEAT_SHEET"
)

for file in "${files[@]}"; do
    echo "Converting ${file}.md to ${file}.docx..."
    pandoc "${file}.md" -o "${file}.docx" --toc
done

echo "All conversions complete!"
```

Save as `convert-all.sh`, make executable, and run:
```bash
chmod +x convert-all.sh
./convert-all.sh
```

## Quality Checklist

After conversion, verify:

- [ ] Table of contents is accurate
- [ ] Code blocks are properly formatted
- [ ] Checkboxes are visible
- [ ] Page breaks are appropriate
- [ ] Images (if any) are included
- [ ] Hyperlinks work
- [ ] Blank lines for answers are adequate
- [ ] Document is print-friendly
- [ ] Headers/footers are correct
- [ ] Page numbers are present

## Distributing to Students

### Option 1: Print Copies
- Print LAB_MANUAL_PRINTABLE.docx for each student
- Provide as a physical workbook

### Option 2: Digital Distribution
- Convert to PDF for read-only distribution
- Share DOCX for students to fill in digitally

### Option 3: Both
- Provide digital copy for reference
- Print copy for hands-on note-taking

## Converting to PDF

For read-only distribution:

```bash
# Using Pandoc
pandoc LAB_MANUAL_PRINTABLE.md -o LAB_MANUAL.pdf

# Or convert DOCX to PDF using Word
# File → Save As → PDF
```

---

## Quick Reference

**Convert single file:**
```bash
pandoc input.md -o output.docx --toc
```

**With custom template:**
```bash
pandoc input.md -o output.docx --reference-doc=template.docx --toc
```

**Convert to PDF:**
```bash
pandoc input.md -o output.pdf
```

---

## Support

If you encounter issues:

1. Check Pandoc version: `pandoc --version`
2. Verify file paths are correct
3. Try basic conversion first (no options)
4. Check Pandoc documentation: https://pandoc.org/MANUAL.html

---

**Happy Converting!** 📄
