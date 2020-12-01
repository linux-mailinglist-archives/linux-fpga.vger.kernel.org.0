Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C362CAB30
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Dec 2020 19:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389825AbgLAS5P (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Dec 2020 13:57:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32993 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389587AbgLAS5P (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Dec 2020 13:57:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so1728311pfn.0;
        Tue, 01 Dec 2020 10:56:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YKCXY2j5oTNkajj8M5PivSrG0GtC7IKW6J3aPXWeG94=;
        b=k3Ibw3AL57AM9QgMg1Npriz0O8XyQhHmaX7otGQAjDe86+EcZ4O15RRYnyN3s7XQAz
         Pu21h6K8BI6vpggt2jUb3ExLXQSG95t3S+sHGOgGNGa0IIo0dhZ6s+WmR6a2EK1ig24S
         hI0iq0pZIHzGDDgnkGGjhX/1BY0guyGtKJZzHcR5mOtV4BXqjjkm9ALh7Orf3fmFcPMy
         sPx5yz9sIgb8xoc3X9GY4jtin2hcnhvs0dIIWqj/QAEcGhXyN5jOL/0xz75vpYx6RQ7r
         RFFg7jypwLr51uJGqPoREYtfPKQSfRxJjNyjV+K0NW3ZnzxSoFSeSHrn9jn9PV2HSySz
         8MXQ==
X-Gm-Message-State: AOAM533MNBrLXWu6yXyAODf7UeTyJsKQetYLBCzNKfs8WNyWOQ1NUE2w
        MR6+SMKp1s1rXcVoljSG800=
X-Google-Smtp-Source: ABdhPJxP1CkhHrenopvT6IY8Nj6PYRan75NEpJq1la6SUHMkmn3ElsmhHeWnLNoCbXPM25k7vlWfbQ==
X-Received: by 2002:a62:f901:0:b029:160:b5d:fc40 with SMTP id o1-20020a62f9010000b02901600b5dfc40mr3765983pfh.55.1606848993678;
        Tue, 01 Dec 2020 10:56:33 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id y6sm300085pgg.80.2020.12.01.10.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 10:56:32 -0800 (PST)
Date:   Tue, 1 Dec 2020 10:56:31 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     matthew.gerlach@linux.intel.com
Cc:     "Wu, Hao" <hao.wu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v3 2/2] fpga: dfl: look for vendor specific capability
Message-ID: <X8aR36hGoV9SsPDw@archbook>
References: <20201124155658.700976-1-matthew.gerlach@linux.intel.com>
 <20201124155658.700976-3-matthew.gerlach@linux.intel.com>
 <DM6PR11MB38191D8C5E27E6E04B8DAA1A85F70@DM6PR11MB3819.namprd11.prod.outlook.com>
 <alpine.DEB.2.22.394.2011301614040.1050045@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2011301614040.1050045@rhweight-WRK1>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Matthew,

On Mon, Nov 30, 2020 at 04:45:20PM -0800, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Sat, 28 Nov 2020, Wu, Hao wrote:
> 
> > > Subject: [PATCH v3 2/2] fpga: dfl: look for vendor specific capability
> > 
> > Maybe we can change the title a little bit, what about
> > fpga: dfl-pci: locate DFLs by PCIe vendor specific capability
> > 
> > > 
> > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > 
> > > A DFL may not begin at offset 0 of BAR 0.  A PCIe vendor
> > > specific capability can be used to specify the start of a
> > > number of DFLs.
> > 
> > A PCIe vendor specific extended capability is introduced by Intel to
> > specify the start of a number of DFLs.
> 
> Your suggestion is more precise.
> > 
> > 
> > > 
> > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > ---
> > > v3: Add text and ascii art to documentation.
> > >     Ensure not to exceed PCIe config space in loop.
> > > 
> > > v2: Update documentation for clarity.
> > >     Clean up  macro names.
> > >     Use GENMASK.
> > >     Removed spurious blank lines.
> > >     Changed some calls from dev_info to dev_dbg.
> > >     Specifically check for VSEC not found, -ENODEV.
> > >     Ensure correct pci vendor id.
> > >     Remove check for page alignment.
> > >     Rename find_dfl_in_cfg to find_dfls_by_vsec.
> > >     Initialize target memory of pci_read_config_dword to invalid values before
> > > use.
> > > ---
> > >  Documentation/fpga/dfl.rst | 25 +++++++++++
> > >  drivers/fpga/dfl-pci.c     | 91 +++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 115 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > > index 0404fe6ffc74..fa0da884a818 100644
> > > --- a/Documentation/fpga/dfl.rst
> > > +++ b/Documentation/fpga/dfl.rst
> > > @@ -501,6 +501,31 @@ Developer only needs to provide a sub feature
> > > driver with matched feature id.
> > >  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-
> > > pr.c)
> > >  could be a reference.
> > > 
> > > +Location of DFLs on a PCI Device
> > > +===========================
> > > +There are two ways of locating DFLs on a PCI Device.  The original
> > 
> > I found this new VSEC is only for PCIe device, correct? If so, let's make
> > sure descriptions are accurate. E.g. default method for all devices
> > and a new method for PCIe device.
> 
> Yes, the default method can be used with PCI and PCIe device, and the VSEC
> approach is PCIe, only.  Documentation can be made more precise.
> 
> > 
> > > +method assumed the start of the first DFL to offset 0 of bar 0.
> > > +If the first node of the DFL is an FME, then further DFLs
> > > +in the port(s) are specified in FME header registers.
> > > +Alternatively, a vendor specific capability structure can be used to
Maybe: a vendor specific extended capability (VSEC) ...
> > > +specify the location of all the DFLs on the device, providing flexibility
> > > +for the type of starting node in the DFL.  Intel has reserved the
> > > +VSEC ID of 0x43 for this purpose.  The vendor specific
> > > +data begins with a 4 byte vendor specific register for the number of DFLs
> > > followed 4 byte
> > > +Offset/BIR vendor specific registers for each DFL. Bits 2:0 of Offset/BIR
> > > register
> > 
> > Do we have a defined register name here? or it's named as Offset/BIR register?
> > Sounds a little wired, and I see you defined it as DFLS_RES?
> 
> The Offset/BIR terminology is also used in the MSI-X capability structure.

