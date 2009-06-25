///////////////////////////////////////////////////////////////////////////////
// Name:        src/ribbon/page.cpp
// Purpose:     Container for ribbon-bar-style interface panels
// Author:      Peter Cawley
// Modified by:
// Created:     2009-05-25
// RCS-ID:      $Id$
// Copyright:   (C) Peter Cawley
// Licence:     wxWindows licence
///////////////////////////////////////////////////////////////////////////////
#include "wx/wxprec.h"

#ifdef __BORLANDC__
    #pragma hdrstop
#endif

#include "wx/ribbon/page.h"

#if wxUSE_RIBBON

#include "wx/ribbon/art.h"
#include "wx/ribbon/bar.h"
#include "wx/dcbuffer.h"

#ifndef WX_PRECOMP
#endif

#ifdef __WXMSW__
#include "wx/msw/private.h"
#endif

// As scroll buttons need to be rendered on top of a page's child windows, the
// buttons themselves have to be proper child windows (rather than just painted
// onto the page). In order to get proper clipping of a page's children (with
// regard to the scroll button), the scroll buttons are created as children of
// the ribbon bar rather than children of the page. This could not have been
// achieved by creating buttons as children of the page and then doing some Z-order
// manipulation, as this causes problems on win32 due to ribbon panels having the
// transparent flag set.
class wxRibbonPageScrollButton : public wxRibbonControl
{
public:
	wxRibbonPageScrollButton(wxWindow* parent,
				 wxWindowID id = wxID_ANY,
				 const wxPoint& pos = wxDefaultPosition,
				 const wxSize& size = wxDefaultSize,
				 long style = 0);

	virtual ~wxRibbonPageScrollButton();

protected:
	virtual wxBorder GetDefaultBorder() const { return wxBORDER_NONE; }

	void OnEraseBackground(wxEraseEvent& evt);
	void OnPaint(wxPaintEvent& evt);
	void OnMouseEnter(wxMouseEvent& evt);
	void OnMouseLeave(wxMouseEvent& evt);

	long m_flags;

	DECLARE_CLASS(wxRibbonPageScrollButton)
	DECLARE_EVENT_TABLE()
};

IMPLEMENT_CLASS(wxRibbonPageScrollButton, wxRibbonControl)

BEGIN_EVENT_TABLE(wxRibbonPageScrollButton, wxRibbonControl)
  EVT_ENTER_WINDOW(wxRibbonPageScrollButton::OnMouseEnter)
  EVT_ERASE_BACKGROUND(wxRibbonPageScrollButton::OnEraseBackground)
  EVT_LEAVE_WINDOW(wxRibbonPageScrollButton::OnMouseLeave)
  EVT_PAINT(wxRibbonPageScrollButton::OnPaint)
END_EVENT_TABLE()

wxRibbonPageScrollButton::wxRibbonPageScrollButton(wxWindow* parent,
				 wxWindowID id,
				 const wxPoint& pos,
				 const wxSize& size,
				 long style) : wxRibbonControl(parent, id, pos, size, wxBORDER_NONE)
{
	SetBackgroundStyle(wxBG_STYLE_CUSTOM);
	m_flags = (style & wxRIBBON_SCROLL_BTN_DIRECTION_MASK) | wxRIBBON_SCROLL_BTN_FOR_PAGE;
}

wxRibbonPageScrollButton::~wxRibbonPageScrollButton()
{
}

void wxRibbonPageScrollButton::OnEraseBackground(wxEraseEvent& WXUNUSED(evt))
{
	// Do nothing - all painting done in main paint handler
}

void wxRibbonPageScrollButton::OnPaint(wxPaintEvent& WXUNUSED(evt))
{
	wxAutoBufferedPaintDC dc(this);
	if(m_art)
	{
		m_art->DrawScrollButton(dc, GetParent(), GetSize(), m_flags);
	}
}

void wxRibbonPageScrollButton::OnMouseEnter(wxMouseEvent& WXUNUSED(evt))
{
	m_flags |= wxRIBBON_SCROLL_BTN_HOVERED;
	Refresh(false);
}

void wxRibbonPageScrollButton::OnMouseLeave(wxMouseEvent& WXUNUSED(evt))
{
	m_flags &= ~wxRIBBON_SCROLL_BTN_HOVERED;
	Refresh(false);
}

IMPLEMENT_CLASS(wxRibbonPage, wxRibbonControl)

