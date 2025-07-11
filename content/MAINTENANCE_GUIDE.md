# Enhanced CV System Maintenance Guide

## Overview
This guide provides step-by-step instructions for maintaining and updating the enhanced tag-based CV system with quantified achievements and progressive disclosure.

## System Architecture

### Core Components
```
Enhanced CV System
├── Configuration Layer
│   └── config/cv-versions.tex          # Version definitions & toggles
├── Document Class Layer
│   └── documentMETADATA.cls            # Enhanced toggle system & commands
├── Content Layer
│   ├── sections/section_executive_summary.tex
│   ├── sections/section_headline.tex   # Role-specific headlines
│   ├── sections/section_experience.tex # Quantified achievements
│   ├── sections/section_skills.tex     # Priority-based skills
│   ├── sections/section_education.tex  # Education content
│   ├── sections/section_projects.tex   # Role-specific projects
│   └── sections/section_languages.tex  # Languages & interests
├── Documentation Layer
│   ├── content/METRICS_INVENTORY.md    # Quantifiable achievements
│   ├── content/METRICS_MAPPING.md      # Implementation patterns
│   ├── content/VALIDATION_TESTING.md   # Testing procedures
│   └── content/MAINTENANCE_GUIDE.md    # This file
└── Main Document
    └── cv.tex                          # Version detection & structure
```

### Command Hierarchy
```
Toggle System Commands:
├── Basic Conditionals
│   ├── \whenrole{role}{content}        # Show for specific role
│   ├── \whennotrole{role}{content}     # Hide for specific role
│   └── \iftoggle{toggle}{true}{false}  # Direct toggle check
├── Quantification Commands
│   ├── \metric{text}                   # Show if quantified enabled
│   ├── \businessimpact{text}           # Show if business focus
│   ├── \techmetric{text}               # Show for technical roles
│   └── \leadmetric{text}               # Show for leadership roles
├── Priority System
│   ├── \priority{1}{content}           # Always include (core)
│   ├── \priority{2}{content}           # Standard details
│   └── \priority{3}{content}           # Full version only
└── Composite Commands
    ├── \achievement{action}{metric}{impact} # Complete achievement pattern
    └── \detailedtech{content}           # Technical content unless executive
```

## Regular Maintenance Tasks

### Monthly Updates

#### 1. Content Freshness Review
**Files to Check:** `sections/section_experience.tex`, `sections/section_projects.tex`

**Tasks:**
- [ ] Update current position end date if applicable
- [ ] Add new achievements with quantified metrics
- [ ] Review and update project status (WIP → completed)
- [ ] Verify all metrics are still accurate and supportable

**Example Update:**
```latex
% Adding new achievement
\priority{1}{
  \item \achievement{Led implementation of new safety protocol}{
    reducing critical incidents by 75% over 6-month period
  }{
    \businessimpact{achieving industry-leading safety standards}
  }
}
```

#### 2. Metrics Validation
**Files to Check:** `content/METRICS_INVENTORY.md`

**Tasks:**
- [ ] Verify all percentage improvements are still accurate
- [ ] Update team sizes, project counts, financial impacts
- [ ] Add new quantifiable achievements
- [ ] Remove outdated or no longer relevant metrics

#### 3. Skills Currency Check
**Files to Check:** `sections/section_skills.tex`

**Tasks:**
- [ ] Add new technologies, tools, or frameworks learned
- [ ] Update proficiency levels based on recent experience
- [ ] Remove obsolete technologies if no longer relevant
- [ ] Ensure skills align with target job requirements

### Quarterly Updates

#### 1. Version Strategy Review
**Files to Check:** `config/cv-versions.tex`, targeting strategy

**Tasks:**
- [ ] Review job market trends for target roles
- [ ] Assess if current 5 versions still meet market needs
- [ ] Consider adding new specialized versions if needed
- [ ] Update toggle combinations based on feedback

#### 2. ATS Compatibility Audit
**Files to Check:** All section files, keyword density

