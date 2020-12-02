Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9F62CB29B
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Dec 2020 03:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgLBCF1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Dec 2020 21:05:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:12596 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgLBCF1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 1 Dec 2020 21:05:27 -0500
IronPort-SDR: wbn+5yo2l6S8Y75RZSo6elGDSmpAph7lldN6mldgsUoNZOvKqTSwcg1WpAj9c2eCyWJbfsYyqq
 s9K2sZ05RzbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="160710050"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="160710050"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 18:04:35 -0800
IronPort-SDR: WRuwfisFSEEiOt8jq1p1m8Z0fSCjGEh3qBAHm+NTa4mbKgfnHv/rO7NxRHXeV2MUmx8gd6hlwB
 QFC0vFvY7w9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="365073732"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 01 Dec 2020 18:04:32 -0800
Date:   Wed, 2 Dec 2020 10:00:03 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     matthew.gerlach@linux.intel.com, "Wu, Hao" <hao.wu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v3 2/2] fpga: dfl: look for vendor specific capability
Message-ID: <20201202020003.GB22103@yilunxu-OptiPlex-7050>
References: <20201124155658.700976-1-matthew.gerlach@linux.intel.com>
 <20201124155658.700976-3-matthew.gerlach@linux.intel.com>
 <DM6PR11MB38191D8C5E27E6E04B8DAA1A85F70@DM6PR11MB3819.namprd11.prod.outlook.com>
 <alpine.DEB.2.22.394.2011301614040.1050045@rhweight-WRK1>
 <X8aR36hGoV9SsPDw@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8aR36hGoV9SsPDw@archbook>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > > 
> > > > +		}
> > > > +
> > > > +		offset = dfl_res & PCI_VNDR_DFLS_RES_OFF_MASK;
> > > > +		if (offset >= len) {
> > > > +			dev_err(&pcidev->dev, "%s bad offset %u >= %pa\n",
> > > > +				__func__, offset, &len);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +
> > > > +		dev_dbg(&pcidev->dev, "%s BAR %d offset 0x%x\n",
> > > > __func__, bar, offset);
> > > > +
> > > > +		len -= offset;
> > > > +
> > > > +		start = pci_resource_start(pcidev, bar) + offset;
> > > > +
> > > > +		dfl_fpga_enum_info_add_dfl(info, start, len);
> > > 
> > > That means everytime, we pass [start, endofbar] region to dfl core
> > > for enumeration, if there are multiple DFLs in one bar, then each range
> > > ends at the same endofbar, it seems fine as enumeration can be done
> > > one by one, but ideally the best case is that this capability can provide
> > > end address or size too, right? It is possible that information can be
> > > added to the capability as well? then we don't have such limitation.
> > > 
> > > Hao
> > 
> > I am not sure having more than one DFL in a bar serves any purpose over a
> > single DFL.  Regardless, I think the consistency of just having Offset/BIR
> > in the VSEC is better than adding more infomation that has little or no
> > added value.
> 
> Agreed. Can't you just link the DFLs in that case?

I didn't see the value of more DFLs in one bar either. So I think we'd better
document it.

Thanks,
Yilun