BEGIN_EVENT_TABLE(wxRibbonPage, wxRibbonControl)
  EVT_ERASE_BACKGROUND(wxRibbonPage::OnEraseBackground)
  EVT_PAINT(wxRibbonPage::OnPaint)
  EVT_SIZE(wxRibbonPage::OnSize)
END_EVENT_TABLE()

wxRibbonPage::wxRibbonPage()
{
	m_scroll_left_btn = NULL;
	m_scroll_right_btn = NULL;
	m_scroll_amount = 0;
	m_scroll_buttons_visible = false;
}

wxRibbonPage::wxRibbonPage(wxRibbonBar* parent,
				   wxWindowID id,
				   const wxString& label,
				   const wxBitmap& icon,
				   const wxPoint& pos,
				   const wxSize& size,
				   long style) : wxRibbonControl(parent, id, pos, size, style)
{
	CommonInit(label, icon);
}

wxRibbonPage::~wxRibbonPage()
{
}

bool wxRibbonPage::Create(wxRibbonBar* parent,
				wxWindowID id,
				const wxString& label,
				const wxBitmap& icon,
				const wxPoint& pos,
				const wxSize& size,
				long style)
{
	if(!wxRibbonControl::Create(parent, id, pos, size, style))
		return false;

	CommonInit(label, icon);

	return true;
}

void wxRibbonPage::CommonInit(const wxString& label, const wxBitmap& icon)
{
    SetName(label);

	SetLabel(label);
	m_old_size = wxSize(0, 0);
	m_icon = icon;
	m_scroll_left_btn = NULL;
	m_scroll_right_btn = NULL;
	m_scroll_amount = 0;
	m_scroll_buttons_visible = false;

	SetBackgroundStyle(wxBG_STYLE_CUSTOM);

	wxDynamicCast(GetParent(), wxRibbonBar)->AddPage(this);
}

void wxRibbonPage::SetArtProvider(wxRibbonArtProvider* art)
{
	m_art = art;
	for ( wxWindowList::compatibility_iterator node = GetChildren().GetFirst();
          node;
          node = node->GetNext() )
    {
        wxWindow* child = node->GetData();
		wxRibbonControl* ribbon_child = wxDynamicCast(child, wxRibbonControl);
		if(ribbon_child)
		{
			ribbon_child->SetArtProvider(art);
		}
	}
}

void wxRibbonPage::OnEraseBackground(wxEraseEvent& evt)
{
	wxDC* dc = evt.GetDC();
	if(dc != NULL)
	{
		m_art->DrawPageBackground(*dc, this, GetClientSize());
	}
	else
	{
		wxClientDC cdc(this);
		m_art->DrawPageBackground(cdc, this, GetClientSize());
	}
}

void wxRibbonPage::OnPaint(wxPaintEvent& WXUNUSED(evt))
{
	// No foreground painting done by the page itself, but a paint DC
	// must be created anyway.
	wxPaintDC dc(this);
}

wxOrientation wxRibbonPage::GetMajorAxis() const
{
	if(m_art && (m_art->GetFlags() & wxRIBBON_BAR_FLOW_VERTICAL))
	{
		return wxVERTICAL;
	}
	else
	{
		return wxHORIZONTAL;
	}
}

void wxRibbonPage::SetSizeWithScrollButtonAdjusment(int x, int y, int width, int height)
{
	if(m_scroll_buttons_visible)
	{
		if(GetMajorAxis() == wxHORIZONTAL)
		{
			if(m_scroll_left_btn)
			{
				int w = m_scroll_left_btn->GetSize().GetWidth();
				m_scroll_left_btn->SetPosition(wxPoint(x, y));
				x += w;
				width -= w;
			}
			if(m_scroll_right_btn)
			{
				int w = m_scroll_right_btn->GetSize().GetWidth();
				width -= w;
				m_scroll_right_btn->SetPosition(wxPoint(x + width, y));
			}
		}
		else
		{
			// TODO (once horizontal case is confirmed as working)
		}
	}
	SetSize(x, y, width, height);
}

void wxRibbonPage::OnSize(wxSizeEvent& evt)
{
	Layout();

	wxMemoryDC temp_dc;
	wxRect invalid_rect = m_art->GetPageBackgroundRedrawArea(temp_dc, this, m_old_size, evt.GetSize());
	Refresh(true, &invalid_rect);

	m_old_size = evt.GetSize();
}