**Tasks:**
- [ ] Analyze recent job postings for keyword trends
- [ ] Update technical skills to match current market demands
- [ ] Ensure proper keyword density across all versions
- [ ] Test parsing with ATS-simulation tools if available

#### 3. Competitive Analysis
**Tasks:**
- [ ] Review industry peer CVs for emerging trends
- [ ] Benchmark quantified achievements against market standards
- [ ] Update value propositions based on market positioning
- [ ] Adjust emphasis between technical and business content

### Annual Updates

#### 1. Complete Content Overhaul
**Tasks:**
- [ ] Full metrics inventory refresh
- [ ] Remove achievements older than 5-7 years
- [ ] Major reorganization of content priorities
- [ ] Update contact information and professional profiles

#### 2. System Architecture Review
**Tasks:**
- [ ] Evaluate if toggle system meets current needs
- [ ] Consider new progressive disclosure strategies
- [ ] Update document class with new optimization commands
- [ ] Review and optimize LaTeX code for performance

## Adding New Content

### Adding a New Job Experience

1. **Update Metrics Inventory**
   ```markdown
   ## New Company Name (Start Date - End Date)
   
   ### Technical Metrics
   - Team leadership: X direct reports
   - Performance improvement: Y% increase/decrease
   - System reliability: Z% uptime/accuracy
   
   ### Business Impact
   - Financial: $X saved/generated
   - Timeline: Y% ahead/behind schedule
   - Stakeholders: Z+ people coordinated
   ```

2. **Add to Experience Section**
   ```latex
   \experience
   {End Date}{Title}{Company}{Reference}
   {Start Date}{
     \compactlist{
       \priority{1}{
         \item \achievement{Core accomplishment}{
           key metric with quantification
         }{
           \businessimpact{business value created}
         }
       }
       \priority{2}{
         \item Role-specific detailed achievements
       }
     }
   }
   {Role-appropriate skill keywords}
   ```

3. **Test All Versions**
   - Verify content appears appropriately in each of 5 versions
   - Check that metrics align with role expectations
   - Ensure no content conflicts with existing entries

### Adding New Skills

1. **Determine Skill Category**
   - Programming Languages (Priority 1)
   - Core Technical Skills (Priority 1-2)
   - Specialized Tools (Priority 2-3)
   - Soft Skills/Leadership (Priority 2)

2. **Add with Appropriate Conditions**
   ```latex
   \keywordsentry{Category Name}{
     \whenrole{firmware}{Firmware-specific tools}
     \whenrole{ai}{AI/ML specific tools}
     Core skills \metric{(proficiency level)}
   }
   ```

3. **Update All Relevant Versions**
   - Ensure skill appears in appropriate role versions
   - Verify priority level matches importance
   - Check against ATS keyword requirements

### Adding New Projects

1. **Assess Project Relevance**
   - Which roles benefit from this project?
   - What quantifiable outcomes can be highlighted?
   - How does it differentiate from existing projects?

2. **Implementation Pattern**
   ```latex
   \whenrole{appropriate-roles}{
   \project
   {Project Name}{Date Range}
   {\website{Link}{URL}}
   {
     \achievement{What was built/accomplished}{
       quantified technical metrics
     }{
       business or research impact
     }
     \priority{2}{Additional technical details}
   }
   {Technology stack, skills demonstrated}
   }
   ```

## Troubleshooting & Debugging

### Common Issues

#### Content Not Appearing in Expected Version
**Diagnosis:**
1. Check toggle settings in `config/cv-versions.tex`
2. Verify conditional logic in section files
3. Ensure correct toggle names (case-sensitive)

**Solution:**
```latex
% Check current toggles for version
\iftoggle{firmware}{FIRMWARE IS TRUE}{}
\iftoggle{ai}{AI IS TRUE}{}
% Add debug output to identify issue
```

#### Executive Version Too Long
**Diagnosis:**
1. Check Priority 2 and 3 content inclusion
2. Verify `\priority{1}` wraps only essential content
3. Review executive summary length

**Solution:**
```latex
% Ensure only Priority 1 content in executive
\priority{1}{Core achievement only}
\priority{2}{This should not appear in executive}

% Check toggle configuration
\togglefalse{fullversion}  % Essential for executive
\toggletrue{onepage}       % Activates length controls
```

