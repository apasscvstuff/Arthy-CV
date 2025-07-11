# Arthur Passuello's Tag-Based CV System

This LaTeX CV system uses conditional compilation to generate multiple CV versions from a single source, optimized for different roles and audiences.

## Overview

The system generates 5 distinct CV versions:
- **Firmware**: Senior Firmware Engineer focused on embedded systems
- **AI**: Applied AI/ML practitioner with embedded systems experience  
- **Consulting**: Technical consultant with AI/business focus
- **Executive**: One-page executive summary for senior roles
- **General**: Balanced version covering firmware and AI expertise

## How to Use in Overleaf

### Generating Different CV Versions

To generate a specific CV version in Overleaf:

1. Open `cv.tex` in the editor
2. Add one of the following lines at the very top of the file (before `\documentclass`):

```latex
% For Firmware version:
\def\cvversion{firmware}

% For AI version:
\def\cvversion{ai}

% For Consulting version:
\def\cvversion{consulting}

% For Executive version:
\def\cvversion{executive}

% For General version:
\def\cvversion{general}
```

3. Recompile the document in Overleaf
4. The PDF will be generated with content specific to that version

### Example

To generate the firmware-focused CV:
```latex
\def\cvversion{firmware}
% !TEX TS-program = luatex
\documentclass[localFont,alternative]{documentMETADATA}
...
```

## Toggle System

The system uses LaTeX etoolbox toggles to control content visibility:

### Role Toggles
- `firmware`: Firmware/embedded systems content
- `ai`: AI/ML content
- `consulting`: Business consulting content
- `executive`: Executive-level content
- `general`: General balanced content

### Feature Toggles
- `technical`: Technical details included
- `detailed`: Extended descriptions
- `quantified`: Metrics and numbers emphasized
- `businessfocus`: Business impact highlighted
- `onepage`: Constrain to single page
- `fullversion`: Full multi-page version

## File Structure

```
.
├── config/
│   └── cv-versions.tex      # Version definitions and toggle settings
├── sections/                 # Consolidated section files
│   ├── section_headline.tex
│   ├── section_experience.tex
│   ├── section_skills.tex
│   ├── section_education.tex
│   ├── section_projects.tex
│   └── section_languages.tex
├── archive/                  # Original section file backups
├── fonts/                    # Source Sans Pro font files
├── cv.tex                    # Main LaTeX file
├── documentMETADATA.cls      # Custom document class
└── README.md                 # This file
```

## Conditional Content Examples

### In Section Files

Use these commands to include content conditionally:

```latex
% Include only for firmware role:
\whenrole{firmware}{
  \item Developed real-time embedded firmware...
}

% Include for AI OR consulting:
\iftoggle{ai}{
  \iftoggle{consulting}{
    % AI + Consulting specific content
  }{
    % AI only content
  }
}{}

% Exclude from executive version:
\whennotrole{executive}{
  \item Detailed technical implementation...
}
```

### Tagline Example

The tagline changes based on version:
- Firmware: "Senior Firmware Engineer | Software Architect | Technical Project Lead"
- AI: "Embedded Systems Engineer | Applied AI/ML Practitioner | Technical Lead"
- Consulting: "Senior Embedded Systems Engineer | Applied AI/ML Practitioner | Technical Project Lead"
- Executive: "Senior Technical Leader | Cross-functional Engineering Manager"
- General: "Embedded Systems Engineer | Applied AI/ML Practitioner | Technical Project Lead"

## Customization

### Adding New Content

When adding new content, consider which versions should include it:

```latex
% In experience section:
\whenrole{firmware}{
  \item New firmware-specific achievement
}

% In skills section:
\whenrole{ai}{
  \keywordsentry{New AI Skill}{TensorFlow, PyTorch}
}
```

### Creating a New Version

1. Add version definition to `config/cv-versions.tex`:
```latex
\newcommand{\cvVersionCustom}{
  \toggletrue{custom}
  \toggletrue{technical}
  % Set other toggles as needed
}
```

2. Add version detection in `cv.tex`:
```latex
\ifdefstring{\cvversion}{custom}{\cvVersionCustom}{}
```

3. Add conditional content using the new toggle:
```latex
\whenrole{custom}{
  % Custom version content
}
```

## Best Practices

1. **Test each version** after making changes
2. **Use meaningful toggle names** for clarity
3. **Group related content** within conditionals
4. **Comment complex logic** for maintainability
5. **Preserve all content** - use toggles rather than deleting

## Troubleshooting

### Common Issues

**Content appears in wrong version:**
- Check toggle settings in `config/cv-versions.tex`
- Verify conditional logic in section files

**Compilation errors:**
- Ensure all `\iftoggle` blocks are properly closed with `{}`
- Check for unmatched braces in conditional content

**Missing content:**
- Review toggle combinations - some content may require multiple toggles
- Check that content wasn't accidentally placed inside wrong conditional

## Version Comparison

| Feature | Firmware | AI | Consulting | Executive | General |
|---------|----------|-----|------------|-----------|---------|
| Technical details | ✓ | ✓ | ✗ | ✗ | ✗ |
| AI/ML content | ✗ | ✓ | ✓ | ✗ | ✓ |
| Business focus | ✗ | ✗ | ✓ | ✓ | ✗ |
| Quantified results | ✗ | ✗ | ✓ | ✓ | ✗ |
| Page limit | 2+ | 2+ | 2+ | 1 | 2 |

## Maintenance

When updating the CV:
1. Make changes in the appropriate section file
2. Use conditionals to control visibility
3. Test all 5 versions to ensure changes appear correctly
4. Commit changes with descriptive messages

## Acknowledgments

This CV system is built on the "Awesome Source CV" template by Christophe Roger (Darwiin), adapted from Alessandro Plasmati's template. The tag-based conditional compilation system was developed to enable efficient maintenance of multiple CV versions from a single source.