bool wxRibbonPage::Layout()
{
	if(GetChildren().GetCount() == 0)
	{
		return true;
	}

	wxPoint origin_(m_art->GetMetric(wxRIBBON_ART_PAGE_BORDER_LEFT_SIZE), m_art->GetMetric(wxRIBBON_ART_PAGE_BORDER_TOP_SIZE));
	wxPoint origin(origin_);
	wxOrientation major_axis = GetMajorAxis();
	int gap;
	int minor_axis_size;
	if(major_axis == wxHORIZONTAL)
	{
		gap = m_art->GetMetric(wxRIBBON_ART_PANEL_X_SEPARATION_SIZE);
		minor_axis_size = GetSize().GetHeight() - origin.y - m_art->GetMetric(wxRIBBON_ART_PAGE_BORDER_BOTTOM_SIZE);
	}
	else
	{
		gap = m_art->GetMetric(wxRIBBON_ART_PANEL_Y_SEPARATION_SIZE);
		minor_axis_size = GetSize().GetWidth() - origin.x - m_art->GetMetric(wxRIBBON_ART_PAGE_BORDER_RIGHT_SIZE);
	}

	for(int iteration = 1; iteration <= 2; ++iteration)
	{
		for ( wxWindowList::compatibility_iterator node = GetChildren().GetFirst();
			  node;
			  node = node->GetNext() )
		{
			wxWindow* child = node->GetData();
			if(child == m_scroll_left_btn || child == m_scroll_right_btn)
				continue;
			int w, h;
			child->GetSize(&w, &h);
			if(major_axis == wxHORIZONTAL)
			{
				child->SetSize(origin.x, origin.y, w, minor_axis_size);
				origin.x += w + gap;
			}
			else
			{
				child->SetSize(origin.x, origin.y, minor_axis_size, h);
				origin.y += h + gap;
			}
		}
		if(iteration == 1)
		{
			int available_space;
			if(major_axis == wxHORIZONTAL)
				available_space = GetSize().GetWidth() - m_art->GetMetric(wxRIBBON_ART_PAGE_BORDER_RIGHT_SIZE) - origin.x + gap;
			else
				available_space = GetSize().GetHeight() - m_art->GetMetric(wxRIBBON_ART_PAGE_BORDER_BOTTOM_SIZE) - origin.y + gap;
			if(available_space > 0)
			{
				if(!ExpandPanels(major_axis, available_space))
					break;
			}
			else if(available_space < 0)
			{
				if(m_scroll_buttons_visible)
				{
					// Scroll buttons already visible - not going to be able to downsize any more
					m_scroll_amount_limit = -available_space;
				}
				else
				{
					if(!CollapsePanels(major_axis, -available_space))
					{
						m_scroll_amount_limit = -available_space;
						ShowScrollButtons();
						break;
					}
				}
			}
			else
			{
				break;
			}
			origin = origin_; // Reset the origin
		}
	}

	return true;
}

void wxRibbonPage::ShowScrollButtons()
{
	bool show_left = true;
	bool show_right = true;
	bool reposition = false;
	m_scroll_buttons_visible = true;
	if(m_scroll_amount == 0)
	{
		show_left = false;
	}
	if(m_scroll_amount >= m_scroll_amount_limit)
	{
		show_right = false;
		m_scroll_amount = m_scroll_amount_limit;
	}

	if(show_left)
	{
		if(m_scroll_left_btn == NULL)
		{
			wxMemoryDC temp_dc;
			wxSize size;
			long direction;
			if(GetMajorAxis() == wxHORIZONTAL)
			{
				direction = wxRIBBON_SCROLL_BTN_LEFT;
				size = m_art->GetScrollButtonMinimumSize(temp_dc, GetParent(), direction);
				size.SetHeight(GetSize().GetHeight());
			}
			else
			{
				direction = wxRIBBON_SCROLL_BTN_UP;
				size = m_art->GetScrollButtonMinimumSize(temp_dc, GetParent(), direction);
				size.SetWidth(GetSize().GetWidth());
			}
			m_scroll_left_btn = new wxRibbonPageScrollButton(GetParent(), wxID_ANY, wxDefaultPosition, size, direction);
			reposition = true;
		}
	}
	else
	{
		if(m_scroll_left_btn != NULL)
		{
			delete m_scroll_left_btn;
			m_scroll_left_btn = NULL;
			reposition = true;
		}
	}

	if(show_right)
	{
		if(m_scroll_right_btn == NULL)
		{
			wxMemoryDC temp_dc;
			wxSize size;
			long direction;
			if(GetMajorAxis() == wxHORIZONTAL)
			{
				direction = wxRIBBON_SCROLL_BTN_RIGHT;
				size = m_art->GetScrollButtonMinimumSize(temp_dc, GetParent(), direction);
				size.SetHeight(GetSize().GetHeight());
			}
			else
			{
				direction = wxRIBBON_SCROLL_BTN_DOWN;
				size = m_art->GetScrollButtonMinimumSize(temp_dc, GetParent(), direction);
				size.SetWidth(GetSize().GetWidth());
			}
			m_scroll_right_btn = new wxRibbonPageScrollButton(GetParent(), wxID_ANY, wxDefaultPosition, size, direction);
			reposition = true;
		}
	}
	else
	{
		if(m_scroll_right_btn != NULL)
		{
			delete m_scroll_right_btn;
			m_scroll_right_btn = NULL;
			reposition = true;
		}
	}

	if(reposition)
	{
		wxDynamicCast(GetParent(), wxRibbonBar)->RepositionPage(this);
	}
}