#### Metrics Appearing in Wrong Roles
**Diagnosis:**
1. Check \metric{}, \businessimpact{}, \techmetric{} usage
2. Verify toggle combinations in version definitions
3. Review conditional logic flow

**Solution:**
```latex
% Role-specific metric display
\techmetric{Technical detail for firmware/ai only}
\leadmetric{Leadership metric for consulting/executive}
\businessimpact{Business value for consulting/executive}
```

#### LaTeX Compilation Errors
**Common Causes:**
- Unmatched braces in conditional blocks
- Missing closing brackets
- Undefined command sequences
- Conflicting package requirements

**Debugging Process:**
1. Compile single version to isolate issue
2. Check LaTeX log for specific error location
3. Validate all conditional blocks are properly closed
4. Test with minimal content to identify problematic section

### Performance Optimization

#### Reducing Compilation Time
- Minimize nested conditional logic
- Use \newcommand for repeated patterns
- Optimize image and font loading
- Consider using `\includeonly` for testing specific sections

#### Memory Management
- Monitor LaTeX memory usage with complex conditionals
- Consider splitting very large sections
- Optimize toggle logic for efficiency

## Version Control & Backup Strategy

### Git Workflow
```bash
# Feature branch for updates
git checkout -b update/[description]

# Make changes and test
git add -A
git commit -m "Update: [specific changes made]"

# Test all 5 versions before merging
# Merge back to main
git checkout main
git merge update/[description]
```

### Backup Schedule
- **Daily**: Local file backup during active editing
- **Weekly**: Git commit with test validation
- **Monthly**: Export all PDFs for archive
- **Quarterly**: Full system backup with documentation

### Change Documentation
Maintain changelog in README.md:
```markdown
## Changelog

### 2024-XX-XX
- Added: New experience at [Company]
- Updated: Skills section with [Technology]
- Fixed: Executive version length optimization
- Metrics: Updated team size from X to Y people
```

## Advanced Customization

### Creating New CV Versions

1. **Define New Toggle Combination**
   ```latex
   \newcommand{\cvVersionCustom}{
     \toggletrue{custom}
     \toggletrue{technical}
     \togglefalse{executive}
     % Set other toggles as needed
   }
   ```

2. **Add Version Detection**
   ```latex
   \ifdefstring{\cvversion}{custom}{\cvVersionCustom}{}
   ```

3. **Create Conditional Content**
   ```latex
   \whenrole{custom}{
     Content specific to custom version
   }
   ```

### Extending the Command System

1. **New Utility Commands**
   ```latex
   \newcommand{\industry}[1]{%
     % Show content for specific industry focus
     \iftoggle{medtech}{#1}{}%
   }
   
   \newcommand{\certification}[2]{%
     % Format certifications with conditional details
     #1\iftoggle{detailed}{ - #2}{}%
   }
   ```

2. **Enhanced Metrics Commands**
   ```latex
   \newcommand{\impact}[3]{%
     % Multi-level impact statement
     % #1=basic, #2=quantified, #3=business
     #1\metric{ (#2)}\businessimpact{ resulting in #3}%
   }
   ```

## Quality Assurance

### Pre-Release Checklist
- [ ] All 5 versions compile without errors
- [ ] Content appears appropriately in each version
- [ ] Metrics are accurate and supportable
- [ ] No contradictory information between sections
- [ ] Professional language and formatting throughout
- [ ] ATS-compatible structure maintained
- [ ] README.md updated with any new instructions

### Peer Review Process
1. Have colleague review one random version for clarity
2. Test ATS parsing with online tools if available
3. Compare with industry standards and peer CVs
4. Validate all quantified claims are defensible

### Continuous Improvement
- Track which versions generate most interview requests
- Gather feedback on content effectiveness
- Monitor industry trends for content adjustments
- Update metrics benchmarks based on market data

This maintenance guide ensures the enhanced CV system remains current, effective, and technically sound while preserving the sophisticated tag-based architecture and quantified achievement framework.