Yeah, this intuitively made sense to me having worked with PCIe :)
> 
> > 
> > > +indicates the BAR, and bits 31:3 form the 8 byte aligned offset where bits
> > > 2:0 are
> > > +zero.
> > > +
> > > +        +----------------------------+
> > > +        |31     Number of DFLS      0|
> > > +        +----------------------------+
> > > +        |31     Offset     3|2 BIR  0|
> > > +        +----------------------------+
> > > +                      . . .
> > > +        +----------------------------+
> > > +        |31     Offset     3|2 BIR  0|
> > > +        +----------------------------+
> > > +
> > 
> > Maybe it's better to have register name and offset in above table.
> > BTW: if there is some public link to related spec, that helps too.
> 
> I'll consider adding a register name and offset, but I am not sure it adds
> much information.

I think this is fine together with textual description you have above.
> 
> > 
> > > 
> > >  Open discussion
> > >  ===============
> > > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > > index b27fae045536..a58bf4299d6b 100644
> > > --- a/drivers/fpga/dfl-pci.c
> > > +++ b/drivers/fpga/dfl-pci.c
> > > @@ -27,6 +27,14 @@
> > >  #define DRV_VERSION	"0.8"
> > >  #define DRV_NAME	"dfl-pci"
> > > 
> > > +#define PCI_VSEC_ID_INTEL_DFLS 0x43
> > > +
> > > +#define PCI_VNDR_DFLS_CNT 8
> > > +#define PCI_VNDR_DFLS_RES 0x0c
> > 
> > They are both register offset? it's better to use the same style.
> > 
> > 0x8
> > 0xc
> > 
> > Something like this.
> 
> Agrreed.
> > 
> > > +
> > > +#define PCI_VNDR_DFLS_RES_BAR_MASK GENMASK(2, 0)
> > > +#define PCI_VNDR_DFLS_RES_OFF_MASK GENMASK(31, 3)
> > > +
> > >  struct cci_drvdata {
> > >  	struct dfl_fpga_cdev *cdev;	/* container device */
> > >  };
> > > @@ -119,6 +127,84 @@ static int *cci_pci_create_irq_table(struct pci_dev
> > > *pcidev, unsigned int nvec)
> > >  	return table;
> > >  }
> > > 
> > > +static int find_dfls_by_vsec(struct pci_dev *pcidev, struct
> > > dfl_fpga_enum_info *info)
> > > +{
> > > +	u32 bar, offset, vndr_hdr, dfl_cnt, dfl_res;
> > > +	int dfl_res_off, i, voff = 0;
> > > +	resource_size_t start, len;
> > > +
> > > +	if (pcidev->vendor != PCI_VENDOR_ID_INTEL)
> > > +		return -ENODEV;
> > 
> > Check it later then other vendor can add their ones easily?
> > 
> > > +
> > > +	while ((voff = pci_find_next_ext_capability(pcidev, voff,
> > > PCI_EXT_CAP_ID_VNDR))) {
> > > +		vndr_hdr = 0;
> > 
> > It seems it doesn't need this.
> 
> Initializing vndr_hdr = 0 ensures a failed pci_read_config_dword() failure
> is handled properly.  I will remove the call and the debug information
> anyway.
> 
>  >
> > > +		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER,
> > > &vndr_hdr);
> > > +
> > > +		dev_dbg(&pcidev->dev,
> > > +			"vendor-specific capability id 0x%x, rev 0x%x len
> > > 0x%x\n",
> > > +			PCI_VNDR_HEADER_ID(vndr_hdr),
> > > +			PCI_VNDR_HEADER_REV(vndr_hdr),
> > > +			PCI_VNDR_HEADER_LEN(vndr_hdr));
> > 
> > Suggest remove this debug information.
> > 
> > > +
> > > +		if (PCI_VNDR_HEADER_ID(vndr_hdr) ==
> > > PCI_VSEC_ID_INTEL_DFLS)
> > 
> > How about
> > 		if (vendor == intel && header_id == INTEL_DFLS)
> > 			break;
> Seems reasonable.
> > 
> > > +			break;
> > > +	}
> > > +
> > > +	if (!voff) {
> > > +		dev_dbg(&pcidev->dev, "%s no VSEC found\n", __func__);
> > 
> > No DFL VSEC found
> > 
> > There could be many different VSECs but no DFL ones.
> 
> Agreed.
> > 
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	dfl_cnt = 0;
> > 
> > Can be merged into the line which defines dfl_cnt? Or we can just
> > remove this line.
> 
> This initialization ensures that a failure to the pci_read_config_dword
> function below is handled properly.  It can be merged into the definition
> line.
> 
> > 
> > > +	pci_read_config_dword(pcidev, voff + PCI_VNDR_DFLS_CNT,
> > > &dfl_cnt);
> > > +	dev_dbg(&pcidev->dev, "dfl_cnt %d\n", dfl_cnt);
> > > +	for (i = 0; i < dfl_cnt; i++) {
> > > +		dfl_res_off = voff + PCI_VNDR_DFLS_RES +
> > > +				      (i * sizeof(dfl_res));
> > 
> > Above two line can be put into one line, it's < 80 length.
> 
> Agreed.
> 
> > 
> > > +		if (dfl_res_off >= PCI_CFG_SPACE_EXP_SIZE) {
> > > +			dev_err(&pcidev->dev, "%s offset too big for PCIe
> > > config space\n",
> > > +				__func__);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		dfl_res = GENMASK(31, 0);
> > 
> > do we really need this?
> 
> Again, the assignment is ensuring that a failure to the
> pci_read_config_dword function is handled properly.
> 
> > 
> > > +		pci_read_config_dword(pcidev, dfl_res_off, &dfl_res);
> > > +
> > > +		dev_dbg(&pcidev->dev, "dfl_res 0x%x\n", dfl_res);
> > 
> > Can be read by lspci even without driver, so we may not really need this
> > debug information here.
> 
> 
> I suppose the call to dev_dbg can be removed.
> 
> > 
> > > +
> > > +		bar = dfl_res & PCI_VNDR_DFLS_RES_BAR_MASK;
> > > +		if (bar >= PCI_STD_NUM_BARS) {
> > > +			dev_err(&pcidev->dev, "%s bad bar number %d\n",
> > > +				__func__, bar);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		len = pci_resource_len(pcidev, bar);
> > > +		if (len == 0) {
> > > +			dev_err(&pcidev->dev, "%s unmapped bar
> > > number %d\n",
> > > +				__func__, bar);
> > > +			return -EINVAL;
> > 
> > can be covered by below case, as mentioned in previous patch.
> Agreed, I forgot to remove it.
> > 
> > > +		}
> > > +
> > > +		offset = dfl_res & PCI_VNDR_DFLS_RES_OFF_MASK;
> > > +		if (offset >= len) {
> > > +			dev_err(&pcidev->dev, "%s bad offset %u >= %pa\n",
> > > +				__func__, offset, &len);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		dev_dbg(&pcidev->dev, "%s BAR %d offset 0x%x\n",
> > > __func__, bar, offset);
> > > +
> > > +		len -= offset;
> > > +
> > > +		start = pci_resource_start(pcidev, bar) + offset;
> > > +
> > > +		dfl_fpga_enum_info_add_dfl(info, start, len);
> > 
> > That means everytime, we pass [start, endofbar] region to dfl core
> > for enumeration, if there are multiple DFLs in one bar, then each range
> > ends at the same endofbar, it seems fine as enumeration can be done
> > one by one, but ideally the best case is that this capability can provide
> > end address or size too, right? It is possible that information can be
> > added to the capability as well? then we don't have such limitation.
> > 
> > Hao
> 
> I am not sure having more than one DFL in a bar serves any purpose over a
> single DFL.  Regardless, I think the consistency of just having Offset/BIR
> in the VSEC is better than adding more infomation that has little or no
> added value.

Agreed. Can't you just link the DFLs in that case?
> 
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int find_dfls_by_default(struct pci_dev *pcidev,
> > >  				struct dfl_fpga_enum_info *info)
> > >  {
> > > @@ -220,7 +306,10 @@ static int cci_enumerate_feature_devs(struct
> > > pci_dev *pcidev)
> > >  			goto irq_free_exit;
> > >  	}
> > > 
> > > -	ret = find_dfls_by_default(pcidev, info);
> > > +	ret = find_dfls_by_vsec(pcidev, info);
> > > +	if (ret == -ENODEV)
> > > +		ret = find_dfls_by_default(pcidev, info);
> > > +
> > >  	if (ret)
> > >  		goto irq_free_exit;
> > > 
> > > --
> > > 2.25.2
> > 
> > 

- Moritz