static int GetSizeInOrientation(wxSize size, wxOrientation orientation)
{
	switch(orientation)
	{
	case wxHORIZONTAL: return size.GetWidth();
	case wxVERTICAL: return size.GetHeight();
	case wxBOTH: return size.GetWidth() * size.GetHeight();
	default: return 0;
	}
}

bool wxRibbonPage::ExpandPanels(wxOrientation direction, int maximum_amount)
{
	bool expanded_something = false;
	while(maximum_amount > 0)
	{
		int smallest_size = INT_MAX;
		wxRibbonPanel* smallest_panel = NULL;
		for ( wxWindowList::compatibility_iterator node = GetChildren().GetFirst();
				  node;
				  node = node->GetNext() )
		{
			wxRibbonPanel* panel = wxDynamicCast(node->GetData(), wxRibbonPanel);
			if(panel == NULL)
			{
				continue;
			}
			if(panel->IsSizingContinuous())
			{
				int size = GetSizeInOrientation(panel->GetSize(), direction);
				if(size < smallest_size)
				{
					smallest_size = size;
					smallest_panel = panel;
				}
			}
			else
			{
				wxSize current = panel->GetSize();
				int size = GetSizeInOrientation(current, direction);
				if(size < smallest_size)
				{
					wxSize larger = panel->GetNextLargerSize(direction);
					if(larger != current && GetSizeInOrientation(larger, direction) > size)
					{
						smallest_size = size;
						smallest_panel = panel;
					}
				}
			}
		}
		if(smallest_panel != NULL)
		{
			if(smallest_panel->IsSizingContinuous())
			{
				wxSize size = smallest_panel->GetSize();
				int amount = maximum_amount;
				if(amount > 32)
				{
					// For "large" growth, grow this panel a bit, and then re-allocate
					// the remainder (which may come to this panel again anyway)
					amount = 32;
				}
				if(direction & wxHORIZONTAL)
				{
					size.x += amount;
				}
				if(direction & wxVERTICAL)
				{
					size.y += amount;
				}
				smallest_panel->SetSize(size);
				maximum_amount -= amount;
				expanded_something = true;
			}
			else
			{
				wxSize current = smallest_panel->GetSize();
				wxSize larger = smallest_panel->GetNextLargerSize(direction);
				wxSize delta = larger - current;
				if(GetSizeInOrientation(delta, direction) <= maximum_amount)
				{
					smallest_panel->SetSize(larger);
					maximum_amount -= GetSizeInOrientation(delta, direction);
					expanded_something = true;
				}
				else
				{
					break;
				}
			}
		}
		else
		{
			break;
		}
	}
	if(expanded_something)
	{
		Refresh();
		return true;
	}
	else
	{
		return false;
	}
}

bool wxRibbonPage::CollapsePanels(wxOrientation direction, int minimum_amount)
{
	bool collapsed_something = false;
	while(minimum_amount > 0)
	{
		int largest_size = 0;
		wxRibbonPanel* largest_panel = NULL;
		for ( wxWindowList::compatibility_iterator node = GetChildren().GetFirst();
				  node;
				  node = node->GetNext() )
		{
			wxRibbonPanel* panel = wxDynamicCast(node->GetData(), wxRibbonPanel);
			if(panel == NULL)
			{
				continue;
			}
			if(panel->IsSizingContinuous())
			{
				int size = GetSizeInOrientation(panel->GetSize(), direction);
				if(size > largest_size)
				{
					largest_size = size;
					largest_panel = panel;
				}
			}
			else
			{
				wxSize current = panel->GetSize();
				int size = GetSizeInOrientation(current, direction);
				if(size > largest_size)
				{
					wxSize smaller = panel->GetNextSmallerSize(direction);
					if(smaller != current && GetSizeInOrientation(smaller, direction) < size)
					{
						largest_size = size;
						largest_panel = panel;
					}
				}
			}
		}
		if(largest_panel != NULL)
		{
			if(largest_panel->IsSizingContinuous())
			{
				wxSize size = largest_panel->GetSize();
				int amount = minimum_amount;
				if(amount > 32)
				{
					// For "large" contraction, reduce this panel a bit, and then re-allocate
					// the remainder of the quota (which may come to this panel again anyway)
					amount = 32;
				}
				if(direction & wxHORIZONTAL)
				{
					size.x -= amount;
				}
				if(direction & wxVERTICAL)
				{
					size.y -= amount;
				}
				largest_panel->SetSize(size);
				minimum_amount -= amount;
				collapsed_something = true;
			}
			else
			{
				wxSize current = largest_panel->GetSize();
				wxSize smaller = largest_panel->GetNextSmallerSize(direction);
				wxSize delta = current - smaller;
				largest_panel->SetSize(smaller);
				minimum_amount -= GetSizeInOrientation(delta, direction);
				collapsed_something = true;
			}
		}
		else
		{
			break;
		}
	}
	if(collapsed_something)
	{
		Refresh();
		return true;
	}
	else
	{
		return false;
	}
}

wxSize wxRibbonPage::GetMinSize() const
{
	wxSize min(wxDefaultCoord, wxDefaultCoord);

	for ( wxWindowList::compatibility_iterator node = GetChildren().GetFirst();
          node;
          node = node->GetNext() )
    {
        wxWindow* child = node->GetData();
		wxSize child_min(child->GetMinSize());

		min.x = wxMax(min.x, child_min.x);
		min.y = wxMax(min.y, child_min.y);
	}

	if(GetMajorAxis() == wxHORIZONTAL)
	{
		min.x = wxDefaultCoord;
		if(min.y != wxDefaultCoord)
		{
			min.y += m_art->GetMetric(wxRIBBON_ART_PAGE_BORDER_TOP_SIZE) + m_art->GetMetric(wxRIBBON_ART_PAGE_BORDER_BOTTOM_SIZE);
		}
	}
	else
	{
		if(min.x != wxDefaultCoord)
		{
			min.x += m_art->GetMetric(wxRIBBON_ART_PAGE_BORDER_LEFT_SIZE) + m_art->GetMetric(wxRIBBON_ART_PAGE_BORDER_RIGHT_SIZE);
		}
		min.y = wxDefaultCoord;
	}

	return min;
}

wxSize wxRibbonPage::DoGetBestSize() const
{
	wxSize best(0, 0);
	size_t count = 0;

	if(GetMajorAxis() == wxHORIZONTAL)
	{
		best.y = wxDefaultCoord;

		for ( wxWindowList::compatibility_iterator node = GetChildren().GetFirst();
          node;
          node = node->GetNext() )
		{
			wxWindow* child = node->GetData();
			wxSize child_best(child->GetBestSize());

			if(child_best.x != wxDefaultCoord)
			{
				best.IncBy(child_best.x, 0);
			}
			best.y = wxMax(best.y, child_best.y);

			++count;
		}

		if(count > 1)
		{
			best.IncBy((count - 1) * m_art->GetMetric(wxRIBBON_ART_PANEL_X_SEPARATION_SIZE), 0);
		}
	}
	else
	{
		best.x = wxDefaultCoord;

		for ( wxWindowList::compatibility_iterator node = GetChildren().GetFirst();
          node;
          node = node->GetNext() )
		{
			wxWindow* child = node->GetData();
			wxSize child_best(child->GetBestSize());

			best.x = wxMax(best.x, child_best.x);
			if(child_best.y != wxDefaultCoord)
			{
				best.IncBy(0, child_best.y);
			}

			++count;
		}

		if(count > 1)
		{
			best.IncBy(0, (count - 1) * m_art->GetMetric(wxRIBBON_ART_PANEL_Y_SEPARATION_SIZE));
		}
	}

	if(best.x != wxDefaultCoord)
	{
		best.x += m_art->GetMetric(wxRIBBON_ART_PAGE_BORDER_LEFT_SIZE) + m_art->GetMetric(wxRIBBON_ART_PAGE_BORDER_RIGHT_SIZE);
	}
	if(best.y != wxDefaultCoord)
	{
		best.y += m_art->GetMetric(wxRIBBON_ART_PAGE_BORDER_TOP_SIZE) + m_art->GetMetric(wxRIBBON_ART_PAGE_BORDER_BOTTOM_SIZE);
	}
	return best;
}

#endif // wxUSE_RIBBON
